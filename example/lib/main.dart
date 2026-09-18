import 'package:flutter/material.dart';
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
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0C0E12),
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
  int _selectedPresetIndex = 5; // Default to Painterly Globe
  bool _isFrozen = false;
  bool _isExpired = false;
  bool _isPrivacyMode = false;
  bool _enable3DTilt = true;
  bool _isBackVisible = false;

  final List<Map<String, dynamic>> _presets = [
    {'name': 'Nubank', 'family': 'Neobank', 'theme': CardPresets.nubank},
    {'name': 'Wise', 'family': 'Neobank', 'theme': CardPresets.wise},
    {'name': 'Apple Card', 'family': 'Luxury', 'theme': CardPresets.appleTitanium},
    {'name': 'Amex Black', 'family': 'Luxury', 'theme': CardPresets.amexCenturion},
    {'name': 'Neon Cyber', 'family': 'Cyber', 'theme': CardPresets.neonCyan},
    {'name': 'Painterly Globe', 'family': 'Family D', 'theme': CardPresets.painterlyGlobe},
    {'name': 'Topographic Gold', 'family': 'Family D', 'theme': CardPresets.topographicGold},
    {'name': 'Carbon Stealth', 'family': 'Family D', 'theme': CardPresets.carbonStealth},
  ];

  @override
  Widget build(BuildContext context) {
    final activePreset = _presets[_selectedPresetIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vertical Credit Card',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: _isPrivacyMode ? 'Disable Privacy Mode' : 'Enable Privacy Mode',
            icon: Icon(
              _isPrivacyMode ? Icons.visibility_off_rounded : Icons.visibility_rounded,
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

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      avatar: isFamilyD
                          ? const Icon(Icons.palette_outlined, size: 16, color: Colors.amberAccent)
                          : null,
                      label: Text(preset['name'] as String),
                      selected: isSelected,
                      selectedColor: isFamilyD
                          ? Colors.amberAccent.withOpacity(0.22)
                          : Colors.cyanAccent.withOpacity(0.22),
                      labelStyle: TextStyle(
                        color: isSelected
                            ? (isFamilyD ? Colors.amberAccent : Colors.cyanAccent)
                            : Colors.white70,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      side: BorderSide(
                        color: isSelected
                            ? (isFamilyD ? Colors.amberAccent : Colors.cyanAccent)
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
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
                    onTap: () => setState(() => _enable3DTilt = !_enable3DTilt),
                  ),

                  // Privacy mode toggle
                  _buildControlItem(
                    icon: _isPrivacyMode ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                    label: 'Privacy',
                    isActive: _isPrivacyMode,
                    activeColor: Colors.amberAccent,
                    onTap: () => setState(() => _isPrivacyMode = !_isPrivacyMode),
                  ),

                  // Freeze card toggle
                  _buildControlItem(
                    icon: Icons.ac_unit_rounded,
                    label: 'Freeze',
                    isActive: _isFrozen,
                    activeColor: Colors.cyanAccent,
                    onTap: () => setState(() => _isFrozen = !_isFrozen),
                  ),

                  // Expire card toggle
                  _buildControlItem(
                    icon: Icons.block_rounded,
                    label: 'Expired',
                    isActive: _isExpired,
                    activeColor: const Color(0xFFE53935),
                    onTap: () => setState(() => _isExpired = !_isExpired),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
                color: isActive ? activeColor.withOpacity(0.20) : Colors.white.withOpacity(0.05),
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
                fontSize: 11,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? activeColor : Colors.white54,
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

    String bankName = 'NU';
    Widget? bankLogo;
    CardBrand? brand;

    if (name == 'Painterly Globe') {
      bankName = '';
      brand = CardBrand.mastercard;
      bankLogo = Container(
        width: 38,
        height: 38,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
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
      onPrivacyChange: (isPrivate) => setState(() => _isPrivacyMode = isPrivate),
      bankLogo: bankLogo,
    );
  }
}
