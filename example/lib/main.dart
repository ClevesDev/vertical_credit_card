import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vertical_credit_card/vertical_credit_card.dart';

void main() {
  runApp(const VerticalCardDemoApp());
}

class VerticalCardDemoApp extends StatelessWidget {
  const VerticalCardDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vertical Credit Card Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0C10),
        colorScheme: const ColorScheme.dark(
          primary: Colors.cyanAccent,
          secondary: Colors.amberAccent,
          surface: Color(0xFF141722),
        ),
        useMaterial3: true,
      ),
      home: const CardShowcaseScreen(),
    );
  }
}

class CardShowcaseScreen extends StatefulWidget {
  const CardShowcaseScreen({super.key});

  @override
  State<CardShowcaseScreen> createState() => _CardShowcaseScreenState();
}

class _CardShowcaseScreenState extends State<CardShowcaseScreen> {
  int _selectedNavIndex =
      0; // 0: 3D Showcase, 1: Apple Wallet, 2: Checkout Form, 3: Studio
  int _selectedPresetIndex = 12; // Default to 🇨🇴 Nequi in Regional category

  static const List<Map<String, String>> _showcaseCategories = [
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
    {'id': 'All', 'label': '✨ All', 'desc': 'All 40 Presets'},
  ];
  String _selectedShowcaseCategory = 'Regional';

  List<Map<String, dynamic>> get _filteredShowcasePresets {
    if (_selectedShowcaseCategory == 'All') return _presets;
    return _presets
        .where((p) => p['family'] == _selectedShowcaseCategory)
        .toList();
  }

  // 3D Showcase state
  bool _isFrozen = false;
  bool _isExpired = false;
  bool _isPrivacyMode = false;
  bool _enable3DTilt = true;
  bool _isBackVisible = false;

  // Checkout Form state
  String _formCardNumber = '';
  String _formCardHolder = '';
  String _formExpiry = '';
  String _formCvv = '';
  CardBrand _formBrand = CardBrand.generic;
  bool _isCheckoutFlipped = false;

  // Studio state
  double _studioWidth = 240.0;
  double _studioBorderRadius = 16.0;
  double _studioMaxTiltAngle = 0.24;
  MetalType _studioMetal = MetalType.gold;
  final ChipColor _studioChip = ChipColor.gold;
  CardTextFinish _studioTextFinish = CardTextFinish.goldFoil;
  bool _studioEdgeGlow = false;
  bool _studioDiamondDust = true;
  bool _studioPaymentPulse = true;
  bool _studioHolo = false;
  bool _studioTilt = true;
  final bool _studioGlare = true;
  bool _studioBankingView = false;
  bool _studioIsFrozen = false;
  bool _studioPrivacy = false;
  bool _hideBankingBalance = false;
  String _studioCountryCode = 'GLOBAL';
  String _dynamicCvv = '842';

  void _regenerateDynamicCvv() {
    setState(() {
      final randomNum = 100 + (DateTime.now().microsecondsSinceEpoch % 900);
      _dynamicCvv = randomNum.toString();
    });
  }

