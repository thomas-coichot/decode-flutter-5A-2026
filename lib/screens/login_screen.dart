import 'package:flutter/material.dart';

import '../helpers/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _controller = TextEditingController();

  bool _cgu = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _controller.dispose();
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

    print(_emailController.text);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.search),
          ),

        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Text('Spotify'),
            ),
          ],
        ),
      ),
      body: Text('OK'),
    );
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_cgu) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: .floating,
          content: Text('Vous devez accepter les CGU'),
        ),
      );
    }

    print(_emailController.text);
    print(_passwordController.text);
  }
}
