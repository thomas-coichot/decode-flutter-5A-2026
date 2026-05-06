import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../api/repositories/auth_repository.dart';
import '../config/routes.dart';
import '../helpers/exceptions.dart';
import '../notifiers/session_notifier.dart';
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

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

  void _onSubmit() async {
    final session = context.read<SessionNotifier>();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    try{
      final AuthResponse response = await AuthRepository().authenticate({
        'email': _emailController.text,
        'password': _passwordController.text,
      });

      if (!mounted) {
        return;
      }

      session.onAuthentication(response);

      context.go(rtHome);
    } on ApiException catch(e){
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: .floating,
          content: Text(e.message),
        ),
      );
    }


  }
}
