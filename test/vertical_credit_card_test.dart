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
}
