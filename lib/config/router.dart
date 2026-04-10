import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../helpers/middlewares.dart';
import '../screens/admin/admin_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/not_found_screen.dart';
import '../screens/register_screen.dart';
import 'routes.dart';

Page buildPage(BuildContext context, GoRouterState state, Widget child) {
  if (kIsWeb) {
    return NoTransitionPage(child: child);
  }

  return MaterialPage(child: child);
}

final GoRouter router = GoRouter(
  errorPageBuilder: (context, state) => buildPage(
    context,
    state,
    const NotFoundScreen(),
  ),
  initialLocation: rtLogin,
  routes: [
    GoRoute(
      path: rtLogin,
      builder: (context, state) => const LoginScreen(),
      pageBuilder: (context, state) => buildPage(
        context,
        state,
        const LoginScreen(),
      ),
    ),
    GoRoute(
      path: rtRegister,
      pageBuilder: (context, state) => buildPage(
        context,
        state,
        const RegisterScreen(),
      ),
    ),
    GoRoute(
      redirect: isAdmin,
      path: rtAdmin,
      pageBuilder: (context, state) => buildPage(
        context,
        state,
        const AdminScreen(),
      ),
    ),
    GoRoute(
      path: rtHome,
      pageBuilder: (context, state) => buildPage(
        context,
        state,
        const HomeScreen(),
      ),
    ),
  ],
);
