import 'package:flutter/material.dart';
import 'package:vertical_credit_card/vertical_credit_card.dart';
import '../data/mock_banking_data.dart';
import '../widgets/banking_app_shell.dart';
import '../widgets/code_export_dialog.dart';

/// Screen providing an interactive sandbox to test all materials, shaders, and controls.
///
/// Features:
/// - Real-time sliders for width, border radius, and 3D tilt angles.
/// - Selector chips for typography finishes (Foil, Embossed, Flat) and metal chassis (Gold, Platinum, Bronze).
/// - Toggles for particle effects (Diamond Dust, Cyber Edge Glow, NFC Radar Pulse, Holographic Rainbow).
/// - Instant "Copy Dart Code" button generating production-ready code for the current configuration.
/// - Live Banking App toggle showcasing the customized card inside a realistic fintech dashboard.
class StudioScreen extends StatefulWidget {
  /// Default constructor for the Studio screen.
  const StudioScreen({super.key});

  @override
  State<StudioScreen> createState() => _StudioScreenState();
}

class _StudioScreenState extends State<StudioScreen> {
  // Studio visual dimensions and angles
  double _studioWidth = 240.0;
  double _studioBorderRadius = 16.0;
  double _studioMaxTiltAngle = 0.24;

  // Material and finish selections
  MetalType _studioMetal = MetalType.gold;
  final ChipColor _studioChip = ChipColor.gold;
  CardTextFinish _studioTextFinish = CardTextFinish.goldFoil;

  // Particle and shader effects
  bool _studioEdgeGlow = false;
  bool _studioDiamondDust = true;
  bool _studioPaymentPulse = true;
  bool _studioHolo = false;
  bool _studioTilt = true;
  final bool _studioGlare = true;

  // Mode and banking shell state
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

  Widget _buildCountrySelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: MockBankingData.countries.map((country) {
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

  @override
  Widget build(BuildContext context) {
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
            BankingAppShell(
              countryCode: _studioCountryCode,
              onCountryChanged: (code) =>
                  setState(() => _studioCountryCode = code),
              cardWidth: _studioWidth,
              cardBorderRadius: _studioBorderRadius,
              dynamicCvv: _dynamicCvv,
              onRegenerateCvv: _regenerateDynamicCvv,
              isFrozen: _studioIsFrozen,
              onToggleFrozen: () =>
                  setState(() => _studioIsFrozen = !_studioIsFrozen),
              isPrivacyMode: _studioPrivacy,
              onTogglePrivacy: () =>
                  setState(() => _studioPrivacy = !_studioPrivacy),
              hideBalance: _hideBankingBalance,
              onToggleHideBalance: () =>
                  setState(() => _hideBankingBalance = !_hideBankingBalance),
              enableTilt: _studioTilt,
              enableGlare: _studioGlare,
              enableHolo: _studioHolo,
              maxTiltAngle: _studioMaxTiltAngle,
              textFinish: _studioTextFinish,
              enableEdgeGlow: _studioEdgeGlow,
              enableDiamondDust: _studioDiamondDust,
              enablePaymentPulse: _studioPaymentPulse,
              onTogglePaymentPulse: () =>
                  setState(() => _studioPaymentPulse = !_studioPaymentPulse),
            ),

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
              onPressed: () => CodeExportHelper.copyToClipboard(
                context,
                width: _studioWidth,
                enableTilt: _studioTilt,
                enableGlare: _studioGlare,
                enableHolo: _studioHolo,
                textFinish: _studioTextFinish,
                enableEdgeGlow: _studioEdgeGlow,
                enableDiamondDust: _studioDiamondDust,
                enablePaymentPulse: _studioPaymentPulse,
                metalType: _studioMetal,
                chipColor: _studioChip,
                borderRadius: _studioBorderRadius,
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
