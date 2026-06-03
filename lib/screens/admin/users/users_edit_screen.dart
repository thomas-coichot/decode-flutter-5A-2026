import 'package:flutter/material.dart';

import 'user_form.dart';

class AdminUsersEditScreen extends StatelessWidget {
  const AdminUsersEditScreen({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editer un utilisateur'),
      ),
      body: UserForm(
        id: id,
      ),
    );
  }
}
