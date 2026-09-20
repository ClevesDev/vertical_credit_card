import 'package:vertical_credit_card/vertical_credit_card.dart';

/// Catalog of curated card design presets and category taxonomies.
///
/// This catalog organizes 44 production-grade presets across 9 distinct
/// design families, ranging from real-world regional neobanks to exotic
/// physical materials and Web3 hardware wallets.
///
/// ### How to use presets in your application:
/// ```dart
/// // Step 1: Import the package
/// import 'package:vertical_credit_card/vertical_credit_card.dart';
///
/// // Step 2: Use the CardPresets static registry directly in your widget
/// VerticalCard(
///   cardNumber: '4111 2222 3333 4444',
///   cardHolder: 'YOUR NAME',
///   expiryDate: '12/28',
///   cvv: '123',
///   cardTheme: CardPresets.nequi, // Or CardPresets.nubankUltravioleta, etc.
/// )
/// ```
class PresetCatalog {
  /// Category taxonomies for filtering presets in the showcase.
  static const List<Map<String, String>> categories = [
    {'id': 'Regional', 'label': '🌐 Regional', 'desc': 'Fintech & Neobanks'},
    {
      'id': 'Materials',
      'label': '💎 Materials',
      'desc': 'Bamboo, Steel & Ceramic'
    },
    {'id': 'Gamer', 'label': '🎮 Gamer RGB', 'desc': 'Chroma & Cyber PCB'},
    {'id': 'Crypto', 'label': '🪙 Crypto Web3', 'desc': 'Ledger & Solana'},
    {'id': 'Neobank', 'label': '🏦 Neobanks', 'desc': 'Global Digital Banks'},
    {'id': 'Luxury', 'label': '👑 Luxury Metal', 'desc': 'Apple & Amex'},
    {'id': 'Cyber', 'label': '⚡ Cyberpunk', 'desc': 'Neon & Glowing'},
    {'id': 'Artistic', 'label': '🎨 Artistic 3D', 'desc': 'Holo & Patterns'},
    {'id': 'All', 'label': '✨ All', 'desc': 'All 44 Presets'},
  ];

