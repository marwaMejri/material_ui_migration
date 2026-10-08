import 'package:flutter/material.dart' as sdk;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:material_ui_migration/app/app.dart';
import 'package:material_ui_migration/features/dashboard/widgets/section.dart';

/// lib/core/ui.dart still exports package:flutter/material.dart, because
/// `dart fix` does not rewrite `export` directives. Section imports that
/// barrel, so the `Theme` it calls is the SDK one, inside an app whose
/// MaterialApp comes from material_ui.
///
/// This test reads the theme twice from the same BuildContext: once the way
/// the app sees it, once the way Section sees it.
void main() {
  testWidgets('a widget behind the unmigrated barrel reads another theme', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ResidenceApp());
    await tester.pumpAndSettle();

    final BuildContext context = tester.element(find.byType(Section).first);

    final ThemeData app = Theme.of(context);
    final sdk.ThemeData barrel = sdk.Theme.of(context);

    debugPrint('app primary:          ${app.colorScheme.primary}');
    debugPrint('barrel primary:       ${barrel.colorScheme.primary}');
    debugPrint('app titleMedium:      ${app.textTheme.titleMedium?.color}');
    debugPrint('barrel titleMedium:   ${barrel.textTheme.titleMedium?.color}');

    expect(barrel.colorScheme.primary, isNot(app.colorScheme.primary));
    // What Section actually rendered: its title uses textTheme.titleMedium
    // from whichever Theme its imports point to.
    final Text title = tester.widget<Text>(find.text('Occupancy'));
    debugPrint('rendered title color: ${title.style?.color}');

    expect(title.style?.color, barrel.textTheme.titleMedium?.color);
    expect(title.style?.color, isNot(app.textTheme.titleMedium?.color));
  });
}
