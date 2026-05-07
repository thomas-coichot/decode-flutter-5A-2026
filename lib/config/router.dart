import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../helpers/middlewares.dart';
import '../notifiers/session_notifier.dart';
import '../screens/account/account.dart';
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
  debugLogDiagnostics: true,
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
      redirect: isAuthenticated,
      pageBuilder: (context, state) => buildPage(
        context,
        state,
        const HomeScreen(),
      ),
    ),
    GoRoute(
      path: rtAccount,
      redirect: (context, state) {
        final session = context.read<SessionNotifier>();

        if(session.isAuthenticated){
          return null;
        }

        return rtLogin;
      },
      pageBuilder: (context, state) => buildPage(
        context,
        state,
        const AccountScreen(),
      ),
    ),

  ],
);
