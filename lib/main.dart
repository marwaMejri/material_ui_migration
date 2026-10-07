// Baseline app, before the migration to package:material_ui.
//
// Everything in this project is here for one reason: it is one of the things
// the Flutter team changed when Material and Cupertino left the SDK. Nothing
// is decoration.
//
//   lib/app/app.dart              the four localization delegates
//   lib/core/ui.dart              an `export` of the design library
//   lib/core/theme/app_theme.dart ThemeData and CupertinoThemeData side by side
//   lib/features/.../stat_card.dart     a design type in a constructor
//   lib/features/.../themed_badge.dart  the Cupertino counterpart
//   lib/l10n/*.arb                translations that go through gen-l10n
//
// Run `flutter test` before touching anything. The suite is the referee.

import 'package:flutter/material.dart';

import 'app/app.dart';

void main() {
  runApp(const ResidenceApp());
}
