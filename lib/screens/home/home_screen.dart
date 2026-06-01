import 'package:flutter/material.dart';

import '../admin/admin_screen.dart';
import 'home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  Widget _body(int index) {
    switch (index) {
      case 0:
        return const Home();
      case 1:
        return const AdminScreen();
      default:
        throw UnimplementedError('Index $index not implemented');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      key: const ValueKey('home_screen'),
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: _body(_index),
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: .onlyShowSelected,
        selectedIndex: _index,
        onDestinationSelected: (int index) {
          setState(() {
            _index = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.explore), label: 'Explore'),
          NavigationDestination(
            icon: Icon(Icons.admin_panel_settings),
            label: 'Admin',
          ),
        ],
      ),
    );
  }
}
