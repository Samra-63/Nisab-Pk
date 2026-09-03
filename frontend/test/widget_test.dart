import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';

void main() {
  testWidgets('Nisab PK smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NisabPkApp());

    // Verify that the title or initial shell renders
    expect(find.byType(NisabPkApp), findsOneWidget);
  });
}