  final List<Map<String, dynamic>> _presets = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vertical Credit Card',
          style: TextStyle(
              fontWeight: FontWeight.w900, letterSpacing: 1.5, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          if (_selectedNavIndex == 0)
            IconButton(
              tooltip: _isPrivacyMode
                  ? 'Disable Privacy Mode'
                  : 'Enable Privacy Mode',
              icon: Icon(
                _isPrivacyMode
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                color: _isPrivacyMode ? Colors.amberAccent : Colors.white70,
              ),
              onPressed: () {
                setState(() {
                  _isPrivacyMode = !_isPrivacyMode;
                });
              },
            ),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedNavIndex,
          children: [
            _buildShowcaseView(),
            _buildWalletView(),
            _buildCheckoutFormView(),
            _buildStudioView(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedNavIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedNavIndex = index),
        backgroundColor: const Color(0xFF0F1118),
        indicatorColor: Colors.cyanAccent.withValues(alpha: 0.18),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.threed_rotation_rounded),
            label: 'Showcase',
          ),
          NavigationDestination(
            icon: Icon(Icons.wallet_rounded),
            label: 'Wallet',
          ),
          NavigationDestination(
            icon: Icon(Icons.payment_rounded),
            label: 'Checkout',
          ),
          NavigationDestination(
            icon: Icon(Icons.tune_rounded),
            label: 'Studio',
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 1. 3D SHOWCASE VIEW
  // ---------------------------------------------------------------------------
  Widget _buildShowcaseSelector() {
    final filtered = _filteredShowcasePresets;
    final activePreset = _presets[_selectedPresetIndex];
    final activeIndexInFiltered = filtered.indexOf(activePreset);

    return Column(
      children: [
        // 1. Categories Pill Bar
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: _showcaseCategories.map((cat) {
              final isSelected = _selectedShowcaseCategory == cat['id'];
              return Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    setState(() {
                      _selectedShowcaseCategory = cat['id']!;
                      final newFiltered = _filteredShowcasePresets;
                      if (!newFiltered
                          .contains(_presets[_selectedPresetIndex])) {
                        _selectedPresetIndex =
                            _presets.indexOf(newFiltered.first);
                      }
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.cyanAccent.withValues(alpha: 0.18)
                          : const Color(0xFF141824),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? Colors.cyanAccent
                            : Colors.white.withValues(alpha: 0.08),
                        width: isSelected ? 1.2 : 0.8,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color:
                                    Colors.cyanAccent.withValues(alpha: 0.25),
                                blurRadius: 8,
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      cat['label']!,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight:
                            isSelected ? FontWeight.w800 : FontWeight.w600,
                        color: isSelected ? Colors.cyanAccent : Colors.white70,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 6),

        // 2. Filtered Cards Row with Quick Steppers (< and >)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              IconButton(
                tooltip: 'Previous Card',
                icon: const Icon(Icons.chevron_left_rounded, size: 24),
                color: Colors.white70,
                visualDensity: VisualDensity.compact,
                onPressed: filtered.isEmpty
                    ? null
                    : () {
                        setState(() {
                          final currentIdx = activeIndexInFiltered >= 0
                              ? activeIndexInFiltered
                              : 0;
                          final prevIdx = (currentIdx - 1 + filtered.length) %
                              filtered.length;
                          _selectedPresetIndex =
                              _presets.indexOf(filtered[prevIdx]);
                        });
                      },
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: filtered.map((preset) {
                      final isSelected =
                          _presets[_selectedPresetIndex] == preset;
                      final isRegional = preset['family'] == 'Regional';
                      final isHolo = preset['family'] == 'Artistic';

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: ChoiceChip(
                          avatar: isHolo
                              ? const Icon(Icons.auto_awesome_rounded,
                                  size: 14, color: Colors.purpleAccent)
                              : (isRegional
                                  ? const Icon(Icons.account_balance_rounded,
                                      size: 13, color: Colors.cyanAccent)
                                  : null),
                          label: Text(preset['name'] as String),
                          selected: isSelected,
                          selectedColor:
                              Colors.cyanAccent.withValues(alpha: 0.2),
                          labelStyle: TextStyle(
                            color:
                                isSelected ? Colors.cyanAccent : Colors.white70,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 12,
                          ),
                          side: BorderSide(
                            color:
                                isSelected ? Colors.cyanAccent : Colors.white12,
                          ),
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _selectedPresetIndex = _presets.indexOf(preset);
                              });
                            }
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Next Card',
                icon: const Icon(Icons.chevron_right_rounded, size: 24),
                color: Colors.white70,
                visualDensity: VisualDensity.compact,
                onPressed: filtered.isEmpty
                    ? null
                    : () {
                        setState(() {
                          final currentIdx = activeIndexInFiltered >= 0
                              ? activeIndexInFiltered
                              : 0;
                          final nextIdx = (currentIdx + 1) % filtered.length;
                          _selectedPresetIndex =
                              _presets.indexOf(filtered[nextIdx]);
                        });
                      },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildShowcaseView() {
    final activePreset = _presets[_selectedPresetIndex];

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  const SizedBox(height: 6),

                  // Categorized Presets Carousel & Stepper
                  _buildShowcaseSelector(),

                  const SizedBox(height: 10),

                  // Gesture Instruction Banner
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.swipe_outlined,
                        size: 15,
                        color: Colors.white.withValues(alpha: 0.45),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _isBackVisible
                            ? 'Tap to flip FRONT  •  Drag to TILT in 3D'
                            : 'Tap to FLIP 3D  •  Drag to TILT with light reflection',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.45),
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // The Active Vertical Card
                  _buildActiveCard(activePreset),

                  const Spacer(),

                  // Interactive Bottom Controls Panel
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF14171E),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.07)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // 3D Tilt toggle button
                        _buildControlItem(
                          icon: Icons.threed_rotation_rounded,
                          label: '3D Tilt',
                          isActive: _enable3DTilt,
                          activeColor: Colors.purpleAccent,
                          onTap: () =>
                              setState(() => _enable3DTilt = !_enable3DTilt),
                        ),

                        // Privacy mode toggle
                        _buildControlItem(
                          icon: _isPrivacyMode
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          label: 'Privacy',
                          isActive: _isPrivacyMode,
                          activeColor: Colors.amberAccent,
                          onTap: () =>
                              setState(() => _isPrivacyMode = !_isPrivacyMode),
                        ),

                        // Freeze card button
                        _buildControlItem(
                          icon: Icons.ac_unit_rounded,
                          label: 'Freeze',
                          isActive: _isFrozen,
                          activeColor: Colors.cyanAccent,
                          onTap: () => setState(() => _isFrozen = !_isFrozen),
                        ),

                        // Expire card button
                        _buildControlItem(
                          icon: Icons.timer_off_outlined,
                          label: 'Expired',
                          isActive: _isExpired,
                          activeColor: Colors.redAccent,
                          onTap: () => setState(() => _isExpired = !_isExpired),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildControlItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive
                    ? activeColor.withValues(alpha: 0.20)
                    : Colors.white.withValues(alpha: 0.05),
                border: Border.all(
                  color: isActive ? activeColor : Colors.white12,
                  width: 1.2,
                ),
              ),
              child: Icon(
                icon,
                size: 18,
                color: isActive ? activeColor : Colors.white54,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                color: isActive ? activeColor : Colors.white54,
                fontSize: 10.5,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveCard(Map<String, dynamic> preset) {
    final theme = preset['theme'] as VerticalCardTheme;
    final name = preset['name'] as String;

    String? bankName;
    CardBrand? brand;
    Widget? bankLogo;

    if (name == 'Painterly Globe') {
      bankName = 'CREDIT AGRICOLE';
      brand = CardBrand.mastercard;
      bankLogo = Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            'ca',
            style: TextStyle(
              color: Color(0xFF074585),
              fontWeight: FontWeight.w900,
              fontSize: 18,
              letterSpacing: -1.0,
            ),
          ),
        ),
      );
    } else if (name == 'Holo Infinite') {
      bankName = 'HOLO INFINITE';
      brand = CardBrand.visa;
    } else if (name == 'Topographic Gold') {
      bankName = 'GOLD VAULT';
      brand = CardBrand.visa;
    } else if (name == 'Carbon Stealth') {
      bankName = 'STEALTH RS';
      brand = CardBrand.mastercard;
    } else if (name == 'Apple Card') {
      bankName = 'APPLE';
      brand = CardBrand.generic;
    } else if (name == 'Amex Black') {
      bankName = 'CENTURION';
      brand = CardBrand.americanExpress;
    } else if (name == 'Wise') {
      bankName = 'WISE';
      brand = CardBrand.visa;
    }

    return VerticalCard(
      cardNumber: '5412 8888 1024 4321',
      cardHolder: 'ALEXANDER WRIGHT',
      expiryDate: '09/29',
      cvv: '719',
      bankName: bankName,
      brand: brand,
      cardTheme: theme,
      isFrozen: _isFrozen,
      isExpired: _isExpired,
      isPrivacyMode: _isPrivacyMode,
      enable3DTilt: _enable3DTilt,
      enableSpecularGlare: true,
      onFlipChange: (isBack) => setState(() => _isBackVisible = isBack),
      onPrivacyChange: (isPrivate) =>
          setState(() => _isPrivacyMode = isPrivate),
      bankLogo: bankLogo,
    );
  }

  // ---------------------------------------------------------------------------
  // 2. APPLE WALLET CASCADE VIEW
  // ---------------------------------------------------------------------------
  Widget _buildWalletView() {
    final walletCards = [
      VerticalCard.preset(
        preset: CardPresets.holoInfinite,
        cardNumber: '4532 9812 3456 7890',
        cardHolder: 'DIMAS CLEVES',
        expiryDate: '12/28',
        cvv: '942',
        bankName: 'HOLO INFINITE',
        enableFlip: false,
      ),
      VerticalCard.preset(
        preset: CardPresets.painterlyGlobe,
        cardNumber: '5412 8888 1024 4321',
        cardHolder: 'DIMAS CLEVES',
        expiryDate: '08/29',
        cvv: '821',
        bankName: 'CREDIT AGRICOLE',
        enableFlip: false,
      ),
      VerticalCard.preset(
        preset: CardPresets.topographicGold,
        cardNumber: '4000 1234 5678 9010',
        cardHolder: 'DIMAS CLEVES',
        expiryDate: '05/30',
        cvv: '333',
        bankName: 'GOLD ELEVATION',
        enableFlip: false,
      ),
      VerticalCard.preset(
        preset: CardPresets.carbonStealth,
        cardNumber: '3782 822468 005',
        cardHolder: 'DIMAS CLEVES',
        expiryDate: '11/27',
        cvv: '714',
        bankName: 'CARBON STEALTH',
        enableFlip: false,
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.touch_app_rounded,
                  size: 16, color: Colors.cyanAccent),
              const SizedBox(width: 8),
              Text(
                'Tap any card to expand / focus wallet',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Center(
            child: VerticalCardStack(
              cards: walletCards,
              cardSpacing: 62.0,
              cardHeight: 380.0,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 3. SYNCHRONIZED CHECKOUT FORM (WITH CVV AUTO-FLIP)
  // ---------------------------------------------------------------------------
  Widget _buildCheckoutFormView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          // Live synchronized card preview
          Center(
            child: VerticalCard.preset(
              preset: CardPresets.holoInfinite,
              cardNumber: _formCardNumber.isEmpty
                  ? '0000 0000 0000 0000'
                  : _formCardNumber,
              cardHolder:
                  _formCardHolder.isEmpty ? 'YOUR NAME' : _formCardHolder,
              expiryDate: _formExpiry.isEmpty ? 'MM/YY' : _formExpiry,
              cvv: _formCvv.isEmpty ? '•••' : _formCvv,
              brand: _formBrand == CardBrand.generic ? null : _formBrand,
              bankName: 'NEXUS BANK',
              isFlipped: _isCheckoutFlipped,
            ),
          ),

          const SizedBox(height: 20),

          // Instruction badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.cyanAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: Colors.cyanAccent.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.auto_awesome,
                    size: 16, color: Colors.cyanAccent),
                const SizedBox(width: 8),
                Text(
                  'Focus CVV field to watch the 3D auto-flip!',
                  style: TextStyle(
                    color: Colors.cyanAccent.withValues(alpha: 0.9),
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // The interactive form widget
          VerticalCardInputForm(
            onCardNumberChanged: (val) => setState(() => _formCardNumber = val),
            onCardHolderChanged: (val) => setState(() => _formCardHolder = val),
            onExpiryChanged: (val) => setState(() => _formExpiry = val),
            onCvvChanged: (val) => setState(() => _formCvv = val),
            onBrandChanged: (val) => setState(() => _formBrand = val),
            onCvvFocusChanged: (hasFocus) {
              setState(() => _isCheckoutFlipped = hasFocus);
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 4. LIVE CARD CUSTOMIZER STUDIO
  // ---------------------------------------------------------------------------
  Widget _buildStudioView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mode Switcher: Free Canvas vs Banking App
          Center(
            child: SegmentedButton<bool>(
              segments: const [
                ButtonSegment<bool>(
                  value: false,
                  icon: Icon(Icons.palette_outlined, size: 18),
                  label: Text('Free Canvas',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                ButtonSegment<bool>(
                  value: true,
                  icon: Icon(Icons.phone_iphone_rounded, size: 18),
                  label: Text('Banking App',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ],
              selected: {_studioBankingView},
              onSelectionChanged: (newSelection) {
                setState(() {
                  _studioBankingView = newSelection.first;
                });
              },
            ),
          ),

          if (_studioBankingView) ...[
            const SizedBox(height: 14),
            Center(
              child: _buildCountrySelector(),
            ),
          ],

          const SizedBox(height: 20),

          // Live customized preview (Canvas vs Banking App Mockup)
          if (!_studioBankingView)
            Center(
              child: VerticalCard(
                cardNumber: '4000 1234 5678 9010',
                cardHolder: 'DIMAS CLEVES',
                expiryDate: '12/30',
                cvv: '888',
                bankName: 'CUSTOM CARD',
                width: _studioWidth,
                enable3DTilt: _studioTilt,
                enableSpecularGlare: _studioGlare,
                enableHolographicFoil: _studioHolo,
                maxTiltAngle: _studioMaxTiltAngle,
                textFinish: _studioTextFinish,
                enableEdgeGlow: _studioEdgeGlow,
                enableDiamondDust: _studioDiamondDust,
                enablePaymentPulse: _studioPaymentPulse,
                cardTheme: VerticalCardTheme.metallic(
                  metalType: _studioMetal,
                  chipColor: _studioChip,
                  borderRadius: BorderRadius.circular(_studioBorderRadius),
                ),
              ),
            )
          else
            _buildBankingAppMockup(),

          const SizedBox(height: 24),

          // Sliders & Controls
          Text(
            'Card Width: ${_studioWidth.toInt()} px',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Slider(
            value: _studioWidth,
            min: 200,
            max: 280,
            activeColor: Colors.cyanAccent,
            onChanged: (val) => setState(() => _studioWidth = val),
          ),

          Text(
            'Border Radius: ${_studioBorderRadius.toInt()} px',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Slider(
            value: _studioBorderRadius,
            min: 8,
            max: 28,
            activeColor: Colors.cyanAccent,
            onChanged: (val) => setState(() => _studioBorderRadius = val),
          ),

          Text(
            'Max Tilt Angle: ${(_studioMaxTiltAngle * 180 / 3.14159).toStringAsFixed(1)}°',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Slider(
            value: _studioMaxTiltAngle,
            min: 0.10,
            max: 0.45,
            activeColor: Colors.cyanAccent,
            onChanged: (val) => setState(() => _studioMaxTiltAngle = val),
          ),

          const SizedBox(height: 12),

          // Typography Finish selector
          const Text('Typography 3D Finish:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: CardTextFinish.values.map((finish) {
              final isSelected = _studioTextFinish == finish;
              return ChoiceChip(
                label: Text(finish.name),
                selected: isSelected,
                selectedColor: Colors.amberAccent.withValues(alpha: 0.3),
                onSelected: (sel) {
                  if (sel) setState(() => _studioTextFinish = finish);
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 14),

          // Metal Type selector
          const Text('Metal Finish:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: MetalType.values.map((metal) {
              final isSelected = _studioMetal == metal;
              return ChoiceChip(
                label: Text(metal.name),
                selected: isSelected,
                selectedColor: Colors.cyanAccent.withValues(alpha: 0.25),
                onSelected: (sel) {
                  if (sel) setState(() => _studioMetal = metal);
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 16),

          // Toggles
          SwitchListTile(
            title: const Text('✨ Diamond Dust / Micro-Glitter'),
            value: _studioDiamondDust,
            activeThumbColor: Colors.amberAccent,
            onChanged: (val) => setState(() => _studioDiamondDust = val),
          ),
          SwitchListTile(
            title: const Text('⚡ Cyber Edge Glow (Perimeter Beam)'),
            value: _studioEdgeGlow,
            activeThumbColor: Colors.cyanAccent,
            onChanged: (val) => setState(() => _studioEdgeGlow = val),
          ),
          SwitchListTile(
            title: const Text('📡 NFC Contactless Tap Pulse'),
            value: _studioPaymentPulse,
            activeThumbColor: const Color(0xFF00FFC2),
            onChanged: (val) => setState(() => _studioPaymentPulse = val),
          ),
          SwitchListTile(
            title: const Text('🌈 Holographic Rainbow Foil'),
            value: _studioHolo,
            activeThumbColor: Colors.purpleAccent,
            onChanged: (val) => setState(() => _studioHolo = val),
          ),
          SwitchListTile(
            title: const Text('🕹️ 3D Tilt Physics'),
            value: _studioTilt,
            activeThumbColor: Colors.cyanAccent,
            onChanged: (val) => setState(() => _studioTilt = val),
          ),

          const SizedBox(height: 20),

          // Copy Dart Code button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.copy_rounded, size: 18),
              label: const Text('Copy Dart Code',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                final code = '''
VerticalCard(
  cardNumber: '4000 1234 5678 9010',
  cardHolder: 'DIMAS CLEVES',
  expiryDate: '12/30',
  cvv: '888',
  width: $_studioWidth,
  enable3DTilt: $_studioTilt,
  enableSpecularGlare: $_studioGlare,
  enableHolographicFoil: $_studioHolo,
  textFinish: CardTextFinish.${_studioTextFinish.name},
  enableEdgeGlow: $_studioEdgeGlow,
  enableDiamondDust: $_studioDiamondDust,
  enablePaymentPulse: $_studioPaymentPulse,
  cardTheme: VerticalCardTheme.metallic(
    metalType: MetalType.${_studioMetal.name},
    chipColor: ChipColor.${_studioChip.name},
    borderRadius: BorderRadius.circular($_studioBorderRadius),
  ),
)''';
                Clipboard.setData(ClipboardData(text: code));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('✅ Dart code copied to clipboard!'),
                    backgroundColor: Colors.teal[800],
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 5. REGIONAL FINTECH SELECTOR & BANKING APP MOCKUP
  // ---------------------------------------------------------------------------
  void _showAccountSelectorSheet(BuildContext context) {
    final accounts = [
      {
        'code': 'GLOBAL',
        'country': 'Global (USA / International)',
        'currency': 'USD',
        'flag': '🌎',
        'account': 'Primary Global Account',
        'card': 'Nexus Black Metal',
        'color': Colors.amberAccent,
      },
      {
        'code': 'CO',
        'country': 'Colombia',
        'currency': 'COP',
        'flag': '🇨🇴',
        'account': 'Cuenta Nequi Ahorros',
        'card': 'Nequi Magenta Neon',
        'color': const Color(0xFFFF007A),
      },
      {
        'code': 'MX',
        'country': 'México',
        'currency': 'MXN',
        'flag': '🇲🇽',
        'account': 'Débito Digital SPEI',
        'card': 'Mercado Pago Blue',
        'color': const Color(0xFF009EE3),
      },
      {
        'code': 'BR',
        'country': 'Brasil',
        'currency': 'BRL',
        'flag': '🇧🇷',
        'account': 'Nu Ultravioleta Black',
        'card': 'Nubank Ultravioleta',
        'color': const Color(0xFFC084FC),
      },
      {
        'code': 'AR',
        'country': 'Argentina',
        'currency': 'ARS',
        'flag': '🇦🇷',
        'account': 'Lemon Crypto & Pesos',
        'card': 'Lemon Cash Cyber',
        'color': const Color(0xFF00FF7F),
      },
      {
        'code': 'ES',
        'country': 'España / Europa',
        'currency': 'EUR',
        'flag': '🇪🇸',
        'account': 'N26 Metal IBAN',
        'card': 'N26 Frosted Glass',
        'color': const Color(0xFF00D4B2),
      },
      {
        'code': 'PE',
        'country': 'Perú',
        'currency': 'PEN',
        'flag': '🇵🇪',
        'account': 'Yape BCP Digital',
        'card': 'Yape Royal Purple',
        'color': const Color(0xFF862799),
      },
      {
        'code': 'CL',
        'country': 'Chile',
        'currency': 'CLP',
        'flag': '🇨🇱',
        'account': 'Cuenta Prepago Tenpo',
        'card': 'Tenpo Petrol & Teal',
        'color': const Color(0xFF00C9A7),
      },
      {
        'code': 'UK',
        'country': 'United Kingdom',
        'currency': 'GBP',
        'flag': '🇬🇧',
        'account': 'Monzo Current Account',
        'card': 'Monzo Hot Coral',
        'color': const Color(0xFFFF483B),
      },
      {
        'code': 'US',
        'country': 'United States',
        'currency': 'USD',
        'flag': '🇺🇸',
        'account': 'Robinhood Gold Cash',
        'card': 'Robinhood Gold Metal',
        'color': const Color(0xFFD4AF37),
      },
    ];

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF0F1420),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 38,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Icon(Icons.account_balance_wallet_rounded,
                        size: 20, color: Colors.cyanAccent),
                    SizedBox(width: 8),
                    Text(
                      'Select Active Account & Region',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Switching accounts updates currency, live card and local merchant transactions.',
                  style: TextStyle(fontSize: 12, color: Colors.white54),
                ),
                const SizedBox(height: 14),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: accounts.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 6),
                    itemBuilder: (context, index) {
                      final acc = accounts[index];
                      final isSelected = _studioCountryCode == acc['code'];
                      final color = acc['color'] as Color;

                      return InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () {
                          setState(() {
                            _studioCountryCode = acc['code'] as String;
                          });
                          Navigator.pop(sheetContext);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? color.withValues(alpha: 0.12)
                                : const Color(0xFF141926),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? color
                                  : Colors.white.withValues(alpha: 0.06),
                              width: isSelected ? 1.2 : 0.8,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                acc['flag'] as String,
                                style: const TextStyle(fontSize: 22),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      acc['country'] as String,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        color:
                                            isSelected ? color : Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${acc['account']} · ${acc['card']}',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.white54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  acc['currency'] as String,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: color,
                                  ),
                                ),
                              ),
                              if (isSelected) ...[
                                const SizedBox(width: 8),
                                Icon(Icons.check_circle_rounded,
                                    size: 18, color: color),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCountrySelector() {
    final countries = [
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

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: countries.map((country) {
          final isSelected = _studioCountryCode == country['code'];
          return Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                setState(() {
                  _studioCountryCode = country['code']!;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.cyanAccent.withValues(alpha: 0.18)
                      : const Color(0xFF141824),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? Colors.cyanAccent
                        : Colors.white.withValues(alpha: 0.08),
                    width: isSelected ? 1.2 : 0.8,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.cyanAccent.withValues(alpha: 0.25),
                            blurRadius: 8,
                            spreadRadius: 0.5,
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      country['flag']!,
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      country['label']!,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight:
                            isSelected ? FontWeight.w800 : FontWeight.w600,
                        color: isSelected ? Colors.cyanAccent : Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBankingAppMockup() {
    final cardMockupWidth = _studioWidth.clamp(190.0, 225.0);

    final String currency;
    final String balance;
    final String trend;
    final String accountType;
    final String accountTag;
    final Color accountTagColor;
    final String bankName;
    final String cardHolder;
    final String cardNumber;
    final VerticalCardTheme activeCardTheme;
    final List<Map<String, dynamic>> transactions;

    switch (_studioCountryCode) {
      case 'CO':
        currency = 'COP';
        balance = r'$4.850.000';
        trend = '+5.2% este mes';
        accountTag = 'COLOMBIA FINTECH';
        accountTagColor = const Color(0xFFFF007A);
        accountType = 'Cuenta Nequi Ahorros';
        bankName = 'NEQUI';
        cardHolder = 'DIMAS CLEVES';
        cardNumber = '4512 8839 0192 4812';
        activeCardTheme = CardPresets.nequi.copyWith(
          borderRadius: BorderRadius.circular(_studioBorderRadius),
        );
        transactions = [
          {
            'title': 'Rappi Prime',
            'subtitle': 'Domicilio Gourmet · Nequi',
            'amount': r'-$34.900',
            'time': 'Hoy, 1:45 PM',
            'isIncome': false,
            'icon': Icons.delivery_dining_rounded,
            'iconBg': const Color(0xFF2C1A24),
          },
          {
            'title': 'Éxito Wow Poblado',
            'subtitle': 'Supermercado · Contactless',
            'amount': r'-$185.400',
            'time': 'Hoy, 11:20 AM',
            'isIncome': false,
            'icon': Icons.shopping_bag_outlined,
            'iconBg': const Color(0xFF2B2818),
          },
          {
            'title': 'Bancolombia Nómina',
            'subtitle': 'Transferencia directa recibida',
            'amount': r'+$1.200.000',
            'time': 'Ayer',
            'isIncome': true,
            'icon': Icons.account_balance_rounded,
            'iconBg': const Color(0xFF162529),
          },
          {
            'title': 'Spotify Premium',
            'subtitle': 'Suscripción mensual',
            'amount': r'-$16.900',
            'time': '15 Sep',
            'isIncome': false,
            'icon': Icons.music_note_rounded,
            'iconBg': const Color(0xFF172B1E),
          },
        ];
        break;

      case 'MX':
        currency = 'MXN';
        balance = r'$28,500.00';
        trend = '+4.1% este mes';
        accountTag = 'MÉXICO FINTECH';
        accountTagColor = const Color(0xFF009EE3);
        accountType = 'Débito Digital SPEI';
        bankName = 'MERCADO PAGO';
        cardHolder = 'DIMAS CLEVES';
        cardNumber = '5256 7102 9940 1834';
        activeCardTheme = CardPresets.mercadoPago.copyWith(
          borderRadius: BorderRadius.circular(_studioBorderRadius),
        );
        transactions = [
          {
            'title': 'Mercado Libre',
            'subtitle': 'Auriculares Sony WH-1000XM5',
            'amount': r'-$1,499.00',
            'time': 'Hoy, 3:15 PM',
            'isIncome': false,
            'icon': Icons.shopping_cart_outlined,
            'iconBg': const Color(0xFF162535),
          },
          {
            'title': 'OXXO Gas',
            'subtitle': 'Gasolina Premium · Contactless',
            'amount': r'-$650.00',
            'time': 'Hoy, 9:30 AM',
            'isIncome': false,
            'icon': Icons.local_gas_station_rounded,
            'iconBg': const Color(0xFF2C1919),
          },
          {
            'title': 'SPEI Nómina Directa',
            'subtitle': 'Fintech Hub SA · SPEI',
            'amount': r'+$14,250.00',
            'time': 'Ayer',
            'isIncome': true,
            'icon': Icons.account_balance_rounded,
            'iconBg': const Color(0xFF162A20),
          },
          {
            'title': 'Cinépolis VIP',
            'subtitle': 'Entradas y combos · Cine',
            'amount': r'-$320.00',
            'time': '14 Sep',
            'isIncome': false,
            'icon': Icons.movie_creation_outlined,
            'iconBg': const Color(0xFF1E212E),
          },
        ];
        break;

      case 'BR':
        currency = 'BRL';
        balance = r'R$ 8.450,00';
        trend = '+6.5% este mês';
        accountTag = 'BRASIL FINTECH';
        accountTagColor = const Color(0xFFC084FC);
        accountType = 'Nu Ultravioleta Black';
        bankName = 'NUBANK BR';
        cardHolder = 'DIMAS CLEVES';
        cardNumber = '5409 3321 8765 4019';
        activeCardTheme = CardPresets.nubankUltravioleta.copyWith(
          borderRadius: BorderRadius.circular(_studioBorderRadius),
        );
        transactions = [
          {
            'title': 'iFood Delivery',
            'subtitle': 'Restaurante Fogo de Chão',
            'amount': r'-R$ 74,90',
            'time': 'Hoje, 13:10',
            'isIncome': false,
            'icon': Icons.fastfood_rounded,
            'iconBg': const Color(0xFF2C1A1D),
          },
          {
            'title': 'Mercado Livre Brasil',
            'subtitle': 'Eletrônicos & Casa',
            'amount': r'-R$ 289,00',
            'time': 'Hoje, 10:04',
            'isIncome': false,
            'icon': Icons.shopping_bag_outlined,
            'iconBg': const Color(0xFF2B2818),
          },
          {
            'title': 'Transferência PIX Recebida',
            'subtitle': 'De: Lucas Santos · PIX chave',
            'amount': r'+R$ 2.500,00',
            'time': 'Ontem',
            'isIncome': true,
            'icon': Icons.bolt_rounded,
            'iconBg': const Color(0xFF162C24),
          },
          {
            'title': 'Uber Viagens',
            'subtitle': 'Corrida São Paulo · Apple Pay',
            'amount': r'-R$ 32,50',
            'time': '16 Set',
            'isIncome': false,
            'icon': Icons.directions_car_rounded,
            'iconBg': const Color(0xFF20232B),
          },
        ];
        break;

      case 'AR':
        currency = 'ARS';
        balance = r'$1.250.000';
        trend = '+12.4% este mes';
        accountTag = 'ARGENTINA CRYPTO';
        accountTagColor = const Color(0xFF00FF7F);
        accountType = 'Lemon Crypto & Pesos';
        bankName = 'LEMON CASH';
        cardHolder = 'DIMAS CLEVES';
        cardNumber = '4123 9087 6543 2100';
        activeCardTheme = CardPresets.lemonCash.copyWith(
          borderRadius: BorderRadius.circular(_studioBorderRadius),
        );
        transactions = [
          {
            'title': 'PedidosYa Gourmet',
            'subtitle': 'Almuerzo Hamburguesería',
            'amount': r'-$14.500',
            'time': 'Hoy, 13:50',
            'isIncome': false,
            'icon': Icons.moped_rounded,
            'iconBg': const Color(0xFF2C191E),
          },
          {
            'title': 'Coto Digital',
            'subtitle': 'Supermercado semanal · QR',
            'amount': r'-$68.200',
            'time': 'Hoy, 10:15',
            'isIncome': false,
            'icon': Icons.local_grocery_store_outlined,
            'iconBg': const Color(0xFF1B262C),
          },
          {
            'title': 'Lemon Earn Cashback',
            'subtitle': 'Cashback 2% en Bitcoin (BTC)',
            'amount': r'+$12.350',
            'time': 'Ayer',
            'isIncome': true,
            'icon': Icons.currency_bitcoin_rounded,
            'iconBg': const Color(0xFF252B14),
          },
          {
            'title': 'Steam Games LatAm',
            'subtitle': 'Videojuegos PC · Digital',
            'amount': r'-$9.800',
            'time': '15 Sep',
            'isIncome': false,
            'icon': Icons.sports_esports_outlined,
            'iconBg': const Color(0xFF1B202D),
          },
        ];
        break;

      case 'ES':
        currency = 'EUR';
        balance = r'€12.350,00';
        trend = '+2.9% this month';
        accountTag = 'EUROPE BANK';
        accountTagColor = const Color(0xFF00D4B2);
        accountType = 'N26 Metal IBAN';
        bankName = 'N26';
        cardHolder = 'DIMAS CLEVES';
        cardNumber = '4921 5432 1098 7654';
        activeCardTheme = CardPresets.n26.copyWith(
          borderRadius: BorderRadius.circular(_studioBorderRadius),
        );
        transactions = [
          {
            'title': 'El Corte Inglés',
            'subtitle': 'Moda y Accesorios · Contactless',
            'amount': r'-€129,50',
            'time': 'Hoy, 16:30',
            'isIncome': false,
            'icon': Icons.storefront_rounded,
            'iconBg': const Color(0xFF1C2B22),
          },
          {
            'title': 'Mercadona',
            'subtitle': 'Alimentación · Pago móvil',
            'amount': r'-€64,20',
            'time': 'Hoy, 12:10',
            'isIncome': false,
            'icon': Icons.shopping_cart_outlined,
            'iconBg': const Color(0xFF1B2827),
          },
          {
            'title': 'SEPA Payroll Transfer',
            'subtitle': 'Empresa Tecnológica SL',
            'amount': r'+€2.850,00',
            'time': 'Ayer',
            'isIncome': true,
            'icon': Icons.account_balance_outlined,
            'iconBg': const Color(0xFF16252A),
          },
          {
            'title': 'Glovo Prime',
            'subtitle': 'Envío express farmacia',
            'amount': r'-€18,90',
            'time': '16 Sep',
            'isIncome': false,
            'icon': Icons.delivery_dining_rounded,
            'iconBg': const Color(0xFF2B2519),
          },
        ];
        break;

      case 'PE':
        currency = 'PEN';
        balance = r'S/. 4,280.50';
        trend = '+5.8% este mes';
        accountTag = 'PERÚ FINTECH';
        accountTagColor = const Color(0xFF862799);
        accountType = 'Yape Cuenta Digital BCP';
        bankName = 'YAPE BCP';
        cardHolder = 'DIMAS CLEVES';
        cardNumber = '4218 9032 1145 7820';
        activeCardTheme = CardPresets.yape.copyWith(
          borderRadius: BorderRadius.circular(_studioBorderRadius),
        );
        transactions = [
          {
            'title': 'Bembos Gourmet',
            'subtitle': 'Combo La Clásica · Delivery Yape',
            'amount': r'-S/. 38.50',
            'time': 'Hoy, 2:10 PM',
            'isIncome': false,
            'icon': Icons.fastfood_rounded,
            'iconBg': const Color(0xFF2E1A2B),
          },
          {
            'title': 'Metro Cencosud',
            'subtitle': 'Supermercado · Pago QR',
            'amount': r'-S/. 142.00',
            'time': 'Hoy, 10:45 AM',
            'isIncome': false,
            'icon': Icons.shopping_basket_outlined,
            'iconBg': const Color(0xFF1E2829),
          },
          {
            'title': 'Transferencia Yape Directa',
            'subtitle': 'De: Carlos M. · Celular Yape',
            'amount': r'+S/. 350.00',
            'time': 'Ayer',
            'isIncome': true,
            'icon': Icons.bolt_rounded,
            'iconBg': const Color(0xFF192B28),
          },
          {
            'title': 'Cineplanet Prime',
            'subtitle': 'Entradas San Miguel · Tarjeta',
            'amount': r'-S/. 45.00',
            'time': '16 Sep',
            'isIncome': false,
            'icon': Icons.movie_creation_outlined,
            'iconBg': const Color(0xFF28192A),
          },
        ];
        break;

      case 'CL':
        currency = 'CLP';
        balance = r'$840.000';
        trend = '+7.2% este mes';
        accountTag = 'CHILE FINTECH';
        accountTagColor = const Color(0xFF00C9A7);
        accountType = 'Cuenta Prepago Tenpo';
        bankName = 'TENPO';
        cardHolder = 'DIMAS CLEVES';
        cardNumber = '5109 2384 9012 3456';
        activeCardTheme = CardPresets.tenpo.copyWith(
          borderRadius: BorderRadius.circular(_studioBorderRadius),
        );
        transactions = [
          {
            'title': 'Jumbo La Dehesa',
            'subtitle': 'Supermercado · Contactless',
            'amount': r'-$64.990',
            'time': 'Hoy, 12:40 PM',
            'isIncome': false,
            'icon': Icons.local_grocery_store_outlined,
            'iconBg': const Color(0xFF162B28),
          },
          {
            'title': 'Uber Eats Santiago',
            'subtitle': 'Sushi Roll · Tenpo Mastercard',
            'amount': r'-$14.500',
            'time': 'Hoy, 1:15 PM',
            'isIncome': false,
            'icon': Icons.delivery_dining_rounded,
            'iconBg': const Color(0xFF2B221A),
          },
          {
            'title': 'Transferencia TEF Recibida',
            'subtitle': 'Fintech Chile SpA · TEF',
            'amount': r'+$450.000',
            'time': 'Ayer',
            'isIncome': true,
            'icon': Icons.account_balance_rounded,
            'iconBg': const Color(0xFF142922),
          },
          {
            'title': 'Copec Pronto',
            'subtitle': 'Combustible 95 · Pago App',
            'amount': r'-$25.000',
            'time': '15 Sep',
            'isIncome': false,
            'icon': Icons.local_gas_station_rounded,
            'iconBg': const Color(0xFF2A1F18),
          },
        ];
        break;

      case 'UK':
        currency = 'GBP';
        balance = r'£3,420.80';
        trend = '+3.4% this month';
        accountTag = 'UK NEOBANK';
        accountTagColor = const Color(0xFFFF483B);
        accountType = 'Monzo Current Account';
        bankName = 'MONZO';
        cardHolder = 'DIMAS CLEVES';
        cardNumber = '5355 2201 9845 6712';
        activeCardTheme = CardPresets.monzoHotCoral.copyWith(
          borderRadius: BorderRadius.circular(_studioBorderRadius),
        );
        transactions = [
          {
            'title': 'Pret A Manger London',
            'subtitle': 'Organic Flat White & Sandwich',
            'amount': r'-£6.45',
            'time': 'Today, 1:05 PM',
            'isIncome': false,
            'icon': Icons.coffee_rounded,
            'iconBg': const Color(0xFF2B1919),
          },
          {
            'title': 'Sainsbury’s Local',
            'subtitle': 'Groceries · Apple Pay',
            'amount': r'-£24.80',
            'time': 'Today, 11:15 AM',
            'isIncome': false,
            'icon': Icons.shopping_bag_outlined,
            'iconBg': const Color(0xFF2A2016),
          },
          {
            'title': 'Faster Payments Salary',
            'subtitle': 'Monzo Labs UK · Direct Credit',
            'amount': r'+£2,850.00',
            'time': 'Yesterday',
            'isIncome': true,
            'icon': Icons.account_balance_rounded,
            'iconBg': const Color(0xFF162A22),
          },
          {
            'title': 'Transport for London (TfL)',
            'subtitle': 'Contactless Tube / Underground',
            'amount': r'-£3.40',
            'time': '16 Sep',
            'isIncome': false,
            'icon': Icons.train_rounded,
            'iconBg': const Color(0xFF1B232E),
          },
        ];
        break;

      case 'US':
        currency = 'USD';
        balance = r'$9,250.00';
        trend = '+8.1% this month';
        accountTag = 'USA WEALTH & CASH';
        accountTagColor = const Color(0xFFD4AF37);
        accountType = 'Robinhood Gold Cash Account';
        bankName = 'ROBINHOOD';
        cardHolder = 'DIMAS CLEVES';
        cardNumber = '4929 1845 0092 3819';
        activeCardTheme = CardPresets.robinhoodGold.copyWith(
          borderRadius: BorderRadius.circular(_studioBorderRadius),
        );
        transactions = [
          {
            'title': 'Whole Foods Market',
            'subtitle': 'Organic Groceries · Gold Card',
            'amount': r'-$78.20',
            'time': 'Today, 2:40 PM',
            'isIncome': false,
            'icon': Icons.shopping_basket_outlined,
            'iconBg': const Color(0xFF262615),
          },
          {
            'title': 'Blue Bottle Coffee',
            'subtitle': 'Hayes Valley Espresso',
            'amount': r'-$7.50',
            'time': 'Today, 9:20 AM',
            'isIncome': false,
            'icon': Icons.coffee_rounded,
            'iconBg': const Color(0xFF1A232D),
          },
          {
            'title': 'High-Yield Cash Interest',
            'subtitle': '5.0% APY Monthly Sweep',
            'amount': r'+$38.50',
            'time': 'Yesterday',
            'isIncome': true,
            'icon': Icons.trending_up_rounded,
            'iconBg': const Color(0xFF162B1D),
          },
          {
            'title': 'Target Superstore',
            'subtitle': 'Electronics & Home Goods',
            'amount': r'-$42.10',
            'time': '15 Sep',
            'isIncome': false,
            'icon': Icons.storefront_rounded,
            'iconBg': const Color(0xFF2C1818),
          },
        ];
        break;

      case 'GLOBAL':
      default:
        currency = 'USD';
        balance = r'$14,850.50';
        trend = '+3.8% this month';
        accountTag = 'BLACK METAL';
        accountTagColor = Colors.amberAccent;
        accountType = 'Primary Global Account';
        bankName = 'NEXUS BLACK';
        cardHolder = 'DIMAS CLEVES';
        cardNumber = '4000 1234 5678 9010';
        activeCardTheme = VerticalCardTheme.metallic(
          metalType: _studioMetal,
          chipColor: _studioChip,
          borderRadius: BorderRadius.circular(_studioBorderRadius),
        );
        transactions = [
          {
            'title': 'Apple Store',
            'subtitle': 'iPhone 16 Pro 256GB · Card',
            'amount': r'-$1,199.00',
            'time': 'Today, 2:20 PM',
            'isIncome': false,
            'icon': Icons.apple_rounded,
            'iconBg': const Color(0xFF1E2433),
          },
          {
            'title': 'Starbucks Reserve',
            'subtitle': 'Caramel Macchiato · Contactless',
            'amount': r'-$6.80',
            'time': 'Today, 9:15 AM',
            'isIncome': false,
            'icon': Icons.coffee_rounded,
            'iconBg': const Color(0xFF1A2621),
          },
          {
            'title': 'Payroll Deposit',
            'subtitle': 'Google LLC · Direct Deposit',
            'amount': r'+$3,450.00',
            'time': 'Yesterday',
            'isIncome': true,
            'icon': Icons.work_outline_rounded,
            'iconBg': const Color(0xFF172C24),
          },
          {
            'title': 'Netflix 4K Ultra',
            'subtitle': 'Monthly Subscription',
            'amount': r'-$19.99',
            'time': 'Sep 15',
            'isIncome': false,
            'icon': Icons.movie_outlined,
            'iconBg': const Color(0xFF2C1A22),
          },
        ];
        break;
    }

    return Center(
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 360),
        decoration: BoxDecoration(
          color: const Color(0xFF0C0F17),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: const Color(0xFF232838),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.55),
              blurRadius: 28,
              offset: const Offset(0, 12),
            ),
            BoxShadow(
              color: Colors.cyanAccent.withValues(alpha: 0.04),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Bar & Dynamic Island
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '9:41',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 76,
                  height: 18,
                  decoration: BoxDecoration(
                    color: const Color(0xFF05070A),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF00FFC2),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.signal_cellular_alt_rounded,
                      size: 13,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.wifi_rounded,
                      size: 13,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.battery_5_bar_rounded,
                      size: 15,
                      color: Color(0xFF00FFC2),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 14),

            // User Profile Header
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00E5FF), Color(0xFF7C4DFF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.cyanAccent.withValues(alpha: 0.3),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'DC',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 9,
                        height: 9,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00FFC2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF0C0F17),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello, Dimas 👋',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      InkWell(
                        borderRadius: BorderRadius.circular(6),
                        onTap: () => _showAccountSelectorSheet(context),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 1.5,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      accountTagColor.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color:
                                        accountTagColor.withValues(alpha: 0.4),
                                    width: 0.6,
                                  ),
                                ),
                                child: Text(
                                  accountTag,
                                  style: TextStyle(
                                    fontSize: 8.5,
                                    fontWeight: FontWeight.w800,
                                    color: accountTagColor,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  accountType,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 14,
                                color: accountTagColor.withValues(alpha: 0.9),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFF161A26),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.notifications_outlined,
                        size: 18,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                      Positioned(
                        top: 6,
                        right: 7,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Account Balance Card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF141926), Color(0xFF0F131E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TOTAL AVAILABLE BALANCE',
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          color: Colors.white.withValues(alpha: 0.55),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          setState(() {
                            _hideBankingBalance = !_hideBankingBalance;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            _hideBankingBalance
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            size: 16,
                            color: Colors.cyanAccent.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            _hideBankingBalance ? '••••••••' : balance,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 6),
                          InkWell(
                            borderRadius: BorderRadius.circular(6),
                            onTap: () => _showAccountSelectorSheet(context),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 1),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    currency,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.cyanAccent,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 14,
                                    color: Colors.cyanAccent
                                        .withValues(alpha: 0.8),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 3.5,
                        ),
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFF00FFC2).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color:
                                const Color(0xFF00FFC2).withValues(alpha: 0.35),
                            width: 0.8,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.trending_up_rounded,
                              size: 13,
                              color: Color(0xFF00FFC2),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              trend,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF00FFC2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Live Customized Vertical Card Embedded
            Center(
              child: VerticalCard(
                cardNumber: cardNumber,
                cardHolder: cardHolder,
                expiryDate: '12/30',
                cvv: _dynamicCvv,
                bankName: bankName,
                width: cardMockupWidth,
                isFrozen: _studioIsFrozen,
                isPrivacyMode: _studioPrivacy,
                enable3DTilt: _studioTilt,
                enableSpecularGlare: _studioGlare,
                enableHolographicFoil: _studioHolo,
                maxTiltAngle: _studioMaxTiltAngle,
                textFinish: _studioTextFinish,
                enableEdgeGlow: _studioEdgeGlow,
                enableDiamondDust: _studioDiamondDust,
                enablePaymentPulse: _studioPaymentPulse,
                cardTheme: activeCardTheme,
              ),
            ),

            const SizedBox(height: 10),

            // Dynamic Security CVV Odometer Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF141926),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.cyanAccent.withValues(alpha: 0.25),
                  width: 0.8,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.shield_outlined,
                    size: 14,
                    color: Colors.cyanAccent,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'CVV: ',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white70,
                    ),
                  ),
                  RollingDigitText(
                    text: _dynamicCvv,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w900,
                      color: Colors.cyanAccent,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(6),
                    onTap: _regenerateDynamicCvv,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.cyanAccent.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.cyanAccent.withValues(alpha: 0.4),
                          width: 0.8,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.refresh_rounded,
                            size: 12,
                            color: Colors.cyanAccent,
                          ),
                          SizedBox(width: 3),
                          Text(
                            'Rotate CVV',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: Colors.cyanAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Card Interactive Action Controls
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: _studioIsFrozen
                        ? Icons.ac_unit_rounded
                        : Icons.lock_outline_rounded,
                    label: _studioIsFrozen ? 'Unfreeze' : 'Freeze',
                    isActive: _studioIsFrozen,
                    activeColor: Colors.cyanAccent,
                    onTap: () {
                      setState(() {
                        _studioIsFrozen = !_studioIsFrozen;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.contactless_rounded,
                    label: _studioPaymentPulse ? 'NFC Active' : 'Tap to Pay',
                    isActive: _studioPaymentPulse,
                    activeColor: const Color(0xFF00FFC2),
                    onTap: () {
                      setState(() {
                        _studioPaymentPulse = !_studioPaymentPulse;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            _studioPaymentPulse
                                ? '📡 Contactless payment radar activated'
                                : '⏸️ Contactless payment paused',
                          ),
                          backgroundColor: Colors.teal[800],
                          duration: const Duration(milliseconds: 1200),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildActionButton(
                    icon: _studioPrivacy
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    label: _studioPrivacy ? 'Show' : 'Hide',
                    isActive: _studioPrivacy,
                    activeColor: Colors.amberAccent,
                    onTap: () {
                      setState(() {
                        _studioPrivacy = !_studioPrivacy;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Recent Transactions Section
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.cyanAccent.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            ...transactions.map(
              (tx) => Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: _buildTransactionTile(
                  title: tx['title'] as String,
                  subtitle: tx['subtitle'] as String,
                  amount: tx['amount'] as String,
                  time: tx['time'] as String,
                  isIncome: tx['isIncome'] as bool,
                  icon: tx['icon'] as IconData,
                  iconBg: tx['iconBg'] as Color,
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Home Bar Indicator
            Center(
              child: Container(
                width: 110,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? activeColor.withValues(alpha: 0.18)
              : const Color(0xFF161A26),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive
                ? activeColor.withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 17,
              color: isActive ? activeColor : Colors.white70,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? activeColor : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionTile({
    required String title,
    required String subtitle,
    required String amount,
    required String time,
    required bool isIncome,
    required IconData icon,
    required Color iconBg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF121622),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 18,
              color: isIncome ? const Color(0xFF00FFC2) : Colors.white70,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withValues(alpha: 0.45),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: isIncome ? const Color(0xFF00FFC2) : Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                time,
                style: TextStyle(
                  fontSize: 9.5,
                  color: Colors.white.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
