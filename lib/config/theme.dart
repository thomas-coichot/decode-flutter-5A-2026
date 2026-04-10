import 'package:flutter/material.dart';

ColorScheme buildColorScheme(Brightness brightness) {
  return ColorScheme.fromSeed(
    seedColor: const Color(0xFF1ED760),
    brightness: brightness,
  );
}

final lightColorScheme = buildColorScheme(.light);
final darkColorScheme = buildColorScheme(.dark);

final ThemeData lightTheme = ThemeData(
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: lightColorScheme.surface,
    cardTheme: const CardThemeData(
      clipBehavior: .hardEdge,
    ),
    chipTheme: ChipThemeData(
        backgroundColor: lightColorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: .circular(24),
        )
    )
);

final ThemeData darkTheme = ThemeData(
    colorScheme: darkColorScheme,
    scaffoldBackgroundColor: darkColorScheme.surface,
    cardTheme: const CardThemeData(
      clipBehavior: .hardEdge,
    ),
    chipTheme: ChipThemeData(
        backgroundColor: darkColorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: .circular(24),
        )
    )
);
