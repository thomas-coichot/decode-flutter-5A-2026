import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/theme.dart';
import 'notifiers/theme_notifier.dart';
import 'screens/home/home_page.dart';
import 'screens/login_screen.dart';

void main() {
  MultiProvider providers = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeNotifier()),
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

    return MaterialApp(
      title: 'Spotify',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: theme.themeMode,
      home: MyHomePage(title: 'OK', count: 0),
    );
  }
}
