import 'package:flutter/material.dart';

import 'user_form.dart';

class AdminUsersAddScreen extends StatelessWidget {
  const AdminUsersAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajotuer un utilisateur'),
      ),
      body: UserForm(),
    );
  }
}
