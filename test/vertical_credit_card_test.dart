import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vertical_credit_card/vertical_credit_card.dart';

void main() {
  group('CardBrand Detection Tests', () {
    test('detects Visa correctly', () {
      expect(CardBrand.detect('4111 2222 3333 4444'), CardBrand.visa);
      expect(CardBrand.detect('4'), CardBrand.visa);
    });

    test('detects Mastercard correctly', () {
      expect(CardBrand.detect('5105 1051 0510 5100'), CardBrand.mastercard);
      expect(CardBrand.detect('55'), CardBrand.mastercard);
      expect(CardBrand.detect('2221 0000 0000 0000'), CardBrand.mastercard);
    });

    test('detects American Express correctly', () {
      expect(CardBrand.detect('3400 0000 0000 000'), CardBrand.americanExpress);
      expect(CardBrand.detect('3700 0000 0000 000'), CardBrand.americanExpress);
    });

    test('detects Discover correctly', () {
      expect(CardBrand.detect('6011 0000 0000 0000'), CardBrand.discover);
      expect(CardBrand.detect('6500 0000 0000 0000'), CardBrand.discover);
    });

    test('falls back to generic/unknown', () {
      expect(CardBrand.detect(''), CardBrand.generic);
      expect(CardBrand.detect('9999'), CardBrand.generic);
    });
  });

  group('Input Formatters Tests', () {
    test('CardNumberInputFormatter groups by 4 digits', () {
      final formatter = CardNumberInputFormatter();
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(
        text: '1234567812345678',
        selection: TextSelection.collapsed(offset: 16),
      );

      final formatted = formatter.formatEditUpdate(oldValue, newValue);
      expect(formatted.text, '1234 5678 1234 5678');
    });

    test('CardExpiryInputFormatter formats MM/YY', () {
      final formatter = CardExpiryInputFormatter();
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(
        text: '1228',
        selection: TextSelection.collapsed(offset: 4),
      );

      final formatted = formatter.formatEditUpdate(oldValue, newValue);
      expect(formatted.text, '12/28');
    });
  });

  group('Visual Effects Suite Tests', () {
    test('CardTextFinish covers all options', () {
      expect(CardTextFinish.values, contains(CardTextFinish.flat));
      expect(CardTextFinish.values, contains(CardTextFinish.goldFoil));
      expect(CardTextFinish.values, contains(CardTextFinish.silverFoil));
      expect(CardTextFinish.values, contains(CardTextFinish.roseGoldFoil));
      expect(CardTextFinish.values, contains(CardTextFinish.embossed));
    });

    test('CardPresets.revolutChromatic initializes with fluid background', () {
      final theme = CardPresets.revolutChromatic;
      expect(theme.type, VerticalCardThemeType.artistic);
      expect(theme.textFinish, CardTextFinish.silverFoil);
      expect(theme.enablePaymentPulse, isTrue);
    });

    testWidgets(
        'Renders VerticalCard with foil text, edge glow, and diamond dust',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: VerticalCard(
                cardNumber: '4111 2222 3333 4444',
                cardHolder: 'ELENA ROJAS',
                expiryDate: '12/28',
                cvv: '888',
                textFinish: CardTextFinish.goldFoil,
                enableEdgeGlow: true,
                enableDiamondDust: true,
                enablePaymentPulse: true,
                cardTheme: CardPresets.goldPrestige,
              ),
            ),
          ),
        ),
      );

      expect(find.text('4111  2222  3333  4444'), findsOneWidget);
      expect(find.text('ELENA ROJAS'), findsOneWidget);

      // Tap card to trigger payment pulse wave
      await tester.tap(find.byType(VerticalCard));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(tester.hasRunningAnimations, isTrue);
    });

    testWidgets('Renders and animates defrost transition',
        (WidgetTester tester) async {
      bool isFrozen = true;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                body: Column(
                  children: [
                    ElevatedButton(
                      key: const Key('unfreeze_btn'),
                      onPressed: () => setState(() => isFrozen = false),
                      child: const Text('Unfreeze'),
                    ),
                    VerticalCard(
                      cardNumber: '4111 2222 3333 4444',
                      cardHolder: 'ELENA ROJAS',
                      expiryDate: '12/28',
                      cvv: '888',
                      isFrozen: isFrozen,
                      cardTheme: CardPresets.neonCyan,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

      expect(find.text('FROZEN'), findsOneWidget);

      // Unfreeze via button
      await tester.tap(find.byKey(const Key('unfreeze_btn')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      // Frozen badge is gone, defrost transition is running
      expect(find.text('FROZEN'), findsNothing);
      await tester.pump(const Duration(milliseconds: 800));
    });
  });

  group('VerticalCard Widget Tests', () {
    testWidgets('Renders VerticalCard with front content by default',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: VerticalCard.preset(
                cardNumber: '4111 2222 3333 4444',
                cardHolder: 'ALEXANDER HAMILTON',
                expiryDate: '12/28',
                cvv: '888',
                preset: CardPresets.holoInfinite,
              ),
            ),
          ),
        ),
      );

      expect(find.text('4111  2222  3333  4444'), findsOneWidget);
      expect(find.text('ALEXANDER HAMILTON'), findsOneWidget);
      expect(find.text('12/28'), findsOneWidget);
    });

    testWidgets('Renders VerticalCard flipped when isFlipped is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: VerticalCard.preset(
                cardNumber: '4111 2222 3333 4444',
                cardHolder: 'ALEXANDER HAMILTON',
                expiryDate: '12/28',
                cvv: '888',
                isFlipped: true,
                preset: CardPresets.carbonStealth,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('888'), findsOneWidget);
    });

    testWidgets('VerticalCardInputForm renders with fields and updates',
        (WidgetTester tester) async {
      String? enteredNumber;
      String? enteredName;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VerticalCardInputForm(
              onCardNumberChanged: (val) => enteredNumber = val,
              onCardHolderChanged: (val) => enteredName = val,
            ),
          ),
        ),
      );

      expect(find.text('Card Number'), findsOneWidget);
      expect(find.text('Cardholder Name'), findsOneWidget);
      expect(find.text('Expires'), findsOneWidget);
      expect(find.text('CVV / CVC'), findsOneWidget);

      await tester.enterText(
          find.byType(TextFormField).first, '4111222233334444');
      expect(enteredNumber, '4111 2222 3333 4444');

      await tester.enterText(find.byType(TextFormField).at(1), 'JOHN DOE');
      expect(enteredName, 'JOHN DOE');
    });
  });

  group('Regional Fintech Presets Tests', () {
    test('Initializes all regional presets properly', () {
      // Colombia
      expect(CardPresets.nequi.enableEdgeGlow, isTrue);
      expect(CardPresets.bancolombia.textFinish, CardTextFinish.goldFoil);
      // Mexico
      expect(CardPresets.mercadoPago.enablePaymentPulse, isTrue);
      expect(CardPresets.heyBanco.textFinish, CardTextFinish.silverFoil);
      // Brazil
      expect(CardPresets.nubankUltravioleta.isHolographic, isTrue);
      expect(CardPresets.bancoInter.enablePaymentPulse, isTrue);
      // Argentina
      expect(CardPresets.lemonCash.enableEdgeGlow, isTrue);
      expect(CardPresets.uala.enablePaymentPulse, isTrue);
      // Europe
      expect(CardPresets.n26.type, VerticalCardThemeType.glass);
    });

    testWidgets('Renders Nequi and Nubank Ultravioleta cards in widget tree',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  VerticalCard.preset(
                    preset: CardPresets.nequi,
                    cardNumber: '4000 1234 5678 9010',
                    cardHolder: 'DIMAS CLEVES',
                    expiryDate: '12/30',
                    cvv: '888',
                  ),
                  VerticalCard.preset(
                    preset: CardPresets.nubankUltravioleta,
                    cardNumber: '5100 1234 5678 9010',
                    cardHolder: 'DIMAS CLEVES',
                    expiryDate: '12/30',
                    cvv: '888',
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('DIMAS CLEVES'), findsNWidgets(2));
    });

    test('Initializes expanded global fintechs (PE, CL, UK, US)', () {
      // Peru & Chile
      expect(CardPresets.yape.enablePaymentPulse, isTrue);
      expect(CardPresets.tenpo.enablePaymentPulse, isTrue);
      // UK
      expect(CardPresets.monzoHotCoral.enableEdgeGlow, isTrue);
      expect(CardPresets.monzoHotCoral.chipColor, ChipColor.black);
      // USA
      expect(CardPresets.robinhoodGold.textFinish, CardTextFinish.goldFoil);
      expect(CardPresets.cashApp.chipColor, ChipColor.black);
    });

    test(
        'Initializes exotic physical materials (Skeleton, Bamboo, Damascus, Ceramic)',
        () {
      expect(CardPresets.skeletonNfc.type, VerticalCardThemeType.artistic);
      expect(CardPresets.bambooEco.textFinish, CardTextFinish.embossed);
      expect(CardPresets.damascusSteel.type, VerticalCardThemeType.artistic);
      expect(CardPresets.whiteCeramic.textFinish, CardTextFinish.silverFoil);
    });

    test('Initializes gamer RGB and crypto Web3 presets', () {
      // Gamer & RGB
      expect(CardPresets.cyberPcb.enableEdgeGlow, isTrue);
      expect(CardPresets.razerChroma.isRgbChroma, isTrue);
      expect(CardPresets.razerChroma.enableEdgeGlow, isTrue);
      // Crypto Web3
      expect(CardPresets.ledgerObsidian.textFinish, CardTextFinish.silverFoil);
      expect(CardPresets.solanaAurora.isHolographic, isTrue);
    });

    testWidgets('RollingDigitText displays text and updates smoothly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: RollingDigitText(text: '842'),
            ),
          ),
        ),
      );

      expect(find.byType(RollingDigitText), findsOneWidget);
      expect(find.text('8'), findsWidgets);
      expect(find.text('4'), findsWidgets);
      expect(find.text('2'), findsWidgets);

      // Update text to trigger roll
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: RollingDigitText(text: '953'),
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump(const Duration(milliseconds: 700));

      expect(find.text('9'), findsWidgets);
      expect(find.text('5'), findsWidgets);
      expect(find.text('3'), findsWidgets);
    });

    testWidgets('Renders Damascus Steel and Razer Chroma cards properly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  VerticalCard.preset(
                    preset: CardPresets.damascusSteel,
                    cardNumber: '4111 2222 3333 4444',
                    cardHolder: 'SATOSHI NAKAMOTO',
                    expiryDate: '10/32',
                    cvv: '999',
                  ),
                  VerticalCard.preset(
                    preset: CardPresets.razerChroma,
                    cardNumber: '5555 4444 3333 2222',
                    cardHolder: 'PRO GAMER',
                    expiryDate: '01/29',
                    cvv: '777',
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('SATOSHI NAKAMOTO'), findsOneWidget);
      expect(find.text('PRO GAMER'), findsOneWidget);
    });

    test('Initializes 3D Artist Patterns presets properly', () {
      expect(CardPresets.alpineHorizon.textFinish, CardTextFinish.goldFoil);
      expect(CardPresets.worldNavigator.enableEdgeGlow, isTrue);
      expect(CardPresets.greatWave.textFinish, CardTextFinish.goldFoil);
      expect(CardPresets.goldenKintsugi.textFinish, CardTextFinish.goldFoil);
      expect(CardPresets.cosmosConstellation.enableDiamondDust, isTrue);
      expect(CardPresets.artDecoGold.chipColor, ChipColor.gold);
      expect(CardPresets.solarEclipse.enableEdgeGlow, isTrue);
      expect(CardPresets.desertDune.textFinish, CardTextFinish.goldFoil);
    });

    testWidgets(
        'Renders Alpine Horizon, Solar Eclipse, and Desert Dune cards in widget tree',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  VerticalCard.preset(
                    preset: CardPresets.alpineHorizon,
                    cardNumber: '4222 3333 4444 5555',
                    cardHolder: 'ALEX RIDGE',
                    expiryDate: '09/31',
                    cvv: '321',
                  ),
                  VerticalCard.preset(
                    preset: CardPresets.solarEclipse,
                    cardNumber: '5333 4444 5555 6666',
                    cardHolder: 'SOLAR ECLIPSE',
                    expiryDate: '07/30',
                    cvv: '654',
                  ),
                  VerticalCard.preset(
                    preset: CardPresets.desertDune,
                    cardNumber: '5444 5555 6666 7777',
                    cardHolder: 'DESERT GOLD',
                    expiryDate: '11/32',
                    cvv: '987',
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('ALEX RIDGE'), findsOneWidget);
      expect(find.text('SOLAR ECLIPSE'), findsOneWidget);
      expect(find.text('DESERT GOLD'), findsOneWidget);
    });
  });
}
