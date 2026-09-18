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
  int _selectedPresetIndex = 5; // Default to the brand-new Painterly Globe (Family D)
  bool _isFrozen = false;
  bool _isBackVisible = false;

  final List<Map<String, dynamic>> _presets = [
    {'name': 'Nubank', 'family': 'Neobank', 'theme': CardPresets.nubank},
    {'name': 'Wise', 'family': 'Neobank', 'theme': CardPresets.wise},
    {'name': 'Apple Card', 'family': 'Luxury', 'theme': CardPresets.appleTitanium},
    {'name': 'Amex Black', 'family': 'Luxury', 'theme': CardPresets.amexCenturion},
    {'name': 'Neon Cyber', 'family': 'Cyber', 'theme': CardPresets.neonCyan},
    {'name': 'Painterly Globe', 'family': 'Family D', 'theme': CardPresets.painterlyGlobe},
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),

            // Category & Preset Selector
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
                          ? Colors.amberAccent.withOpacity(0.2)
                          : Colors.cyanAccent.withOpacity(0.2),
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

            const SizedBox(height: 14),

            // Interaction hint
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.touch_app_outlined,
                  size: 16,
                  color: Colors.white.withOpacity(0.45),
                ),
                const SizedBox(width: 6),
                Text(
                  _isBackVisible
                      ? 'Tap card to flip to FRONT'
                      : 'Tap card to FLIP 3D',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.45),
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // The Active Vertical Card
            _buildActiveCard(activePreset),

            const Spacer(),

            // Bottom Controls
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF15181E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.ac_unit_rounded, color: Colors.cyanAccent),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Freeze Card',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            activePreset['name'] as String,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Switch(
                    value: _isFrozen,
                    activeThumbColor: Colors.cyanAccent,
                    onChanged: (val) {
                      setState(() {
                        _isFrozen = val;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveCard(Map<String, dynamic> preset) {
    final theme = preset['theme'] as VerticalCardTheme;
    final isFamilyD = preset['name'] == 'Painterly Globe';

    return VerticalCard(
      cardNumber: isFamilyD ? '5412 7532 9901 8821' : '5412 8888 1024 4321',
      cardHolder: isFamilyD ? 'ALEXANDRE DUPONT' : 'JUAN PÉREZ',
      expiryDate: '09/29',
      cvv: '719',
      brand: isFamilyD ? CardBrand.mastercard : null,
      cardTheme: theme,
      isFrozen: _isFrozen,
      onFlipChange: (isBack) => setState(() => _isBackVisible = isBack),

      // Slot example: Custom bank logo circle for the Crédit Agricole style
      bankLogo: isFamilyD
          ? Container(
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
            )
          : null,
    );
  }
}
