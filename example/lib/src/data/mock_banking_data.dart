import 'package:flutter/material.dart';
import 'package:vertical_credit_card/vertical_credit_card.dart';

/// Represents a regional banking account definition for interactive simulation.
class RegionalAccount {
  /// Country code identifier (e.g., 'CO', 'MX', 'GLOBAL').
  final String code;

  /// Full country or regional market name.
  final String country;

  /// ISO currency code (e.g., 'USD', 'COP', 'EUR').
  final String currency;

  /// Emoji flag representation.
  final String flag;

  /// Account product name (e.g., 'Cuenta Nequi Ahorros').
  final String account;

  /// Flagship card product title.
  final String card;

  /// Signature brand color accent.
  final Color color;

  /// Default constructor for regional account profiles.
  const RegionalAccount({
    required this.code,
    required this.country,
    required this.currency,
    required this.flag,
    required this.account,
    required this.card,
    required this.color,
  });
}

/// Profile model holding mock banking dashboard data for a given region.
class BankingProfile {
  /// ISO currency symbol or code.
  final String currency;

  /// Formatted available balance string.
  final String balance;

  /// Trend or growth percentage indicator.
  final String trend;

  /// Account categorization label.
  final String accountType;

  /// Visual badge label for the account.
  final String accountTag;

  /// Theme color for the account badge.
  final Color accountTagColor;

  /// Issuing institution or bank name.
  final String bankName;

  /// Primary cardholder name.
  final String cardHolder;

  /// Masked or unmasked 16-digit card number.
  final String cardNumber;

  /// Active card theme with customized corner radius.
  final VerticalCardTheme activeCardTheme;

  /// Recent transaction entries.
  final List<Map<String, dynamic>> transactions;

  /// Default constructor for banking profile data.
  const BankingProfile({
    required this.currency,
    required this.balance,
    required this.trend,
    required this.accountType,
    required this.accountTag,
    required this.accountTagColor,
    required this.bankName,
    required this.cardHolder,
    required this.cardNumber,
    required this.activeCardTheme,
    required this.transactions,
  });
}

/// Centralized repository of mock banking and fintech records.
///
/// Provides localized transaction feeds, regional currencies, and issuer
/// configurations for testing vertical cards in realistic banking dashboard contexts.
class MockBankingData {
  /// List of supported countries with flags for the Studio header selector.
  static const List<Map<String, String>> countries = [
    {'code': 'GLOBAL', 'label': 'Global', 'flag': '🌎'},
    {'code': 'CO', 'label': 'Colombia', 'flag': '🇨🇴'},
    {'code': 'MX', 'label': 'México', 'flag': '🇲🇽'},
    {'code': 'BR', 'label': 'Brasil', 'flag': '🇧🇷'},
    {'code': 'AR', 'label': 'Argentina', 'flag': '🇦🇷'},
    {'code': 'ES', 'label': 'España', 'flag': '🇪🇸'},
    {'code': 'PE', 'label': 'Perú', 'flag': '🇵🇪'},
    {'code': 'CL', 'label': 'Chile', 'flag': '🇨🇱'},
    {'code': 'UK', 'label': 'UK', 'flag': '🇬🇧'},
    {'code': 'US', 'label': 'USA', 'flag': '🇺🇸'},
  ];

