import 'package:flutter/material.dart';
import '../backgrounds/card_background.dart';
import '../models/card_theme.dart';
import '../painters/painterly_globe_painter.dart';

/// Curated library of ready-to-use, professional vertical credit card themes.
class CardPresets {
  const CardPresets._();

  // ---------------------------------------------------------------------------
  // FAMILIA A: NEOBANCOS Y FINTECHS REALES
  // ---------------------------------------------------------------------------

  /// Clean electric purple inspired by Nubank.
  static VerticalCardTheme get nubank => VerticalCardTheme.flat(
        backgroundColor: const Color(0xFF820AD1),
        textColor: Colors.white,
        secondaryTextColor: const Color(0xCCFFFFFF),
        chipColor: ChipColor.silver,
      );

  /// Deep forest green with vibrant lime accents inspired by Wise.
  static VerticalCardTheme get wise => VerticalCardTheme.flat(
        backgroundColor: const Color(0xFF163300),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF163300),
            Color(0xFF224E00),
            Color(0xFF163300),
          ],
        ),
        textColor: const Color(0xFF9FE870), // Wise signature lime
        secondaryTextColor: const Color(0xAA9FE870),
        chipColor: ChipColor.gold,
      );

  // ---------------------------------------------------------------------------
  // FAMILIA B: LUXURY & METALES PESADOS
  // ---------------------------------------------------------------------------

  /// Sleek minimalist brushed titanium inspired by Apple Card.
  static VerticalCardTheme get appleTitanium => VerticalCardTheme.metallic(
        metalType: MetalType.brushedTitanium,
        textColor: const Color(0xFFF0F0F2),
        chipColor: ChipColor.silver,
      );

  /// Stealth matte obsidian black inspired by Amex Centurion.
  static VerticalCardTheme get amexCenturion => VerticalCardTheme.metallic(
        metalType: MetalType.obsidian,
        textColor: Colors.white,
        chipColor: ChipColor.black,
      );

  /// 24k brushed gold prestige card.
  static VerticalCardTheme get goldPrestige => VerticalCardTheme.metallic(
        metalType: MetalType.gold,
        textColor: const Color(0xFF241C0A),
        chipColor: ChipColor.gold,
      );

  // ---------------------------------------------------------------------------
  // FAMILIA C: CYBERPUNK & WEB3
  // ---------------------------------------------------------------------------

  /// Translucent frosted glass with electric cyan neon border.
  static VerticalCardTheme get neonCyan => VerticalCardTheme.glass(
        neonColor: const Color(0xFF00F0FF),
        blur: 14.0,
        chipColor: ChipColor.silver,
      );

  /// Deep terminal black with matrix phosphor-green glow.
  static VerticalCardTheme get matrixGreen => VerticalCardTheme.glass(
        neonColor: const Color(0xFF00FF66),
        blur: 12.0,
        textColor: const Color(0xFF00FF66),
        secondaryTextColor: const Color(0xAA00FF66),
        chipColor: ChipColor.silver,
      );

  // ---------------------------------------------------------------------------
  // FAMILIA D: ARTE ABSTRACTO & TEXTURAS
  // ---------------------------------------------------------------------------

  /// Dynamic orbital painterly globe with warm solar brushstrokes
  /// on a deep navy background (Crédit Agricole Mastercard artistic edition).
  static VerticalCardTheme get painterlyGlobe => VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: const CardBackground.painter(PainterlyGlobePainter()),
        textColor: Colors.white,
        secondaryTextColor: const Color(0xCCFFFFFF),
        chipColor: ChipColor.gold,
      );
}
