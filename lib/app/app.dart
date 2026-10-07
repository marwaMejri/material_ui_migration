import 'package:material_ui/material_ui.dart';
import 'package:material_ui_migration/core/theme/app_theme.dart';
import 'package:material_ui_migration/features/dashboard/dashboard_page.dart';
import 'package:material_ui_migration/l10n/app_localizations.dart';

import 'locale_controller.dart';

/// Root of the app. Owns the locale and nothing else.
class ResidenceApp extends StatefulWidget {
  const ResidenceApp({super.key, this.initialLocale});

  /// Lets a test start the app in a given language without tapping anything.
  /// Null means English.
  final Locale? initialLocale;

  @override
  State<ResidenceApp> createState() => _ResidenceAppState();
}

class _ResidenceAppState extends State<ResidenceApp> {
  late final LocaleController _localeController = LocaleController(
    widget.initialLocale ?? const Locale('en'),
  );

  @override
  void dispose() {
    _localeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LocaleScope(
      notifier: _localeController,
      child: const _LocalizedApp(),
    );
  }
}

class _LocalizedApp extends StatelessWidget {
  const _LocalizedApp();

  @override
  Widget build(BuildContext context) {
    // Depending on the scope here is what rebuilds MaterialApp when the user
    // changes language in the settings screen.
    final LocaleController localeController = LocaleScope.of(context);

    return MaterialApp(
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.material,
      locale: localeController.value,

      // The only API change of this whole migration, and the only line
      // `dart fix` could not do for us.
      //
      // Before, this was four entries: ours, plus the Material, Cupertino and
      // Widgets delegates from flutter_localizations. `material_ui` ships its
      // own `GlobalMaterialLocalizations`, whose static `delegates` already
      // contains the Cupertino and Widgets ones.
      //
      // Keeping the flutter_localizations import alongside material_ui is what
      // produced the `ambiguous_import` error: two libraries declaring the same
      // name. The import is gone now.
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,

      home: const DashboardPage(),
    );
  }
}
