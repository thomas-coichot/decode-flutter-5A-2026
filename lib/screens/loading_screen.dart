import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/repositories/auth_repository.dart';
import '../helpers/exceptions.dart';
import '../notifiers/session_notifier.dart';
import '../services/storage_service.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({this.child, super.key});

  final Widget? child;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoading) {
      return widget.child!;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading...'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _loadData() async {
    final session = context.read<SessionNotifier>();

    String? token = await StorageService.get(StorageKey.token);

    if (token == null) {
      setState(() {
        _isLoading = false;
      });

      return;
    }

    try {
      final AuthResponse response = await AuthRepository().refreshUser(token);

      session.onAuthentication(response);

      setState(() {
        _isLoading = false;
      });
    } on ApiException catch (e) {
      // On déconnecte l'utilisateur si le token est invalide ou expiré
      session.logout();
      debugPrint(e.message);
    }
  }
}
