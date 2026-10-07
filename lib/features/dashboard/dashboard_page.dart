import 'package:flutter/material.dart';
import 'package:material_ui_migration/features/legacy/legacy_summary.dart';

import '../../core/demo_data.dart';
import '../../l10n/app_localizations.dart';
import '../detail/detail_page.dart';
import '../settings/settings_page.dart';
import 'widgets/section.dart';
import 'widgets/stat_card.dart';

/// First screen. Deliberately holds the pieces that break in other people's
/// migration reports:
///
/// * a `TextField`, which is where the kitchenowl app crashed in a non-English
///   locale after migrating (`_TextFieldState._getEffectiveDecoration`);
/// * a plural string and a formatted date, which only look right if the
///   generated localizations resolved for the current locale;
/// * a dialog whose buttons are labelled by `MaterialLocalizations`, not by
///   our own `.arb` files.
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dashboardTitle),
        actions: <Widget>[
          IconButton(
            key: const Key('open-settings'),
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const SettingsPage(),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          // A text field on the first screen, like a login or onboarding form.
          TextField(
            key: const Key('search-field'),
            decoration: InputDecoration(labelText: l10n.searchLabel),
          ),
          const SizedBox(height: 24),

          Section(
            title: l10n.sectionOccupancy,
            children: <Widget>[
              // Both cards receive a ColorScheme as an argument.
              StatCard(
                key: const Key('residents-card'),
                scheme: scheme,
                label: l10n.metricResidents,
                value: l10n.residentCount(DemoData.residents),
              ),
              const SizedBox(height: 8),
              StatCard(
                key: const Key('sync-card'),
                scheme: scheme,
                label: l10n.metricSync,
                value: l10n.lastSync(DemoData.lastSync),
              ),
            ],
          ),
          // Rendered by a file that was never updated. Compiles today,
          // and is the one place the migration will break on purpose.
          Section(
            title: l10n.sectionArchive,
            children: const <Widget>[LegacySummary()],
          ),

          FilledButton(
            key: const Key('open-detail'),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const DetailPage(),
              ),
            ),
            child: Text(l10n.openDetail),
          ),
          const SizedBox(height: 8),

          OutlinedButton(
            key: const Key('open-dialog'),
            onPressed: () => _confirm(context),
            child: Text(l10n.deleteAction),
          ),
        ],
      ),
    );
  }

  Future<void> _confirm(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        // cancelButtonLabel comes from MaterialLocalizations, which the
        // migration moves out of flutter_localizations and into material_ui.
        final MaterialLocalizations material = MaterialLocalizations.of(
          context,
        );

        return AlertDialog(
          title: Text(l10n.confirmTitle),
          content: Text(l10n.confirmBody),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(material.cancelButtonLabel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.deleteAction),
            ),
          ],
        );
      },
    );
  }
}
