import 'package:material_ui/material_ui.dart';
import 'package:material_ui_migration/core/demo_data.dart';
import 'package:material_ui_migration/l10n/app_localizations.dart';

/// Second route, reached through a `MaterialPageRoute`.
///
/// `MaterialPageRoute` is one of the classes `material_ui` has already changed
/// since the fork: version 1.3.0 added an option to opt out of the semantics
/// route scope. Keeping a real route here means the before / after comparison
/// covers navigation, not only static screens.
class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.detailTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              l10n.residentCount(DemoData.residents),
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(l10n.lastSync(DemoData.lastSync)),
            const Spacer(),
            // Reads a Material type through the context, which is the case the
            // compatibility bridge is designed to cover.
            Text(
              l10n.sectionOccupancy,
              style: TextStyle(color: theme.colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }
}
