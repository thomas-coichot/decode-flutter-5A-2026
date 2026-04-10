import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/router.dart';
import 'config/theme.dart';
import 'notifiers/session_notifier.dart';
import 'notifiers/theme_notifier.dart';

void main() {
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

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Spotify',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: theme.themeMode,
    );
  }
}
