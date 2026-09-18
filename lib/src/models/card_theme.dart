import 'package:flutter/material.dart';
import '../backgrounds/card_background.dart';

/// The visual style classification of the vertical card.
enum VerticalCardThemeType {
  /// Clean solid color or gradient neo-bank style.
  flat,

  /// Brushed metallic premium finish.
  metallic,

  /// Translucent frosted glassmorphism with neon accents.
  glass,

  /// Custom vector painted artistic textures.
  artistic,
}

/// The metallic material finish.
enum MetalType {
  /// Minimalist Apple Card style brushed titanium.
  brushedTitanium,

  /// Rich reflective gold finish.
  gold,

  /// Cool brushed silver platinum finish.
  silver,

  /// Deep obsidian black finish (Amex Centurion style).
  obsidian,

  /// Warm metallic rose gold finish.
  roseGold,
}

/// The tactile and material surface finish applied to card typography.
enum CardTextFinish {
  /// Standard flat printed ink.
  flat,

  /// Reflective metallic hot gold foil stamping with directional highlights.
  goldFoil,

  /// Reflective metallic chrome silver foil stamping with directional highlights.
  silverFoil,

  /// Warm metallic rose gold foil stamping.
  roseGoldFoil,

  /// Classic physical letterpress embossed relief with bevel highlights and shadows.
  embossed,
}

/// The EMV chip color finish.
enum ChipColor {
  /// Traditional gold contact pads.
  gold,

  /// Modern silver platinum contact pads.
  silver,

  /// Stealth matte black contact pads.
  black,
}

/// Configuration class defining the full aesthetic theme of a [VerticalCard].
class VerticalCardTheme {
  /// The high-level classification type of this theme.
  final VerticalCardThemeType type;

  /// The underlying background rendering strategy.
  final CardBackground background;

  /// Color used for primary card text (card number, cardholder name).
  final Color textColor;

  /// Color used for secondary labels (VAL THRU, bank name).
  final Color secondaryTextColor;

  /// Color palette applied to the vector EMV chip.
  final ChipColor chipColor;

  /// Corner border radius for the card container.
  final BorderRadius borderRadius;

  /// Drop shadows cast by the card container.
  final List<BoxShadow>? shadows;

  // Preserved properties for backward compatibility and specialized inspectors

  /// Glowing neon accent color for glassmorphism themes.
  final Color? neonColor;

  /// Backdrop filter blur sigma for glassmorphism themes.
  final double blur;

  /// Specific metal finish type when [type] is [VerticalCardThemeType.metallic].
  final MetalType? metalType;

  /// Whether an iridescent rainbow holographic foil sheen is applied.
  final bool isHolographic;

  /// The tactile and material surface finish applied to card typography.
  final CardTextFinish textFinish;

  /// Whether an animated neon perimeter beam traces the rounded edge of the card.
  final bool enableEdgeGlow;

  /// Accent color for the perimeter edge glow beam.
  final Color? edgeGlowColor;

  /// Whether subtle diamond dust / micro-glitter sparkles twinkle on the card surface.
  final bool enableDiamondDust;

  /// Whether tapping the card triggers an expanding contactless sonar payment pulse.
  final bool enablePaymentPulse;

  /// Whether the animated perimeter edge glow smoothly cycles through the full 360-degree RGB chroma spectrum.
  final bool isRgbChroma;

  const VerticalCardTheme({
    this.type = VerticalCardThemeType.flat,
    required this.background,
    this.textColor = Colors.white,
    this.secondaryTextColor = const Color(0xAAFFFFFF),
    this.chipColor = ChipColor.gold,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.shadows,
    this.neonColor,
    this.blur = 12.0,
    this.metalType,
    this.isHolographic = false,
    this.textFinish = CardTextFinish.flat,
    this.enableEdgeGlow = false,
    this.edgeGlowColor,
    this.enableDiamondDust = false,
    this.enablePaymentPulse = false,
    this.isRgbChroma = false,
  });

  /// Creates a copy of this theme with the given fields replaced with new values.
  VerticalCardTheme copyWith({
    VerticalCardThemeType? type,
    CardBackground? background,
    Color? textColor,
    Color? secondaryTextColor,
    ChipColor? chipColor,
    BorderRadius? borderRadius,
    List<BoxShadow>? shadows,
    Color? neonColor,
    double? blur,
    MetalType? metalType,
    bool? isHolographic,
    CardTextFinish? textFinish,
    bool? enableEdgeGlow,
    Color? edgeGlowColor,
    bool? enableDiamondDust,
    bool? enablePaymentPulse,
    bool? isRgbChroma,
  }) {
    return VerticalCardTheme(
      type: type ?? this.type,
      background: background ?? this.background,
      textColor: textColor ?? this.textColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      chipColor: chipColor ?? this.chipColor,
      borderRadius: borderRadius ?? this.borderRadius,
      shadows: shadows ?? this.shadows,
      neonColor: neonColor ?? this.neonColor,
      blur: blur ?? this.blur,
      metalType: metalType ?? this.metalType,
      isHolographic: isHolographic ?? this.isHolographic,
      textFinish: textFinish ?? this.textFinish,
      enableEdgeGlow: enableEdgeGlow ?? this.enableEdgeGlow,
      edgeGlowColor: edgeGlowColor ?? this.edgeGlowColor,
      enableDiamondDust: enableDiamondDust ?? this.enableDiamondDust,
      enablePaymentPulse: enablePaymentPulse ?? this.enablePaymentPulse,
      isRgbChroma: isRgbChroma ?? this.isRgbChroma,
    );
  }

