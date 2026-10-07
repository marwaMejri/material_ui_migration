// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Residence manager';

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get sectionOccupancy => 'Occupancy';

  @override
  String get sectionPreferences => 'Preferences';

  @override
  String get searchLabel => 'Search a resident';

  @override
  String get metricResidents => 'Residents';

  @override
  String get metricSync => 'Synchronisation';

  @override
  String get sectionArchive => 'Archive';

  @override
  String get statusActive => 'Active';

  @override
  String residentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count residents',
      one: '1 resident',
      zero: 'No residents',
    );
    return '$_temp0';
  }

  @override
  String lastSync(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Last sync: $dateString';
  }

  @override
  String get languageLabel => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageFrench => 'French';

  @override
  String get notificationsLabel => 'Notifications';

  @override
  String get openDetail => 'Open details';

  @override
  String get detailTitle => 'Building A';

  @override
  String get confirmTitle => 'Delete this report?';

  @override
  String get confirmBody => 'This cannot be undone.';

  @override
  String get deleteAction => 'Delete';
}
