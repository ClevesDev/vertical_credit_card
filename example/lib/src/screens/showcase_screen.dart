import 'package:flutter/material.dart';
import 'package:vertical_credit_card/vertical_credit_card.dart';
import '../data/preset_catalog.dart';

/// Screen exhibiting the interactive 3D card showcase.
///
/// Features:
/// - Horizontal category filter pill bar (Regional, Materials, Gamer, Crypto, etc.).
/// - Card stepper navigation (`< Card X/Y >`) with animated selection chips.
/// - Live 3D tilt interaction with dynamic lighting and specular reflections.
/// - Card freeze ice-melt transition, privacy masking, and flip controls.
///
/// ### Minimal Implementation Guide:
/// ```dart
/// // Step 1: Add a VerticalCard to your widget tree:
/// VerticalCard(
///   cardNumber: '5412 8888 1024 4321',
///   cardHolder: 'ALEXANDER WRIGHT',
///   expiryDate: '09/29',
///   cvv: '719',
///   enable3DTilt: true, // Enables interactive 3D perspective rotation
///   enableSpecularGlare: true, // Renders realistic moving specular light
///   cardTheme: CardPresets.nequi, // Choose from 44 built-in presets
/// )
/// ```
class ShowcaseScreen extends StatefulWidget {
  /// Whether card numbers are masked for privacy.
  final bool isPrivacyMode;

  /// Callback when privacy mode is toggled either from the screen or app bar.
  final ValueChanged<bool> onPrivacyModeChanged;

  /// Creates an instance of the 3D Showcase screen.
  const ShowcaseScreen({
    super.key,
    required this.isPrivacyMode,
    required this.onPrivacyModeChanged,
  });

  @override
  State<ShowcaseScreen> createState() => _ShowcaseScreenState();
}

class _ShowcaseScreenState extends State<ShowcaseScreen> {
  int _selectedPresetIndex = 12; // Default to Nequi in Regional category
  String _selectedCategory = 'Regional';

  bool _isFrozen = false;
  bool _isExpired = false;
  bool _enable3DTilt = true;
  bool _isBackVisible = false;

  List<Map<String, dynamic>> get _filteredPresets {
    return PresetCatalog.filterByCategory(_selectedCategory);
  }

  Widget _buildShowcaseSelector() {
    final filtered = _filteredPresets;
    final activePreset = PresetCatalog.allPresets[_selectedPresetIndex];
    final activeIndexInFiltered = filtered.indexOf(activePreset);

    return Column(
      children: [
        // 1. Categories Pill Bar
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: PresetCatalog.categories.map((cat) {
              final isSelected = _selectedCategory == cat['id'];
              return Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    setState(() {
                      _selectedCategory = cat['id']!;
                      final newFiltered = _filteredPresets;
                      if (!newFiltered.contains(
                          PresetCatalog.allPresets[_selectedPresetIndex])) {
                        _selectedPresetIndex = PresetCatalog.allPresets
                            .indexOf(newFiltered.first);
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
                          _selectedPresetIndex = PresetCatalog.allPresets
                              .indexOf(filtered[prevIdx]);
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
                          PresetCatalog.allPresets[_selectedPresetIndex] ==
                              preset;
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
                                _selectedPresetIndex = PresetCatalog.allPresets
                                    .indexOf(preset);
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
                          _selectedPresetIndex = PresetCatalog.allPresets
                              .indexOf(filtered[nextIdx]);
                        });
                      },
              ),
            ],
          ),
        ),
      ],
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
    } else if (name == 'Flutter Impeller') {
      bankName = 'FLUTTER GPU';
      brand = CardBrand.generic;
    } else if (name == 'Chromatic Fluid') {
      bankName = 'NEON SILK';
      brand = CardBrand.generic;
    } else if (name == 'Neo Digital Glass') {
      bankName = 'CYBERPUNK';
      brand = CardBrand.generic;
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
      isPrivacyMode: widget.isPrivacyMode,
      enable3DTilt: _enable3DTilt,
      enableSpecularGlare: true,
      onFlipChange: (isBack) => setState(() => _isBackVisible = isBack),
      onPrivacyChange: (isPrivate) => widget.onPrivacyModeChanged(isPrivate),
      bankLogo: bankLogo,
    );
  }

  @override
  Widget build(BuildContext context) {
    final activePreset = PresetCatalog.allPresets[_selectedPresetIndex];

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
                          icon: widget.isPrivacyMode
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          label: 'Privacy',
                          isActive: widget.isPrivacyMode,
                          activeColor: Colors.amberAccent,
                          onTap: () => widget.onPrivacyModeChanged(
                              !widget.isPrivacyMode),
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
}
