import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';

void main() {
  testWidgets('Smoke test: VerticalCardDemoApp loads and renders all families', (WidgetTester tester) async {
    await tester.pumpWidget(const VerticalCardDemoApp());
    expect(find.text('Vertical Credit Card'), findsOneWidget);
    expect(find.text('Painterly Globe'), findsOneWidget);
    expect(find.text('Topographic Gold'), findsOneWidget);
    expect(find.text('Carbon Stealth'), findsOneWidget);
  });
}
