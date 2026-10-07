import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui_migration/app/app.dart';
import 'package:material_ui_migration/features/settings/widgets/themed_badge.dart';

void main() {
  Future<void> openSettings(WidgetTester tester) async {
    await tester.pumpWidget(const ResidenceApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('open-settings')));
    await tester.pumpAndSettle();
  }

  testWidgets('settings shows the selector, the switch and the badge', (
    WidgetTester tester,
  ) async {
    await openSettings(tester);

    expect(find.byKey(const Key('language-selector')), findsOneWidget);
    expect(find.byKey(const Key('notifications-switch')), findsOneWidget);
    expect(find.byType(ThemedBadge), findsOneWidget);
  });

  testWidgets('the Cupertino switch toggles', (WidgetTester tester) async {
    await openSettings(tester);

    final Finder switchFinder = find.byKey(const Key('notifications-switch'));
    expect(tester.widget<CupertinoSwitch>(switchFinder).value, isTrue);

    await tester.tap(switchFinder);
    await tester.pumpAndSettle();

    expect(tester.widget<CupertinoSwitch>(switchFinder).value, isFalse);
  });

  testWidgets('picking French changes the strings without a restart', (
    WidgetTester tester,
  ) async {
    await openSettings(tester);

    expect(find.text('Settings'), findsOneWidget);

    await tester.tap(find.text('French'));
    await tester.pumpAndSettle();

    expect(find.text('Paramètres'), findsOneWidget);
    expect(find.text('Settings'), findsNothing);
  });
}