  /// List of regional accounts used in the account switcher bottom sheet.
  static const List<RegionalAccount> accounts = [
    RegionalAccount(
      code: 'GLOBAL',
      country: 'Global (USA / International)',
      currency: 'USD',
      flag: '🌎',
      account: 'Primary Global Account',
      card: 'Nexus Black Metal',
      color: Colors.amberAccent,
    ),
    RegionalAccount(
      code: 'CO',
      country: 'Colombia',
      currency: 'COP',
      flag: '🇨🇴',
      account: 'Cuenta Nequi Ahorros',
      card: 'Nequi Magenta Neon',
      color: Color(0xFFFF007A),
    ),
    RegionalAccount(
      code: 'MX',
      country: 'México',
      currency: 'MXN',
      flag: '🇲🇽',
      account: 'Débito Digital SPEI',
      card: 'Mercado Pago Blue',
      color: Color(0xFF009EE3),
    ),
    RegionalAccount(
      code: 'BR',
      country: 'Brasil',
      currency: 'BRL',
      flag: '🇧🇷',
      account: 'Nu Ultravioleta Black',
      card: 'Nubank Ultravioleta',
      color: Color(0xFFC084FC),
    ),
    RegionalAccount(
      code: 'AR',
      country: 'Argentina',
      currency: 'ARS',
      flag: '🇦🇷',
      account: 'Lemon Crypto & Pesos',
      card: 'Lemon Cash Cyber',
      color: Color(0xFF00FF7F),
    ),
    RegionalAccount(
      code: 'ES',
      country: 'España / Europa',
      currency: 'EUR',
      flag: '🇪🇸',
      account: 'N26 Metal IBAN',
      card: 'N26 Frosted Glass',
      color: Color(0xFF00D4B2),
    ),
    RegionalAccount(
      code: 'PE',
      country: 'Perú',
      currency: 'PEN',
      flag: '🇵🇪',
      account: 'Yape Cuenta Digital BCP',
      card: 'Yape Royal Purple',
      color: Color(0xFF862799),
    ),
    RegionalAccount(
      code: 'CL',
      country: 'Chile',
      currency: 'CLP',
      flag: '🇨🇱',
      account: 'Cuenta Prepago Tenpo',
      card: 'Tenpo Petrol & Teal',
      color: Color(0xFF00C9A7),
    ),
    RegionalAccount(
      code: 'UK',
      country: 'United Kingdom',
      currency: 'GBP',
      flag: '🇬🇧',
      account: 'Monzo Current Account',
      card: 'Monzo Hot Coral',
      color: Color(0xFFFF483B),
    ),
    RegionalAccount(
      code: 'US',
      country: 'United States',
      currency: 'USD',
      flag: '🇺🇸',
      account: 'Robinhood Gold Cash',
      card: 'Robinhood Gold Metal',
      color: Color(0xFFD4AF37),
    ),
  ];

