import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/models/film.dart';
import '../../api/repositories/film_repository.dart';
import '../../helpers/exceptions.dart';
import '../../notifiers/theme_notifier.dart';

const List<String> menus = [
  'Tout',
  'Musique',
  'Podcasts',
  'Livres audios',
  'Films',
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.count});

  final String title;
  final int count;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Film> _items = [];
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final ThemeNotifier theme = context.watch<ThemeNotifier>();

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          spacing: 16,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  const CircleAvatar(
                    child: Text('H'),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ListView(
                        scrollDirection: .horizontal,
                        children: menus
                            .mapIndexed(
                              (int index, e) => Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: FilterChip(
                                  label: Text(e),
                                  onSelected: (bool value) {},
                                  selected: index == 0,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _changeTheme,
                    icon: Icon(
                      theme.themeMode == ThemeMode.dark
                          ? Icons.light_mode
                          : Icons.dark_mode,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                spacing: 4,
                children: _items.map((e) {
                  return Card(
                    child: Container(
                      padding: .all(16),
                      width: .infinity,
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(e.title),
                          Text(e.director),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const .symmetric(horizontal: 8),
              child: Card(
                child: Row(
                  spacing: 16,
                  children: [
                    Image.asset(
                      'assets/image.jpeg',
                      height: 128,
                      width: 128,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16, bottom: 16),
                        child: Column(
                          crossAxisAlignment: .start,
                          mainAxisAlignment: .start,
                          mainAxisSize: .max,
                          children: [
                            Container(
                              margin: const .only(top: 16),
                              child: Text(
                                'Signle',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: colorScheme.outline,
                                ),
                                maxLines: 2,
                              ),
                            ),
                            const Text(
                              'Johnny Mad Dog',
                              maxLines: 2,
                            ),
                            const Text(
                              'Mon texte.......',
                              maxLines: 2,
                            ),
                            Container(
                              margin: const .only(top: 8),
                              child: const Text(
                                'Mon texte.......',
                                maxLines: 2,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: .center,
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add_circle_outline),
                                ),
                                IconButton.filled(
                                  onPressed: () {},
                                  icon: const Icon(Icons.play_arrow_rounded),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: .onlyShowSelected,
        selectedIndex: _index,
        onDestinationSelected: (int index) {
          setState(() {
            _index = index;
          });
        },
        destinations: <Widget>[
          NavigationDestination(icon: Icon(Icons.explore), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.commute), label: 'Commute'),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
        ],
      ),
    );
  }

  void _loadData() async {
    try {
      final response = await FilmRepository().getAll();

      setState(() {
        _items = response.cast<Film>();
      });
    } on ApiException catch (e) {
      debugPrint(e.toString());
    }
  }

  void _changeTheme() {
    final theme = context.read<ThemeNotifier>();

    theme.setThemeMode(
      theme.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
    );
  }
}
