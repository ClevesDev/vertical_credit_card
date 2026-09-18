import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';

void main() {
  testWidgets('Smoke test: VerticalCardDemoApp loads', (WidgetTester tester) async {
    await tester.pumpWidget(const VerticalCardDemoApp());
    expect(find.text('Vertical Credit Card'), findsOneWidget);
    expect(find.text('Flat Neo'), findsOneWidget);
  });
}
