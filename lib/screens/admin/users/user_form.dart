import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../api/models/user_model.dart';
import '../../../api/repositories/user_repository.dart';
import '../../../helpers/exceptions.dart';
import '../../../services/toast_service.dart';
import '../../../widgets/buttons/loading_button.dart';
import '../../../widgets/fields/choice_field.dart';
import '../../../widgets/fields/password_field.dart';
import '../../../widgets/fields/text_field.dart';

class UserForm extends StatefulWidget {
  const UserForm({this.id, super.key});

  final String? id;

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  List<RoleUser> _roles = [];
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = true;
  bool _isSubmitting = false;

  bool get isEdit => widget.id != null;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _lastnameController.dispose();
    _firstnameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        if (_isLoading)
          const LinearProgressIndicator()
        else
          const SizedBox(height: 2),
        Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const .all(16),
            child: Column(
              spacing: 16,
              crossAxisAlignment: .start,
              children: [
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  email: true,
                ),
                CustomTextField(
                  controller: _lastnameController,
                  label: 'Nom',
                ),
                CustomTextField(
                  controller: _firstnameController,
                  label: 'Prénom',
                ),
                if (!isEdit)
                  PasswordField(
                    controller: _passwordController,
                    label: 'Mot de passe',
                  ),
                ChoicesField<RoleUser>(
                  label: 'Rôles',
                  selected: _roles,
                  items: RoleUser.values,
                  onSelected: (newRoles) {
                    setState(() {
                      _roles = newRoles;
                    });
                  },
                  getLabel: (e) => e.label,
                  getValue: (e) => e,
                ),
                LoadingButton(
                  isLoading: _isSubmitting,
                  label: 'Confirmer',
                  onPressed: _onSubmit,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _loadData() async {
    if (widget.id == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final response = await const UserRepository().get(widget.id!);

      if (!mounted) {
        return;
      }

      _emailController.text = response.email;
      _lastnameController.text = response.lastname;
      _firstnameController.text = response.firstname;

      setState(() {
        _roles = response.roles;
        _isLoading = false;
      });
    } on ApiException catch (e) {
      ToastService.showToast(e.message);
    }
  }

  void _onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      ToastService.showToast('Des informations sont incorrectes');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final response = await const UserRepository().addOrUpdate(
        id: widget.id,
        data: {
          'email': _emailController.text,
          'lastname': _lastnameController.text,
          'firstname': _firstnameController.text,
          'roles': _roles.map((e) => e.value).toList(),
          'password': _passwordController.text,
        },
      );

      if (!mounted) {
        return;
      }

      ToastService.showToast(
        'L\'utilsateur a été créé avec succès',
        type: .success,
      );

      context.pop();
    } on ApiException catch (e) {
      setState(() {
        _isSubmitting = false;
      });
      ToastService.showToast(e.message);
    }
  }
}
