import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_ledger/main.dart';

void main() {
  testWidgets('shows the four main tabs', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();
    for (final label in ['Habits', 'Money', 'Budgets', 'Settings']) {
      expect(find.text(label), findsWidgets);
    }
    await tester.tap(find.text('Money').last);
    await tester.pumpAndSettle();
    expect(find.text('Money coming soon'), findsOneWidget);
  });
}