  /// Factory for clean, flat or gradient modern neo-bank cards (Nubank, BBVA, Wise style).
  factory VerticalCardTheme.flat({
    Color backgroundColor = const Color(0xFF1E1E2C),
    Gradient? gradient,
    Color textColor = Colors.white,
    Color secondaryTextColor = const Color(0xAAFFFFFF),
    ChipColor chipColor = ChipColor.gold,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(16)),
    List<BoxShadow>? shadows,
  }) {
    return VerticalCardTheme(
      type: VerticalCardThemeType.flat,
      background: gradient != null
          ? CardBackground.gradient(gradient)
          : CardBackground.solid(backgroundColor),
      textColor: textColor,
      secondaryTextColor: secondaryTextColor,
      chipColor: chipColor,
      borderRadius: borderRadius,
      shadows: shadows ??
          [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
    );
  }

  /// Factory for luxury metallic finish cards (Apple Card, Amex Centurion style).
  factory VerticalCardTheme.metallic({
    MetalType metalType = MetalType.brushedTitanium,
    Color? textColor,
    ChipColor? chipColor,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(16)),
    List<BoxShadow>? shadows,
  }) {
    Color txtColor;
    Color secColor;
    ChipColor finalChip;

    switch (metalType) {
      case MetalType.gold:
        txtColor = textColor ?? const Color(0xFF222222);
        secColor = const Color(0x99222222);
        finalChip = chipColor ?? ChipColor.gold;
        break;
      case MetalType.silver:
      case MetalType.roseGold:
        txtColor = textColor ?? const Color(0xFF222222);
        secColor = const Color(0x99222222);
        finalChip = chipColor ?? ChipColor.silver;
        break;
      case MetalType.brushedTitanium:
        txtColor = textColor ?? Colors.white;
        secColor = const Color(0xAAFFFFFF);
        finalChip = chipColor ?? ChipColor.silver;
        break;
      case MetalType.obsidian:
        txtColor = textColor ?? Colors.white;
        secColor = const Color(0xAAFFFFFF);
        finalChip = chipColor ?? ChipColor.black;
        break;
    }

    return VerticalCardTheme(
      type: VerticalCardThemeType.metallic,
      background: CardBackground.metallic(metalType),
      metalType: metalType,
      textColor: txtColor,
      secondaryTextColor: secColor,
      chipColor: finalChip,
      borderRadius: borderRadius,
      shadows: shadows ??
          [
            BoxShadow(
              color: Colors.black.withOpacity(0.45),
              blurRadius: 22,
              offset: const Offset(0, 12),
            ),
          ],
    );
  }

  /// Factory for futuristic glassmorphic/cyber cards with neon edges.
  factory VerticalCardTheme.glass({
    Color neonColor = const Color(0xFF00F0FF),
    double blur = 14.0,
    Color textColor = Colors.white,
    Color secondaryTextColor = const Color(0xCCFFFFFF),
    ChipColor chipColor = ChipColor.silver,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(16)),
  }) {
    return VerticalCardTheme(
      type: VerticalCardThemeType.glass,
      background: CardBackground.glass(
        neonColor: neonColor,
        blur: blur,
        backgroundColor: Colors.white.withOpacity(0.08),
      ),
      neonColor: neonColor,
      blur: blur,
      textColor: textColor,
      secondaryTextColor: secondaryTextColor,
      chipColor: chipColor,
      borderRadius: borderRadius,
      shadows: [
        BoxShadow(
          color: neonColor.withOpacity(0.25),
          blurRadius: 20,
          spreadRadius: -2,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          blurRadius: 25,
          offset: const Offset(0, 15),
        ),
      ],
    );
  }

  /// Factory for artistic custom painter cards (Family D).
  factory VerticalCardTheme.artistic({
    required CustomPainter painter,
    Color textColor = Colors.white,
    Color secondaryTextColor = const Color(0xAAFFFFFF),
    ChipColor chipColor = ChipColor.gold,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(16)),
    List<BoxShadow>? shadows,
  }) {
    return VerticalCardTheme(
      type: VerticalCardThemeType.artistic,
      background: CardBackground.painter(painter),
      textColor: textColor,
      secondaryTextColor: secondaryTextColor,
      chipColor: chipColor,
      borderRadius: borderRadius,
      shadows: shadows ??
          [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
    );
  }
}
