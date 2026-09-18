import 'package:flutter/material.dart';
import '../backgrounds/card_background.dart';
import '../models/card_theme.dart';
import '../painters/carbon_fiber_painter.dart';
import '../painters/painterly_globe_painter.dart';
import '../painters/topographic_painter.dart';

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
      ).copyWith(
        textFinish: CardTextFinish.embossed,
      );

  /// Stealth matte obsidian black inspired by Amex Centurion.
  static VerticalCardTheme get amexCenturion => VerticalCardTheme.metallic(
        metalType: MetalType.obsidian,
        textColor: Colors.white,
        chipColor: ChipColor.black,
      ).copyWith(
        textFinish: CardTextFinish.silverFoil,
      );

  /// 24k brushed gold prestige card with gold foil text and subtle diamond dust.
  static VerticalCardTheme get goldPrestige => VerticalCardTheme.metallic(
        metalType: MetalType.gold,
        textColor: const Color(0xFF241C0A),
        chipColor: ChipColor.gold,
      ).copyWith(
        textFinish: CardTextFinish.goldFoil,
        enableDiamondDust: true,
      );

  // ---------------------------------------------------------------------------
  // FAMILIA C: CYBERPUNK & WEB3
  // ---------------------------------------------------------------------------

  /// Translucent frosted glass with electric cyan neon border and animated perimeter glow.
  static VerticalCardTheme get neonCyan => VerticalCardTheme.glass(
        neonColor: const Color(0xFF00F0FF),
        blur: 14.0,
        chipColor: ChipColor.silver,
      ).copyWith(
        enableEdgeGlow: true,
        edgeGlowColor: const Color(0xFF00F0FF),
        enablePaymentPulse: true,
      );

  /// Deep terminal black with matrix phosphor-green glow and animated edge beam.
  static VerticalCardTheme get matrixGreen => VerticalCardTheme.glass(
        neonColor: const Color(0xFF00FF66),
        blur: 12.0,
        textColor: const Color(0xFF00FF66),
        secondaryTextColor: const Color(0xAA00FF66),
        chipColor: ChipColor.silver,
      ).copyWith(
        enableEdgeGlow: true,
        edgeGlowColor: const Color(0xFF00FF66),
        enablePaymentPulse: true,
      );

  /// Chromatic fluid liquid mesh gradient with vibrant shifting orbs (Revolut Metal & Apple Card style).
  static VerticalCardTheme get revolutChromatic => VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: const CardBackground.fluid(
          colors: [
            Color(0xFF7928CA), // Electric Purple
            Color(0xFF0070F3), // Neon Blue
            Color(0xFFFF0080), // Hot Pink
            Color(0xFF00DFD8), // Turquoise
          ],
        ),
        textColor: Colors.white,
        secondaryTextColor: const Color(0xCCFFFFFF),
        chipColor: ChipColor.silver,
        textFinish: CardTextFinish.silverFoil,
        enablePaymentPulse: true,
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

  /// Elegant golden contour elevation lines over obsidian black.
  static VerticalCardTheme get topographicGold => VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: const CardBackground.painter(TopographicPainter()),
        textColor: const Color(0xFFF7E7B4),
        secondaryTextColor: const Color(0xAAD4AF37),
        chipColor: ChipColor.gold,
      );

  /// Stealth dark twill-weave carbon fiber with metallic accents.
  static VerticalCardTheme get carbonStealth => VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: const CardBackground.painter(CarbonFiberPainter()),
        textColor: Colors.white,
        secondaryTextColor: const Color(0xAAFFFFFF),
        chipColor: ChipColor.silver,
      );

  /// Deep obsidian black with dynamic iridescent rainbow holographic foil sheen.
  static VerticalCardTheme get holoInfinite => VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: const CardBackground.gradient(
          LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF191B26),
              Color(0xFF0C0D14),
              Color(0xFF161824),
            ],
          ),
        ),
        textColor: Colors.white,
        secondaryTextColor: const Color(0xCCFFFFFF),
        chipColor: ChipColor.silver,
        isHolographic: true,
      );

  // ---------------------------------------------------------------------------
  // FAMILIA E: REGIONAL & GLOBAL FINTECHS (CO, MX, BR, AR, ES)
  // ---------------------------------------------------------------------------

  /// Deep plum magenta with vibrant fuchsia neon accents inspired by Nequi (Colombia).
  static VerticalCardTheme get nequi => VerticalCardTheme.flat(
        backgroundColor: const Color(0xFF20002E),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2A003D),
            Color(0xFF190024),
            Color(0xFF3B0054),
          ],
        ),
        textColor: Colors.white,
        secondaryTextColor: const Color(0xFFFF007A),
        chipColor: ChipColor.silver,
      ).copyWith(
        enableEdgeGlow: true,
        edgeGlowColor: const Color(0xFFFF007A),
        enablePaymentPulse: true,
      );

  /// Matte carbon obsidian with gold foil lettering and subtle yellow accents inspired by Bancolombia.
  static VerticalCardTheme get bancolombia => VerticalCardTheme.metallic(
        metalType: MetalType.obsidian,
        textColor: const Color(0xFFFDD835),
        chipColor: ChipColor.gold,
      ).copyWith(
        secondaryTextColor: const Color(0xFFFFF9C4),
        textFinish: CardTextFinish.goldFoil,
        enablePaymentPulse: true,
      );

  /// Vibrant electric fintech blue with clean white typography inspired by Mercado Pago (Mexico & LatAm).
  static VerticalCardTheme get mercadoPago => VerticalCardTheme.flat(
        backgroundColor: const Color(0xFF009EE3),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF00A6EB),
            Color(0xFF007EBE),
          ],
        ),
        textColor: Colors.white,
        secondaryTextColor: const Color(0xCCFFFFFF),
        chipColor: ChipColor.silver,
      ).copyWith(
        enablePaymentPulse: true,
      );

  /// Stealth matte black with signature neon yellow border accents inspired by Hey Banco (Mexico).
  static VerticalCardTheme get heyBanco => VerticalCardTheme.metallic(
        metalType: MetalType.obsidian,
        textColor: const Color(0xFFFFE600),
        chipColor: ChipColor.black,
      ).copyWith(
        secondaryTextColor: const Color(0xCCFFE600),
        textFinish: CardTextFinish.silverFoil,
        enableEdgeGlow: true,
        edgeGlowColor: const Color(0xFFFFE600),
        enablePaymentPulse: true,
      );

  /// Iridescent ultra-deep purple heavy titanium with diamond dust and holographic sheen
  /// inspired by Nubank Ultravioleta (Brazil).
  static VerticalCardTheme get nubankUltravioleta => VerticalCardTheme.metallic(
        metalType: MetalType.brushedTitanium,
        chipColor: ChipColor.silver,
      ).copyWith(
        background: const CardBackground.gradient(
          LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF320B57),
              Color(0xFF1B0330),
              Color(0xFF420D75),
            ],
          ),
        ),
        textColor: const Color(0xFFF3E8FF),
        secondaryTextColor: const Color(0xFFC084FC),
        textFinish: CardTextFinish.silverFoil,
        isHolographic: true,
        enableDiamondDust: true,
        enablePaymentPulse: true,
      );

  /// Vibrant energetic electric orange with crisp white accents inspired by Banco Inter (Brazil).
  static VerticalCardTheme get bancoInter => VerticalCardTheme.flat(
        backgroundColor: const Color(0xFFFF7A00),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFF8B1F),
            Color(0xFFFF5400),
          ],
        ),
        textColor: Colors.white,
        secondaryTextColor: const Color(0xE6FFFFFF),
        chipColor: ChipColor.silver,
      ).copyWith(
        enablePaymentPulse: true,
      );

  /// Web3 neon-lime over deep cyber midnight black with cyber perimeter beam
  /// inspired by Lemon Cash (Argentina).
  static VerticalCardTheme get lemonCash => VerticalCardTheme.flat(
        backgroundColor: const Color(0xFF0D0F14),
        textColor: const Color(0xFF00FF7F),
        secondaryTextColor: const Color(0xFFD4FF00),
        chipColor: ChipColor.black,
      ).copyWith(
        textFinish: CardTextFinish.flat,
        enableEdgeGlow: true,
        edgeGlowColor: const Color(0xFF00FF7F),
        enablePaymentPulse: true,
      );

  /// Modern clean two-tone vivid crimson and white layout inspired by Ualá (Argentina).
  static VerticalCardTheme get uala => VerticalCardTheme.flat(
        backgroundColor: const Color(0xFFE51A2C),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF02436),
            Color(0xFFB80D1D),
          ],
        ),
        textColor: Colors.white,
        secondaryTextColor: const Color(0xDDFFFFFF),
        chipColor: ChipColor.silver,
      ).copyWith(
        enablePaymentPulse: true,
      );

  /// Minimalist transparent frosted glass with acrylic aesthetic inspired by N26 (Europe).
  static VerticalCardTheme get n26 => VerticalCardTheme.glass(
        neonColor: const Color(0xFF00D4B2),
        blur: 16.0,
        chipColor: ChipColor.silver,
      ).copyWith(
        textColor: Colors.white,
        secondaryTextColor: const Color(0xAA00D4B2),
        textFinish: CardTextFinish.silverFoil,
        enablePaymentPulse: true,
      );
}
