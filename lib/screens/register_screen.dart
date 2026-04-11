import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../api/models/user_model.dart';
import '../config/routes.dart';
import '../helpers/validators.dart';
import '../notifiers/session_notifier.dart';
import '../widgets/fields/password_field.dart';
import '../widgets/fields/text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _cgu = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _lastnameController.dispose();
    _firstnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 16,
                children: [
                  const Text('S\'inscrire'),
                  CustomTextField(
                    controller: _emailController,
                    label: 'Email',
                  ),
                  PasswordField(
                    controller: _passwordController,
                    label: 'Mot de passe',
                  ),
                  CustomTextField(
                    controller: _lastnameController,
                    label: 'Nom',
                  ),
                  CustomTextField(
                    controller: _firstnameController,
                    label: 'Prénom',
                  ),
                  Row(
                    crossAxisAlignment: .center,
                    spacing: 16,
                    children: [
                      Switch(
                        value: _cgu,
                        onChanged: (val) {
                          setState(() {
                            _cgu = val;
                          });
                        },
                      ),
                      const Expanded(
                        child: Text(
                          'En cliquant sur ce bouton, vous acceptez les CGU',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: .center,
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: Text('Retour'),
                      ),
                      ElevatedButton(
                        onPressed: _onSubmit,
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_cgu) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: .floating,
          content: Text('Vous devez accepter les CGU'),
        ),
      );
    }

    final session = context.read<SessionNotifier>();

    session.onAuthentication(
      UserModel(
        email: _emailController.text,
        firstname: _firstnameController.text,
        lastname: _lastnameController.text,
        role: RoleUser.user,
      ),
    );

    context.go(rtAdmin);
  }
}
