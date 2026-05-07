import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../api/models/user_model.dart';
import '../config/routes.dart';
import '../notifiers/session_notifier.dart';

String? isAdmin(BuildContext context, GoRouterState state) {
  final session = context.read<SessionNotifier>();

  if (session.user?.roles.contains(RoleUser.admin) == true) {
    return null;
  }

  return rtHome;
}

String? isManager(BuildContext context, GoRouterState state) {
  final session = context.read<SessionNotifier>();

  if (session.user?.roles.contains(RoleUser.admin) == true) {
    return null;
  }

  return rtHome;
}

String? isAuthenticated(BuildContext context, GoRouterState state) {
  final session = context.read<SessionNotifier>();

  if (session.isAuthenticated) {
    return null;
  }

  return rtLogin;
}
