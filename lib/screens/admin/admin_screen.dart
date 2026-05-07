import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/routes.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const .all(16),
      child: Column(
        spacing: 16,
        children: [
          const Text(
            'Administration',
            style: TextStyle(
              fontSize: 24,
              fontWeight: .bold,
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Users'),
              onTap: () {
                context.push(rtAdminUsers);
              },
            ),
          ),
        ],
      ),
    );
  }
}
