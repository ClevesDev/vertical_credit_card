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
      title: 'Vertical Credit Card Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F1115),
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
  int _selectedTemplateIndex = 0; // 0: Flat, 1: Metallic, 2: Glass
  bool _isFrozen = false;
  bool _isBackVisible = false;

  final List<String> _templates = ['Flat Neo', 'Metallic Luxury', 'Glass Cyber'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vertical Credit Card',
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.2),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            // Template Selector Chips
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_templates.length, (index) {
                final isSelected = _selectedTemplateIndex == index;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(_templates[index]),
                    selected: isSelected,
                    selectedColor: Colors.cyanAccent.withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.cyanAccent : Colors.white70,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    side: BorderSide(
                      color: isSelected ? Colors.cyanAccent : Colors.white24,
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedTemplateIndex = index;
                        });
                      }
                    },
                  ),
                );
              }),
            ),

            const SizedBox(height: 16),

            // Hint Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.touch_app_outlined,
                  size: 16,
                  color: Colors.white.withOpacity(0.5),
                ),
                const SizedBox(width: 6),
                Text(
                  _isBackVisible
                      ? 'Tapping will flip to FRONT'
                      : 'Tap the card to FLIP (3D)',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // The Vertical Card Widget
            _buildActiveCard(),

            const Spacer(),

            // Bottom Controls (Freeze card toggle)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF191C24),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.ac_unit_rounded, color: Colors.cyanAccent),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Freeze Card',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Lock card with frost overlay',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
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

  Widget _buildActiveCard() {
    switch (_selectedTemplateIndex) {
      case 0:
        // Flat Nubank-style card
        return VerticalCard.flat(
          cardNumber: '5412 8888 1024 4321',
          cardHolder: 'JUAN PÉREZ',
          expiryDate: '08/29',
          cvv: '821',
          bankName: 'NU',
          backgroundColor: const Color(0xFF820AD1), // Nubank purple
          isFrozen: _isFrozen,
          onFlipChange: (isBack) => setState(() => _isBackVisible = isBack),
        );

      case 1:
        // Metallic Luxury Titanium card
        return VerticalCard.metallic(
          cardNumber: '3782 822468 005',
          cardHolder: 'ELENA ROJAS',
          expiryDate: '11/30',
          cvv: '342',
          bankName: 'BLACK VIP',
          metalType: MetalType.brushedTitanium,
          isFrozen: _isFrozen,
          onFlipChange: (isBack) => setState(() => _isBackVisible = isBack),
        );

      case 2:
      default:
        // Glassmorphic Cyber Neon card
        return VerticalCard.glass(
          cardNumber: '4123 4567 8901 2345',
          cardHolder: 'ALEXANDER WRIGHT',
          expiryDate: '05/28',
          cvv: '912',
          bankName: 'AURORA',
          neonColor: const Color(0xFF00F0FF),
          isFrozen: _isFrozen,
          onFlipChange: (isBack) => setState(() => _isBackVisible = isBack),
        );
    }
  }
}
