import 'package:flutter/material.dart';

import '../../api/models/user_model.dart';
import '../../api/repositories/user_repository.dart';
import '../../widgets/smart_table.dart';

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
          getId: (i) => i.id,
        ),
      ),
    );
  }
}
