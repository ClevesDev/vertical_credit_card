import 'package:flutter/material.dart';
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

  testWidgets('Wallet Mode test: toggles to VerticalCardStack view',
      (WidgetTester tester) async {
    await tester.pumpWidget(const VerticalCardDemoApp());

    // Tap the wallet icon in app bar
    final walletButton = find.byIcon(Icons.wallet_rounded);
    expect(walletButton, findsOneWidget);
    await tester.tap(walletButton);
    await tester.pumpAndSettle();

    // Verify stack message is displayed
    expect(find.text('Tap any card to expand / focus wallet'), findsOneWidget);
    expect(find.byType(VerticalCardStack), findsOneWidget);
  });
}
