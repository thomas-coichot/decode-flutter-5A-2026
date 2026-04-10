import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/routes.dart';
import '../helpers/validators.dart';
import '../widgets/fields/password_field.dart';
import '../widgets/fields/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _cgu = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final inputDecoration = InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: colorScheme.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colorScheme.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 16,
              children: [
                Text('Se connecter'),
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  email: true,
                ),
                PasswordField(
                  controller: _passwordController,
                  label: 'Password',
                ),
                ElevatedButton(
                  onPressed: _onSubmit,
                  child: Text('Submit'),
                ),
                TextButton(
                  onPressed: () {
                    context.push(rtRegister);
                  },
                  child: Text('S\'inscrire'),
                ),
              ],
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

    // CALL HTTP VIA API D'AUTHENTIFIC

    print(_emailController.text);
    print(_passwordController.text);

    context.go(rtAdmin);
  }
}
