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
  int _selectedPresetIndex = 5; // Default to Holo Infinite

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
  ChipColor _studioChip = ChipColor.gold;
  CardTextFinish _studioTextFinish = CardTextFinish.goldFoil;
  bool _studioEdgeGlow = false;
  bool _studioDiamondDust = true;
  bool _studioPaymentPulse = true;
  bool _studioHolo = false;
  bool _studioTilt = true;
  bool _studioGlare = true;
  bool _studioBankingView = false;
  bool _studioIsFrozen = false;
  bool _studioPrivacy = false;
  bool _hideBankingBalance = false;

  final List<Map<String, dynamic>> _presets = [
    {'name': 'Nubank', 'family': 'Neobank', 'theme': CardPresets.nubank},
    {'name': 'Wise', 'family': 'Neobank', 'theme': CardPresets.wise},
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
      'name': 'Revolut Fluid',
      'family': 'Chromatic',
      'theme': CardPresets.revolutChromatic,
    },
    {
      'name': 'Holo Infinite',
      'family': 'Holographic',
      'theme': CardPresets.holoInfinite,
    },
    {
      'name': 'Painterly Globe',
      'family': 'Family D',
      'theme': CardPresets.painterlyGlobe,
    },
    {
      'name': 'Topographic Gold',
      'family': 'Family D',
      'theme': CardPresets.topographicGold,
    },
    {
      'name': 'Carbon Stealth',
      'family': 'Family D',
      'theme': CardPresets.carbonStealth,
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
        indicatorColor: Colors.cyanAccent.withOpacity(0.18),
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

                  // Horizontal Presets Carousel
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: List.generate(_presets.length, (index) {
                        final preset = _presets[index];
                        final isSelected = _selectedPresetIndex == index;
                        final isFamilyD = preset['family'] == 'Family D';
                        final isHolo = preset['family'] == 'Holographic';

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ChoiceChip(
                            avatar: isHolo
                                ? const Icon(Icons.auto_awesome_rounded,
                                    size: 16, color: Colors.purpleAccent)
                                : (isFamilyD
                                    ? const Icon(Icons.palette_outlined,
                                        size: 16, color: Colors.amberAccent)
                                    : null),
                            label: Text(preset['name'] as String),
                            selected: isSelected,
                            selectedColor: isHolo
                                ? Colors.purpleAccent.withOpacity(0.22)
                                : (isFamilyD
                                    ? Colors.amberAccent.withOpacity(0.22)
                                    : Colors.cyanAccent.withOpacity(0.22)),
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? (isHolo
                                      ? Colors.purpleAccent
                                      : (isFamilyD
                                          ? Colors.amberAccent
                                          : Colors.cyanAccent))
                                  : Colors.white70,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            side: BorderSide(
                              color: isSelected
                                  ? (isHolo
                                      ? Colors.purpleAccent
                                      : (isFamilyD
                                          ? Colors.amberAccent
                                          : Colors.cyanAccent))
                                  : Colors.white12,
                            ),
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _selectedPresetIndex = index;
                                });
                              }
                            },
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Gesture Instruction Banner
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.swipe_outlined,
                        size: 15,
                        color: Colors.white.withOpacity(0.45),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _isBackVisible
                            ? 'Tap to flip FRONT  •  Drag to TILT in 3D'
                            : 'Tap to FLIP 3D  •  Drag to TILT with light reflection',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.45),
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
                      border: Border.all(color: Colors.white.withOpacity(0.07)),
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
                    ? activeColor.withOpacity(0.20)
                    : Colors.white.withOpacity(0.05),
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
                  color: Colors.white.withOpacity(0.6),
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
              color: Colors.cyanAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
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
                    color: Colors.cyanAccent.withOpacity(0.9),
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
                selectedColor: Colors.amberAccent.withOpacity(0.3),
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
                selectedColor: Colors.cyanAccent.withOpacity(0.25),
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
            activeColor: Colors.amberAccent,
            onChanged: (val) => setState(() => _studioDiamondDust = val),
          ),
          SwitchListTile(
            title: const Text('⚡ Cyber Edge Glow (Perimeter Beam)'),
            value: _studioEdgeGlow,
            activeColor: Colors.cyanAccent,
            onChanged: (val) => setState(() => _studioEdgeGlow = val),
          ),
          SwitchListTile(
            title: const Text('📡 NFC Contactless Tap Pulse'),
            value: _studioPaymentPulse,
            activeColor: const Color(0xFF00FFC2),
            onChanged: (val) => setState(() => _studioPaymentPulse = val),
          ),
          SwitchListTile(
            title: const Text('🌈 Holographic Rainbow Foil'),
            value: _studioHolo,
            activeColor: Colors.purpleAccent,
            onChanged: (val) => setState(() => _studioHolo = val),
          ),
          SwitchListTile(
            title: const Text('🕹️ 3D Tilt Physics'),
            value: _studioTilt,
            activeColor: Colors.cyanAccent,
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
  // 5. BANKING APP REALISTIC MOCKUP (STUDIO OPTION A)
  // ---------------------------------------------------------------------------
  Widget _buildBankingAppMockup() {
    final cardMockupWidth = _studioWidth.clamp(190.0, 225.0);

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
              color: Colors.black.withOpacity(0.55),
              blurRadius: 28,
              offset: const Offset(0, 12),
            ),
            BoxShadow(
              color: Colors.cyanAccent.withOpacity(0.04),
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
                      color: Colors.white.withOpacity(0.08),
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
                          color: Colors.white.withOpacity(0.2),
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
                      color: Colors.white.withOpacity(0.85),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.wifi_rounded,
                      size: 13,
                      color: Colors.white.withOpacity(0.85),
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
                            color: Colors.cyanAccent.withOpacity(0.3),
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
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 6,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 1.5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amberAccent.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Colors.amberAccent.withOpacity(0.4),
                                width: 0.6,
                              ),
                            ),
                            child: const Text(
                              'BLACK METAL',
                              style: TextStyle(
                                fontSize: 8.5,
                                fontWeight: FontWeight.w800,
                                color: Colors.amberAccent,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ),
                          const Text(
                            'Primary Account',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white54,
                            ),
                          ),
                        ],
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
                      color: Colors.white.withOpacity(0.08),
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.notifications_outlined,
                        size: 18,
                        color: Colors.white.withOpacity(0.8),
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
                  color: Colors.white.withOpacity(0.08),
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
                          color: Colors.white.withOpacity(0.55),
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
                            color: Colors.cyanAccent.withOpacity(0.8),
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
                            _hideBankingBalance ? '••••••••' : r'$14,850.50',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'USD',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.cyanAccent,
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
                          color: const Color(0xFF00FFC2).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF00FFC2).withOpacity(0.35),
                            width: 0.8,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.trending_up_rounded,
                              size: 13,
                              color: Color(0xFF00FFC2),
                            ),
                            SizedBox(width: 4),
                            Text(
                              '+3.8% this month',
                              style: TextStyle(
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
                cardNumber: '4000 1234 5678 9010',
                cardHolder: 'DIMAS CLEVES',
                expiryDate: '12/30',
                cvv: '888',
                bankName: 'NEXUS BLACK',
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
                cardTheme: VerticalCardTheme.metallic(
                  metalType: _studioMetal,
                  chipColor: _studioChip,
                  borderRadius: BorderRadius.circular(_studioBorderRadius),
                ),
              ),
            ),

            const SizedBox(height: 14),

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
                    color: Colors.cyanAccent.withOpacity(0.8),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            _buildTransactionTile(
              title: 'Apple Store',
              subtitle: 'iPhone 16 Pro 256GB · Card',
              amount: r'-$1,199.00',
              time: 'Today, 2:20 PM',
              isIncome: false,
              icon: Icons.apple_rounded,
              iconBg: const Color(0xFF1E2433),
            ),
            const SizedBox(height: 6),
            _buildTransactionTile(
              title: 'Starbucks Reserve',
              subtitle: 'Caramel Macchiato · Contactless',
              amount: r'-$6.80',
              time: 'Today, 9:15 AM',
              isIncome: false,
              icon: Icons.coffee_rounded,
              iconBg: const Color(0xFF1A2621),
            ),
            const SizedBox(height: 6),
            _buildTransactionTile(
              title: 'Payroll Deposit',
              subtitle: 'Google LLC · Direct Deposit',
              amount: r'+$3,450.00',
              time: 'Yesterday',
              isIncome: true,
              icon: Icons.work_outline_rounded,
              iconBg: const Color(0xFF172C24),
            ),
            const SizedBox(height: 6),
            _buildTransactionTile(
              title: 'Netflix 4K Ultra',
              subtitle: 'Monthly Subscription',
              amount: r'-$19.99',
              time: 'Sep 15',
              isIncome: false,
              icon: Icons.movie_outlined,
              iconBg: const Color(0xFF2C1A22),
            ),

            const SizedBox(height: 14),

            // Home Bar Indicator
            Center(
              child: Container(
                width: 110,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
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
              ? activeColor.withOpacity(0.18)
              : const Color(0xFF161A26),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive
                ? activeColor.withOpacity(0.6)
                : Colors.white.withOpacity(0.08),
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
          color: Colors.white.withOpacity(0.05),
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
                    color: Colors.white.withOpacity(0.45),
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
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
