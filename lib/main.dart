import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import 'config/router.dart';
import 'config/theme.dart';
import 'notifiers/session_notifier.dart';
import 'notifiers/theme_notifier.dart';
import 'screens/loading_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MultiProvider providers = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ChangeNotifierProvider(create: (_) => SessionNotifier()),
    ],
    child: const MyApp(),
  );

  runApp(providers);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeNotifier theme = context.watch<ThemeNotifier>();

    return ToastificationWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        title: 'Spotify',
        builder: (BuildContext ctx, Widget? child) {
          return LoadingScreen(
            child: child,
          );
        },
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: theme.themeMode,
      ),
    );
  }
}
