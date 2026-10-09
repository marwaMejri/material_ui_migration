import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:material_ui_migration/app/app.dart';
import 'package:material_ui_migration/features/dashboard/widgets/section.dart';

/// `dart fix` does not rewrite `export` directives, so lib/core/ui.dart kept
/// exporting package:flutter/material.dart after the migration. Section imports
/// that barrel, and painted its title with the SDK's default theme instead of
/// the app's (measurements/16 and 20).
///
/// The barrel is now migrated by hand. This test checks that Section paints
/// with the app's theme, and fails if the barrel ever points back at the SDK.
void main() {
  testWidgets('Section paints its title with the app theme', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ResidenceApp());
    await tester.pumpAndSettle();

    final BuildContext context = tester.element(find.byType(Section).first);
    final ThemeData app = Theme.of(context);

    final Text title = tester.widget<Text>(find.text('Occupancy'));

    expect(title.style?.color, app.textTheme.titleMedium?.color);
  });
}
