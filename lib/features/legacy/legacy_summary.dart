// This file imports the design library directly and on purpose.
//
// It stands for the file everybody has: an older screen, written before the
// rest, that nobody reopened. In the baseline it compiles like any other
// file, because `StatCard` and this widget both get `ColorScheme` from
// `package:flutter/material.dart`.
//
// Its job comes later. Right after `dart fix` rewrites the project, we put
// this one file back the way it was:
//
//   git checkout -- lib/features/legacy/legacy_summary.dart
//
// Now `StatCard` expects a `ColorScheme` from `package:material_ui`, and this
// widget hands it one from `package:flutter/material.dart`. Same name, two
// libraries. That is the error the compatibility bridge cannot repair, and
// the migration guide says so:
//
//   "values from package:flutter/material.dart cannot be assigned to
//    parameters expecting types from package:material_ui"
//
// No third-party package needed to see it. Two imports in one repository are
// enough.

import 'package:flutter/material.dart';
import 'package:material_ui_migration/features/dashboard/widgets/stat_card.dart';
import 'package:material_ui_migration/l10n/app_localizations.dart';

class LegacySummary extends StatelessWidget {
  const LegacySummary({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    // Read here, passed across a widget boundary as an argument.
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return StatCard(
      key: const Key('legacy-card'),
      scheme: scheme,
      label: l10n.sectionArchive,
      value: l10n.residentCount(0),
    );
  }
}
