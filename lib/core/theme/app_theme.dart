import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// One place for both design systems.
///
/// `ThemeData` and `CupertinoThemeData` are the two types the compatibility
/// bridge is built to inject through the context. Keeping them together makes
/// the before / after diff easy to read.
abstract final class AppTheme {
  static const Color seed = Color.fromARGB(255, 170, 92, 170);

  static ThemeData get material => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: seed),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      isDense: true,
    ),
  );

  /// Built from the Material scheme so the two sides stay visually consistent.
  static CupertinoThemeData cupertino(ColorScheme scheme) => CupertinoThemeData(
    brightness: scheme.brightness,
    primaryColor: scheme.primary,
  );
}
