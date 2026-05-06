import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../config/routes.dart';
import '../../notifiers/session_notifier.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Se deconnecter'),
            onTap: () => _onLogout(context),
          ),
        ],
      ),
    );
  }

  void _onLogout(BuildContext context) {
    final session = context.read<SessionNotifier>();

    session.logout();

    context.go(rtLogin);
  }
}
