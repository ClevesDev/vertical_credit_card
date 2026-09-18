import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';
import 'package:vertical_credit_card/vertical_credit_card.dart';

void main() {
  testWidgets('Smoke test: VerticalCardDemoApp loads and renders all families',
      (WidgetTester tester) async {
    await tester.pumpWidget(const VerticalCardDemoApp());
    expect(find.text('Vertical Credit Card'), findsOneWidget);
    expect(find.text('Holo Infinite'), findsOneWidget);
    expect(find.text('Painterly Globe'), findsOneWidget);
    expect(find.text('Topographic Gold'), findsOneWidget);
    expect(find.text('Carbon Stealth'), findsOneWidget);
  });

  testWidgets('Wallet Mode test: navigates to VerticalCardStack view',
      (WidgetTester tester) async {
    await tester.pumpWidget(const VerticalCardDemoApp());

    // Tap Wallet tab in NavigationBar
    final walletTab = find.text('Wallet');
    expect(walletTab, findsOneWidget);
    await tester.tap(walletTab);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Verify stack message and widget are displayed
    expect(find.text('Tap any card to expand / focus wallet'), findsOneWidget);
    expect(find.byType(VerticalCardStack), findsOneWidget);
  });

  testWidgets('Checkout Form test: navigates and renders VerticalCardInputForm',
      (WidgetTester tester) async {
    await tester.pumpWidget(const VerticalCardDemoApp());

    // Tap Checkout tab in NavigationBar
    final checkoutTab = find.text('Checkout');
    expect(checkoutTab, findsOneWidget);
    await tester.tap(checkoutTab);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Verify input form is present
    expect(find.byType(VerticalCardInputForm), findsOneWidget);
    expect(find.text('Card Number'), findsOneWidget);
    expect(find.text('Cardholder Name'), findsOneWidget);
    expect(find.text('Expires'), findsOneWidget);
    expect(find.text('CVV / CVC'), findsOneWidget);
  });

  testWidgets('Studio test: navigates to Studio and renders live controls',
      (WidgetTester tester) async {
    await tester.pumpWidget(const VerticalCardDemoApp());

    // Tap Studio tab in NavigationBar
    final studioTab = find.text('Studio');
    expect(studioTab, findsOneWidget);
    await tester.tap(studioTab);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Verify Studio sliders and Copy button
    expect(find.text('Copy Dart Code'), findsOneWidget);
    expect(find.text('🌈 Holographic Rainbow Foil'), findsOneWidget);
    expect(find.text('🕹️ 3D Tilt Physics'), findsOneWidget);
  });
}
