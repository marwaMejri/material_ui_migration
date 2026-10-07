import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_ui_migration/app/locale_controller.dart';
import 'package:material_ui_migration/core/theme/app_theme.dart';
import 'package:material_ui_migration/features/dashboard/widgets/section.dart';
import 'package:material_ui_migration/l10n/app_localizations.dart';

import 'widgets/themed_badge.dart';

/// Settings screen. Two jobs:
///
/// * switch the language at runtime, which is the only way to see a
///   localization failure that does not show up in English;
/// * put Material and Cupertino widgets on the same screen, since the two
///   packages migrate separately.
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final LocaleController localeController = LocaleScope.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Section(
            title: l10n.languageLabel,
            children: <Widget>[
              SegmentedButton<Locale>(
                key: const Key('language-selector'),
                segments: <ButtonSegment<Locale>>[
                  ButtonSegment<Locale>(
                    value: const Locale('en'),
                    label: Text(l10n.languageEnglish),
                  ),
                  ButtonSegment<Locale>(
                    value: const Locale('fr'),
                    label: Text(l10n.languageFrench),
                  ),
                ],
                selected: <Locale>{localeController.value},
                onSelectionChanged: (Set<Locale> selection) =>
                    localeController.select(selection.first),
              ),
            ],
          ),

          Section(
            title: l10n.sectionPreferences,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: Text(l10n.notificationsLabel)),
                  CupertinoSwitch(
                    key: const Key('notifications-switch'),
                    value: _notifications,
                    onChanged: (bool value) =>
                        setState(() => _notifications = value),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                // The badge receives a CupertinoThemeData as an argument.
                child: ThemedBadge(
                  theme: AppTheme.cupertino(scheme),
                  label: l10n.statusActive,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
