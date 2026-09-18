import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';
import 'package:vertical_credit_card/vertical_credit_card.dart';

void main() {
  testWidgets('Smoke test: VerticalCardDemoApp loads and renders categories',
      (WidgetTester tester) async {
    await tester.pumpWidget(const VerticalCardDemoApp());
    expect(find.text('Vertical Credit Card'), findsOneWidget);
    expect(find.text('🌐 Regional'), findsOneWidget);
    expect(find.text('🏦 Neobanks'), findsOneWidget);
    expect(find.text('🇨🇴 Nequi'), findsOneWidget);

    // Switch to Artistic 3D category
    final artisticCategory = find.text('🎨 Artistic 3D');
    await tester.ensureVisible(artisticCategory);
    await tester.tap(artisticCategory);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Holo Infinite'), findsOneWidget);
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
    expect(find.text('Free Canvas'), findsOneWidget);
    expect(find.text('Banking App'), findsOneWidget);
  });

  testWidgets(
      'Studio test: toggles to Banking App mode and renders dashboard mockup',
      (WidgetTester tester) async {
    await tester.pumpWidget(const VerticalCardDemoApp());

    // Tap Studio tab in NavigationBar
    final studioTab = find.text('Studio');
    await tester.tap(studioTab);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Tap Banking App
    await tester.tap(find.text('Banking App'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Verify banking app shell elements
    expect(find.text('Hello, Dimas 👋'), findsOneWidget);
    expect(find.text('TOTAL AVAILABLE BALANCE'), findsOneWidget);
    expect(find.text(r'$14,850.50'), findsOneWidget);
    expect(find.text('Freeze'), findsOneWidget);
    expect(find.text('NFC Active'), findsOneWidget);
    expect(find.text('Apple Store'), findsOneWidget);
    expect(find.text('Starbucks Reserve'), findsOneWidget);

    // Scroll to and tap Freeze to toggle freeze mode
    final freezeBtn = find.text('Freeze');
    await tester.ensureVisible(freezeBtn);
    await tester.pump();
    await tester.tap(freezeBtn);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Unfreeze'), findsOneWidget);
  });

  testWidgets(
      'Studio Banking App: switches country/currency to Colombia and Mexico',
      (WidgetTester tester) async {
    await tester.pumpWidget(const VerticalCardDemoApp());

    // Navigate to Studio tab
    await tester.tap(find.text('Studio'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Tap Banking App mode
    await tester.tap(find.text('Banking App'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Verify initial Global currency
    expect(find.text('USD'), findsOneWidget);
    expect(find.text(r'$14,850.50'), findsOneWidget);

    // Tap Colombia
    final colombiaChip = find.text('Colombia');
    expect(colombiaChip, findsOneWidget);
    await tester.tap(colombiaChip);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Verify Colombia fintech details
    expect(find.text('COP'), findsOneWidget);
    expect(find.text(r'$4.850.000'), findsOneWidget);
    expect(find.text('NEQUI'), findsOneWidget);
    expect(find.text('Rappi Prime'), findsOneWidget);

    // Tap Mexico
    final mexicoChip = find.text('México');
    expect(mexicoChip, findsOneWidget);
    await tester.ensureVisible(mexicoChip);
    await tester.pump();
    await tester.tap(mexicoChip);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Verify Mexico fintech details
    expect(find.text('MXN'), findsOneWidget);
    expect(find.text(r'$28,500.00'), findsOneWidget);
    expect(find.text('MERCADO PAGO'), findsOneWidget);
    expect(find.text('Mercado Libre'), findsOneWidget);
  });

  testWidgets(
      'Studio Banking App: opens bottom sheet and selects Colombia account',
      (WidgetTester tester) async {
    await tester.pumpWidget(const VerticalCardDemoApp());

    // Navigate to Studio tab
    await tester.tap(find.text('Studio'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Tap Banking App mode
    await tester.tap(find.text('Banking App'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Tap account badge in profile header
    final accountBadge = find.text('Primary Global Account');
    expect(accountBadge, findsOneWidget);
    await tester.tap(accountBadge);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Bottom sheet title should be visible
    expect(find.text('Select Active Account & Region'), findsOneWidget);

    // Tap Colombia in bottom sheet
    final colombiaOption =
        find.text('Cuenta Nequi Ahorros · Nequi Magenta Neon');
    expect(colombiaOption, findsOneWidget);
    await tester.tap(colombiaOption);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Verify Colombia fintech state
    expect(find.text('COP'), findsOneWidget);
    expect(find.text(r'$4.850.000'), findsOneWidget);
    expect(find.text('NEQUI'), findsOneWidget);
    expect(find.text('Rappi Prime'), findsOneWidget);
  });

  testWidgets('Showcase: filters by Materials, Gamer RGB, and Crypto Web3',
      (WidgetTester tester) async {
    await tester.pumpWidget(const VerticalCardDemoApp());

    // Filter by Materials
    final materialsFilter = find.text('💎 Materials');
    await tester.ensureVisible(materialsFilter);
    await tester.tap(materialsFilter);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Skeleton NFC'), findsOneWidget);

    // Filter by Gamer RGB
    final gamerFilter = find.text('🎮 Gamer RGB');
    await tester.ensureVisible(gamerFilter);
    await tester.tap(gamerFilter);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Razer Chroma RGB'), findsOneWidget);

    // Filter by Crypto Web3
    final cryptoFilter = find.text('🪙 Crypto Web3');
    await tester.ensureVisible(cryptoFilter);
    await tester.tap(cryptoFilter);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Ledger Obsidian'), findsOneWidget);
  });

  testWidgets(
      'Studio Banking App: switches to UK Monzo and triggers Rotate CVV',
      (WidgetTester tester) async {
    await tester.pumpWidget(const VerticalCardDemoApp());

    // Navigate to Studio tab
    await tester.tap(find.text('Studio'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Tap Banking App mode
    await tester.tap(find.text('Banking App'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Tap UK in country selector
    final ukChip = find.text('UK');
    await tester.ensureVisible(ukChip);
    await tester.tap(ukChip);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Verify UK Monzo elements
    expect(find.text('GBP'), findsOneWidget);
    expect(find.text(r'£3,420.80'), findsOneWidget);
    expect(find.text('MONZO'), findsOneWidget);
    expect(find.text('Pret A Manger London'), findsOneWidget);

    // Verify Rotate CVV button is visible and tap it
    final rotateCvvBtn = find.text('Rotate CVV');
    await tester.ensureVisible(rotateCvvBtn);
    expect(rotateCvvBtn, findsOneWidget);
    await tester.tap(rotateCvvBtn, warnIfMissed: false);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('CVV: '), findsOneWidget);
  });
}
