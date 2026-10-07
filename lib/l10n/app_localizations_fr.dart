// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Gestion de résidence';

  @override
  String get dashboardTitle => 'Tableau de bord';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get sectionOccupancy => 'Occupation';

  @override
  String get sectionPreferences => 'Préférences';

  @override
  String get searchLabel => 'Rechercher un résident';

  @override
  String get metricResidents => 'Résidents';

  @override
  String get metricSync => 'Synchronisation';

  @override
  String get sectionArchive => 'Archives';

  @override
  String get statusActive => 'Actif';

  @override
  String residentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count résidents',
      one: '1 résident',
      zero: 'Aucun résident',
    );
    return '$_temp0';
  }

  @override
  String lastSync(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Dernière synchronisation : $dateString';
  }

  @override
  String get languageLabel => 'Langue';

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageFrench => 'Français';

  @override
  String get notificationsLabel => 'Notifications';

  @override
  String get openDetail => 'Voir le détail';

  @override
  String get detailTitle => 'Bâtiment A';

  @override
  String get confirmTitle => 'Supprimer ce rapport ?';

  @override
  String get confirmBody => 'Cette action est irréversible.';

  @override
  String get deleteAction => 'Supprimer';
}
