import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../config/routes.dart';
import '../../notifiers/theme_notifier.dart';

const List<String> menus = [
  'Tout',
  'Musique',
  'Podcasts',
  'Livres audios',
  'Films',
];

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final ThemeNotifier theme = context.watch<ThemeNotifier>();

    return SingleChildScrollView(
      child: Column(
        spacing: 16,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    context.push(rtAccount);
                  },
                  child: const CircleAvatar(
                    child: Text('H'),
                  ),
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
                  onPressed: () => _changeTheme(context),
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
                              'Single',
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
    );
  }

  void _changeTheme(BuildContext context) {
    final theme = context.read<ThemeNotifier>();

    theme.setThemeMode(
      theme.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
    );
  }
}
