/// Supported payment networks for vertical credit/debit cards.
enum CardBrand {
  visa,
  mastercard,
  americanExpress,
  discover,
  dinersClub,
  jcb,
  unionPay,
  generic;

  /// Helper to auto-detect the [CardBrand] from a raw card number.
  static CardBrand detect(String cardNumber) {
    final cleaned = cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
    if (cleaned.isEmpty) return CardBrand.generic;

    // Visa: Starts with 4
    if (cleaned.startsWith('4')) {
      return CardBrand.visa;
    }

    // Mastercard: 51-55 or 2221-2720
    if (RegExp(r'^(5[1-5]|222[1-9]|22[3-9]|2[3-6]|27[0-1]|2720)').hasMatch(cleaned)) {
      return CardBrand.mastercard;
    }

    // American Express: 34 or 37
    if (RegExp(r'^3[47]').hasMatch(cleaned)) {
      return CardBrand.americanExpress;
    }

    // Discover: 6011, 622126-622925, 644-649, 65
    if (RegExp(r'^(6011|622(12[6-9]|1[3-9][0-9]|[2-8][0-9]{2}|9[0-1][0-9]|92[0-5])|64[4-9]|65)').hasMatch(cleaned)) {
      return CardBrand.discover;
    }

    // Diners Club: 300-305, 36, 38
    if (RegExp(r'^(30[0-5]|36|38)').hasMatch(cleaned)) {
      return CardBrand.dinersClub;
    }

    // JCB: 3528-3589
    if (RegExp(r'^(352[89]|35[3-8][0-9])').hasMatch(cleaned)) {
      return CardBrand.jcb;
    }

    // UnionPay: 62
    if (cleaned.startsWith('62')) {
      return CardBrand.unionPay;
    }

    return CardBrand.generic;
  }
}