  /// The complete collection of 44 curated presets.
  static final List<Map<String, dynamic>> allPresets = [
    {'name': 'Nubank', 'family': 'Neobank', 'theme': CardPresets.nubank},
    {'name': 'Wise', 'family': 'Neobank', 'theme': CardPresets.wise},
    {
      'name': 'Revolut Fluid',
      'family': 'Neobank',
      'theme': CardPresets.revolutChromatic,
    },
    {
      'name': 'Apple Card',
      'family': 'Luxury',
      'theme': CardPresets.appleTitanium,
    },
    {
      'name': 'Amex Black',
      'family': 'Luxury',
      'theme': CardPresets.amexCenturion,
    },
    {
      'name': 'Gold Prestige',
      'family': 'Luxury',
      'theme': CardPresets.goldPrestige,
    },
    {'name': 'Neon Cyber', 'family': 'Cyber', 'theme': CardPresets.neonCyan},
    {
      'name': 'Matrix Green',
      'family': 'Cyber',
      'theme': CardPresets.matrixGreen,
    },
    {
      'name': 'Flutter Impeller',
      'family': 'Cyber',
      'theme': CardPresets.flutterImpeller,
    },
    {
      'name': 'Chromatic Fluid',
      'family': 'Cyber',
      'theme': CardPresets.chromaticFluid,
    },
    {
      'name': 'Neo Digital Glass',
      'family': 'Cyber',
      'theme': CardPresets.neoDigital,
    },
    {
      'name': 'Holo Infinite',
      'family': 'Artistic',
      'theme': CardPresets.holoInfinite,
    },
    {
      'name': 'Painterly Globe',
      'family': 'Artistic',
      'theme': CardPresets.painterlyGlobe,
    },
    {
      'name': 'Topographic Gold',
      'family': 'Artistic',
      'theme': CardPresets.topographicGold,
    },
    {
      'name': 'Carbon Stealth',
      'family': 'Artistic',
      'theme': CardPresets.carbonStealth,
    },
    {
      'name': 'Alpine Horizon',
      'family': 'Artistic',
      'theme': CardPresets.alpineHorizon,
    },
    {
      'name': 'Solar Eclipse',
      'family': 'Artistic',
      'theme': CardPresets.solarEclipse,
    },
    {
      'name': 'Desert Dune',
      'family': 'Artistic',
      'theme': CardPresets.desertDune,
    },
    {
      'name': 'The Great Wave',
      'family': 'Artistic',
      'theme': CardPresets.greatWave,
    },
    {
      'name': 'Golden Kintsugi',
      'family': 'Artistic',
      'theme': CardPresets.goldenKintsugi,
    },
    {
      'name': 'Cosmos Constellation',
      'family': 'Artistic',
      'theme': CardPresets.cosmosConstellation,
    },
    {
      'name': 'Art Déco Gatsby',
      'family': 'Artistic',
      'theme': CardPresets.artDecoGold,
    },
    // Regional & Global Fintech Flagships
    {
      'name': '🇨🇴 Nequi',
      'family': 'Regional',
      'theme': CardPresets.nequi,
    },
    {
      'name': '🇨🇴 Bancolombia',
      'family': 'Regional',
      'theme': CardPresets.bancolombia,
    },
    {
      'name': '🇲🇽 Mercado Pago',
      'family': 'Regional',
      'theme': CardPresets.mercadoPago,
    },
    {
      'name': '🇲🇽 Hey Banco',
      'family': 'Regional',
      'theme': CardPresets.heyBanco,
    },
    {
      'name': '🇧🇷 Nu Ultravioleta',
      'family': 'Regional',
      'theme': CardPresets.nubankUltravioleta,
    },
    {
      'name': '🇧🇷 Banco Inter',
      'family': 'Regional',
      'theme': CardPresets.bancoInter,
    },
    {
      'name': '🇦🇷 Lemon Cash',
      'family': 'Regional',
      'theme': CardPresets.lemonCash,
    },
    {
      'name': '🇦🇷 Ualá',
      'family': 'Regional',
      'theme': CardPresets.uala,
    },
    {
      'name': '🇪🇸 N26 Glass',
      'family': 'Regional',
      'theme': CardPresets.n26,
    },
    {
      'name': '🇵🇪 Yape',
      'family': 'Regional',
      'theme': CardPresets.yape,
    },
    {
      'name': '🇨🇱 Tenpo',
      'family': 'Regional',
      'theme': CardPresets.tenpo,
    },
    {
      'name': '🇬🇧 Monzo Hot Coral',
      'family': 'Regional',
      'theme': CardPresets.monzoHotCoral,
    },
    {
      'name': '🇺🇸 Robinhood Gold',
      'family': 'Regional',
      'theme': CardPresets.robinhoodGold,
    },
    {
      'name': '🇺🇸 Cash App',
      'family': 'Regional',
      'theme': CardPresets.cashApp,
    },
    // Exotic Physical Materials
    {
      'name': 'Skeleton NFC',
      'family': 'Materials',
      'theme': CardPresets.skeletonNfc,
    },
    {
      'name': 'Bamboo Eco',
      'family': 'Materials',
      'theme': CardPresets.bambooEco,
    },
    {
      'name': 'Damascus Steel',
      'family': 'Materials',
      'theme': CardPresets.damascusSteel,
    },
    {
      'name': 'White Ceramic',
      'family': 'Materials',
      'theme': CardPresets.whiteCeramic,
    },
    // Gamer & Esports RGB
    {
      'name': 'Razer Chroma RGB',
      'family': 'Gamer',
      'theme': CardPresets.razerChroma,
    },
    {
      'name': 'Cyber PCB',
      'family': 'Gamer',
      'theme': CardPresets.cyberPcb,
    },
    // Crypto & Web3 Hardware
    {
      'name': 'Ledger Obsidian',
      'family': 'Crypto',
      'theme': CardPresets.ledgerObsidian,
    },
    {
      'name': 'Solana Aurora',
      'family': 'Crypto',
      'theme': CardPresets.solanaAurora,
    },
  ];

  /// Filters presets according to family category ID.
  static List<Map<String, dynamic>> filterByCategory(String categoryId) {
    if (categoryId == 'All') return allPresets;
    return allPresets.where((p) => p['family'] == categoryId).toList();
  }
}
