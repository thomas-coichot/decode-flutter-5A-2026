import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/routes.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            if (context.canPop()) {
              return context.pop();
            }
            return context.go(rtLogin);
          },
          child: Text('Retour'),
        ),
      ),
    );
  }
}
