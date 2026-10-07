import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui_migration/app/app.dart';
import 'package:material_ui_migration/features/dashboard/widgets/stat_card.dart';

void main() {
  testWidgets('the dashboard renders its field and both cards', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ResidenceApp());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('search-field')), findsOneWidget);
    // Two cards from the dashboard, one from the never-updated file.
    expect(find.byType(StatCard), findsNWidgets(3));
    expect(find.byKey(const Key('legacy-card')), findsOneWidget);
  });

  testWidgets('the plural and the date are rendered in English', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ResidenceApp());
    await tester.pumpAndSettle();

    expect(find.text('42 residents'), findsOneWidget);
    expect(find.text('Last sync: October 3, 2026'), findsOneWidget);
  });

  testWidgets('the dialog opens and its cancel button comes from Material', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ResidenceApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('open-dialog')));
    await tester.pumpAndSettle();

    expect(find.text('Delete this report?'), findsOneWidget);
    // Not from our .arb files: MaterialLocalizations provides this one.
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('the detail route is reachable', (WidgetTester tester) async {
    await tester.pumpWidget(const ResidenceApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('open-detail')));
    await tester.pumpAndSettle();

    expect(find.text('Building A'), findsOneWidget);
  });
}