  /// Constructs a localized banking profile based on the selected country code.
  static BankingProfile getProfile(String countryCode, double borderRadius) {
    final br = BorderRadius.circular(borderRadius);

    switch (countryCode) {
      case 'CO':
        return BankingProfile(
          currency: 'COP',
          balance: r'$4.850.000',
          trend: '+5.2% este mes',
          accountTag: 'COLOMBIA FINTECH',
          accountTagColor: const Color(0xFFFF007A),
          accountType: 'Cuenta Nequi Ahorros',
          bankName: 'NEQUI',
          cardHolder: 'DIMAS CLEVES',
          cardNumber: '4512 8839 0192 4812',
          activeCardTheme: CardPresets.nequi.copyWith(borderRadius: br),
          transactions: const [
            {
              'title': 'Rappi Prime',
              'subtitle': 'Domicilio Gourmet · Nequi',
              'amount': r'-$34.900',
              'time': 'Hoy, 1:45 PM',
              'isIncome': false,
              'icon': Icons.delivery_dining_rounded,
              'iconBg': Color(0xFF2C1A24),
            },
            {
              'title': 'Éxito Wow Poblado',
              'subtitle': 'Supermercado · Contactless',
              'amount': r'-$185.400',
              'time': 'Hoy, 11:20 AM',
              'isIncome': false,
              'icon': Icons.shopping_bag_outlined,
              'iconBg': Color(0xFF2B2818),
            },
            {
              'title': 'Bancolombia Nómina',
              'subtitle': 'Transferencia directa recibida',
              'amount': r'+$1.200.000',
              'time': 'Ayer',
              'isIncome': true,
              'icon': Icons.account_balance_rounded,
              'iconBg': Color(0xFF162529),
            },
            {
              'title': 'Spotify Premium',
              'subtitle': 'Suscripción mensual',
              'amount': r'-$16.900',
              'time': '15 Sep',
              'isIncome': false,
              'icon': Icons.music_note_rounded,
              'iconBg': Color(0xFF172B1E),
            },
          ],
        );

      case 'MX':
        return BankingProfile(
          currency: 'MXN',
          balance: r'$28,500.00',
          trend: '+4.1% este mes',
          accountTag: 'MÉXICO FINTECH',
          accountTagColor: const Color(0xFF009EE3),
          accountType: 'Débito Digital SPEI',
          bankName: 'MERCADO PAGO',
          cardHolder: 'DIMAS CLEVES',
          cardNumber: '5256 7102 9940 1834',
          activeCardTheme: CardPresets.mercadoPago.copyWith(borderRadius: br),
          transactions: const [
            {
              'title': 'Mercado Libre',
              'subtitle': 'Auriculares Sony WH-1000XM5',
              'amount': r'-$1,499.00',
              'time': 'Hoy, 3:15 PM',
              'isIncome': false,
              'icon': Icons.shopping_cart_outlined,
              'iconBg': Color(0xFF162535),
            },
            {
              'title': 'OXXO Gas',
              'subtitle': 'Gasolina Premium · Contactless',
              'amount': r'-$650.00',
              'time': 'Hoy, 9:30 AM',
              'isIncome': false,
              'icon': Icons.local_gas_station_rounded,
              'iconBg': Color(0xFF2C1919),
            },
            {
              'title': 'SPEI Nómina Directa',
              'subtitle': 'Fintech Hub SA · SPEI',
              'amount': r'+$18,400.00',
              'time': 'Ayer',
              'isIncome': true,
              'icon': Icons.account_balance_rounded,
              'iconBg': Color(0xFF162B22),
            },
            {
              'title': 'Starbucks Reserve',
              'subtitle': 'Cold Brew Venti · Apple Pay',
              'amount': r'-$98.00',
              'time': '16 Sep',
              'isIncome': false,
              'icon': Icons.coffee_rounded,
              'iconBg': Color(0xFF1A2B1E),
            },
          ],
        );

      case 'BR':
        return BankingProfile(
          currency: 'BRL',
          balance: r'R$ 8.450,00',
          trend: '+6.5% este mês',
          accountTag: 'BRASIL FINTECH',
          accountTagColor: const Color(0xFFC084FC),
          accountType: 'Nu Ultravioleta Black',
          bankName: 'NUBANK BR',
          cardHolder: 'DIMAS CLEVES',
          cardNumber: '5409 3321 8765 4019',
          activeCardTheme:
              CardPresets.nubankUltravioleta.copyWith(borderRadius: br),
          transactions: const [
            {
              'title': 'iFood Delivery',
              'subtitle': 'Restaurante Fogo de Chão',
              'amount': r'-R$ 74,90',
              'time': 'Hoje, 13:10',
              'isIncome': false,
              'icon': Icons.fastfood_rounded,
              'iconBg': Color(0xFF2C1A1D),
            },
            {
              'title': 'Pix Recebido',
              'subtitle': 'Consultoria Mobile · Pix Instantâneo',
              'amount': r'+R$ 4.200,00',
              'time': 'Hoje, 10:00',
              'isIncome': true,
              'icon': Icons.pix_rounded,
              'iconBg': Color(0xFF24162C),
            },
            {
              'title': 'Pão de Açúcar',
              'subtitle': 'Compras semanais · Contactless',
              'amount': r'-R$ 389,00',
              'time': 'Ontem',
              'isIncome': false,
              'icon': Icons.shopping_bag_outlined,
              'iconBg': Color(0xFF2B2516),
            },
            {
              'title': 'Netflix 4K Premium',
              'subtitle': 'Débito Automático Mensal',
              'amount': r'-R$ 55,90',
              'time': '14 Set',
              'isIncome': false,
              'icon': Icons.tv_rounded,
              'iconBg': Color(0xFF2C1717),
            },
          ],
        );

      case 'AR':
        return BankingProfile(
          currency: 'ARS',
          balance: r'$1.250.000',
          trend: '+12.4% este mes',
          accountTag: 'ARGENTINA CRYPTO',
          accountTagColor: const Color(0xFF00FF7F),
          accountType: 'Lemon Crypto & Pesos',
          bankName: 'LEMON CASH',
          cardHolder: 'DIMAS CLEVES',
          cardNumber: '4123 9087 6543 2100',
          activeCardTheme: CardPresets.lemonCash.copyWith(borderRadius: br),
          transactions: const [
            {
              'title': 'PedidosYa Gourmet',
              'subtitle': 'Almuerzo Hamburguesería',
              'amount': r'-$14.500',
              'time': 'Hoy, 13:50',
              'isIncome': false,
              'icon': Icons.moped_rounded,
              'iconBg': Color(0xFF2C191E),
            },
            {
              'title': 'Cashback Bitcoin',
              'subtitle': 'Recompensa 2% compra Lemon Card',
              'amount': r'+0.00012 BTC',
              'time': 'Hoy, 21:16',
              'isIncome': true,
              'icon': Icons.currency_bitcoin_rounded,
              'iconBg': Color(0xFF162B1D),
            },
            {
              'title': 'Coto Digital',
              'subtitle': 'Supermercado · Débito VISA',
              'amount': r'-$74.200',
              'time': 'Ayer',
              'isIncome': false,
              'icon': Icons.shopping_bag_outlined,
              'iconBg': Color(0xFF2B2816),
            },
            {
              'title': 'Venta USDT P2P',
              'subtitle': 'Acreditación instantánea en pesos',
              'amount': r'+$250.000',
              'time': '14 Sep',
              'isIncome': true,
              'icon': Icons.swap_horiz_rounded,
              'iconBg': Color(0xFF162B28),
            },
          ],
        );

      case 'ES':
        return BankingProfile(
          currency: 'EUR',
          balance: r'€12.350,00',
          trend: '+2.9% this month',
          accountTag: 'EUROPE BANK',
          accountTagColor: const Color(0xFF00D4B2),
          accountType: 'N26 Metal IBAN',
          bankName: 'N26',
          cardHolder: 'DIMAS CLEVES',
          cardNumber: '4921 5432 1098 7654',
          activeCardTheme: CardPresets.n26.copyWith(borderRadius: br),
          transactions: const [
            {
              'title': 'El Corte Inglés',
              'subtitle': 'Moda y Accesorios · Contactless',
              'amount': r'-€129,50',
              'time': 'Hoy, 16:30',
              'isIncome': false,
              'icon': Icons.storefront_rounded,
              'iconBg': Color(0xFF1C2B22),
            },
            {
              'title': 'Mercadona',
              'subtitle': 'Alimentación · Contactless',
              'amount': '-€62.40',
              'time': 'Hoy, 12:15',
              'isIncome': false,
              'icon': Icons.shopping_cart_outlined,
              'iconBg': Color(0xFF2B2816),
            },
            {
              'title': 'Transferencia SEPA Nómina',
              'subtitle': 'Google Ireland Ltd · Nómina',
              'amount': '+€4,800.00',
              'time': 'Ayer',
              'isIncome': true,
              'icon': Icons.account_balance_rounded,
              'iconBg': Color(0xFF162529),
            },
            {
              'title': 'Renfe AVE Madrid-Bcn',
              'subtitle': 'Billete Tren Alta Velocidad',
              'amount': '-€89.50',
              'time': '12 Sep',
              'isIncome': false,
              'icon': Icons.train_rounded,
              'iconBg': Color(0xFF2A162B),
            },
          ],
        );

      case 'PE':
        return BankingProfile(
          currency: 'PEN',
          balance: r'S/. 4,280.50',
          trend: '+5.8% este mes',
          accountTag: 'PERÚ FINTECH',
          accountTagColor: const Color(0xFF862799),
          accountType: 'Yape Cuenta Digital BCP',
          bankName: 'YAPE BCP',
          cardHolder: 'DIMAS CLEVES',
          cardNumber: '4218 9032 1145 7820',
          activeCardTheme: CardPresets.yape.copyWith(borderRadius: br),
          transactions: const [
            {
              'title': 'Bembos Gourmet',
              'subtitle': 'Combo La Clásica · Delivery Yape',
              'amount': r'-S/. 38.50',
              'time': 'Hoy, 2:10 PM',
              'isIncome': false,
              'icon': Icons.fastfood_rounded,
              'iconBg': Color(0xFF2E1A2B),
            },
            {
              'title': 'Wong Ovalo Gutiérrez',
              'subtitle': 'Supermercado · VISA Débito',
              'amount': '-S/. 214.80',
              'time': 'Hoy, 10:30',
              'isIncome': false,
              'icon': Icons.shopping_bag_outlined,
              'iconBg': Color(0xFF2B2816),
            },
            {
              'title': 'Abono Haberes BCP',
              'subtitle': 'Transferencia mensual BCP',
              'amount': '+S/. 4,500.00',
              'time': 'Ayer',
              'isIncome': true,
              'icon': Icons.account_balance_rounded,
              'iconBg': Color(0xFF16282B),
            },
            {
              'title': 'Uber Viajes',
              'subtitle': 'San Isidro a Barranco',
              'amount': '-S/. 22.50',
              'time': '15 Sep',
              'isIncome': false,
              'icon': Icons.directions_car_rounded,
              'iconBg': Color(0xFF1C1F2B),
            },
          ],
        );

      case 'CL':
        return BankingProfile(
          currency: 'CLP',
          balance: r'$840.000',
          trend: '+7.2% este mes',
          accountTag: 'CHILE FINTECH',
          accountTagColor: const Color(0xFF00C9A7),
          accountType: 'Cuenta Prepago Tenpo',
          bankName: 'TENPO',
          cardHolder: 'DIMAS CLEVES',
          cardNumber: '5109 2384 9012 3456',
          activeCardTheme: CardPresets.tenpo.copyWith(borderRadius: br),
          transactions: const [
            {
              'title': 'Jumbo La Dehesa',
              'subtitle': 'Supermercado · Contactless',
              'amount': r'-$64.990',
              'time': 'Hoy, 12:40 PM',
              'isIncome': false,
              'icon': Icons.local_grocery_store_outlined,
              'iconBg': Color(0xFF162B28),
            },
            {
              'title': 'Cornershop by Uber',
              'subtitle': 'Compras hogar delivery',
              'amount': r'-$38.400',
              'time': 'Hoy, 11:20',
              'isIncome': false,
              'icon': Icons.shopping_cart_outlined,
              'iconBg': Color(0xFF2B1C16),
            },
            {
              'title': 'Transferencia TEF Nómina',
              'subtitle': 'Empresa SpA · TEF en línea',
              'amount': r'+$950.000',
              'time': 'Ayer',
              'isIncome': true,
              'icon': Icons.account_balance_rounded,
              'iconBg': Color(0xFF162B24),
            },
            {
              'title': 'Bencina Copec',
              'subtitle': 'Pago rápido Muevo Copec',
              'amount': r'-$25.000',
              'time': '16 Sep',
              'isIncome': false,
              'icon': Icons.local_gas_station_rounded,
              'iconBg': Color(0xFF2C1919),
            },
          ],
        );

      case 'UK':
        return BankingProfile(
          currency: 'GBP',
          balance: r'£3,420.80',
          trend: '+3.4% this month',
          accountTag: 'UK NEOBANK',
          accountTagColor: const Color(0xFFFF483B),
          accountType: 'Monzo Current Account',
          bankName: 'MONZO',
          cardHolder: 'DIMAS CLEVES',
          cardNumber: '5355 2201 9845 6712',
          activeCardTheme: CardPresets.monzoHotCoral.copyWith(borderRadius: br),
          transactions: const [
            {
              'title': 'Pret A Manger London',
              'subtitle': 'Organic Flat White & Sandwich',
              'amount': r'-£6.45',
              'time': 'Today, 1:05 PM',
              'isIncome': false,
              'icon': Icons.coffee_rounded,
              'iconBg': Color(0xFF2B1919),
            },
            {
              'title': 'Sainsbury’s Local',
              'subtitle': 'Groceries · Apple Pay',
              'amount': r'-£24.80',
              'time': 'Today, 11:15 AM',
              'isIncome': false,
              'icon': Icons.shopping_bag_outlined,
              'iconBg': Color(0xFF2A2016),
            },
            {
              'title': 'Faster Payments Salary',
              'subtitle': 'Monzo Labs UK · Direct Credit',
              'amount': r'+£2,850.00',
              'time': 'Yesterday',
              'isIncome': true,
              'icon': Icons.account_balance_rounded,
              'iconBg': Color(0xFF162A22),
            },
            {
              'title': 'Transport for London (TfL)',
              'subtitle': 'Contactless Tube / Underground',
              'amount': r'-£3.40',
              'time': '16 Sep',
              'isIncome': false,
              'icon': Icons.train_rounded,
              'iconBg': Color(0xFF1B232E),
            },
          ],
        );

      case 'US':
        return BankingProfile(
          currency: 'USD',
          balance: r'$9,250.00',
          trend: '+8.1% this month',
          accountTag: 'USA WEALTH & CASH',
          accountTagColor: const Color(0xFFD4AF37),
          accountType: 'Robinhood Gold Cash Account',
          bankName: 'ROBINHOOD',
          cardHolder: 'DIMAS CLEVES',
          cardNumber: '4929 1845 0092 3819',
          activeCardTheme: CardPresets.robinhoodGold.copyWith(borderRadius: br),
          transactions: const [
            {
              'title': 'Whole Foods Market',
              'subtitle': 'Organic Groceries · Gold Card',
              'amount': r'-$78.20',
              'time': 'Today, 2:40 PM',
              'isIncome': false,
              'icon': Icons.shopping_basket_outlined,
              'iconBg': Color(0xFF262615),
            },
            {
              'title': 'Direct Deposit (Google LLC)',
              'subtitle': 'Bi-weekly Payroll Transfer',
              'amount': r'+$6,420.00',
              'time': 'Yesterday',
              'isIncome': true,
              'icon': Icons.account_balance_rounded,
              'iconBg': Color(0xFF162529),
            },
            {
              'title': 'Gold 5% APY Interest',
              'subtitle': 'Monthly uninvested cash interest',
              'amount': r'+$142.80',
              'time': '15 Sep',
              'isIncome': true,
              'icon': Icons.trending_up_rounded,
              'iconBg': Color(0xFF2B2516),
            },
          ],
        );

      case 'GLOBAL':
      default:
        return BankingProfile(
          currency: 'USD',
          balance: r'$14,850.50',
          trend: '+3.8% this month',
          accountTag: 'BLACK METAL',
          accountTagColor: Colors.amberAccent,
          accountType: 'Primary Global Account',
          bankName: 'NEXUS BLACK',
          cardHolder: 'DIMAS CLEVES',
          cardNumber: '4000 1234 5678 9010',
          activeCardTheme: CardPresets.goldPrestige.copyWith(borderRadius: br),
          transactions: const [
            {
              'title': 'Apple Store',
              'subtitle': 'iPhone 16 Pro 256GB · Card',
              'amount': r'-$1,199.00',
              'time': 'Today, 2:20 PM',
              'isIncome': false,
              'icon': Icons.apple_rounded,
              'iconBg': Color(0xFF1E2433),
            },
            {
              'title': 'Starbucks Reserve',
              'subtitle': 'Caramel Macchiato · Contactless',
              'amount': r'-$6.80',
              'time': 'Today, 9:15 AM',
              'isIncome': false,
              'icon': Icons.coffee_rounded,
              'iconBg': Color(0xFF1A2621),
            },
            {
              'title': 'Payroll Deposit (Google LLC)',
              'subtitle': 'Automated Clearing House (ACH)',
              'amount': r'+$4,250.00',
              'time': 'Yesterday',
              'isIncome': true,
              'icon': Icons.account_balance_rounded,
              'iconBg': Color(0xFF162529),
            },
            {
              'title': 'Netflix 4K Premium',
              'subtitle': 'Monthly Subscription · Digital',
              'amount': r'-$22.99',
              'time': '16 Sep',
              'isIncome': false,
              'icon': Icons.tv_rounded,
              'iconBg': Color(0xFF29161B),
            },
          ],
        );
    }
  }
}
