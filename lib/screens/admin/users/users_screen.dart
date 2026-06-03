import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../api/models/user_model.dart';
import '../../../api/repositories/user_repository.dart';
import '../../../config/routes.dart';
import '../../../widgets/smart_table/smart_table.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: SafeArea(
        child: SmartTable<UserModel>(
          repository: const UserRepository(),
          titleBuilder: (item) => item.fullName,
          subtitleBuilder: (item) => Text(item.email),
          getId: (i) => i.id,
          routes: SmartTableRoutes(
            editRoute: (item) => '$rtAdminUsers/${item.id}/edit',
            addRoute: '$rtAdminUsers/new',
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('$rtAdminUsers/new');
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
