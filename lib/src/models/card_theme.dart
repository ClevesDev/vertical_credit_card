import 'package:flutter/material.dart';
import '../backgrounds/card_background.dart';

/// The visual style classification of the vertical card.
enum VerticalCardThemeType {
  flat,
  metallic,
  glass,
  artistic,
}

/// The metallic material finish.
enum MetalType {
  brushedTitanium,
  gold,
  silver,
  obsidian,
  roseGold,
}

/// The EMV chip color finish.
enum ChipColor {
  gold,
  silver,
  black,
}

/// Configuration class defining the full aesthetic theme of a [VerticalCard].
class VerticalCardTheme {
  final VerticalCardThemeType type;
  final CardBackground background;
  final Color textColor;
  final Color secondaryTextColor;
  final ChipColor chipColor;
  final BorderRadius borderRadius;
  final List<BoxShadow>? shadows;

  // Preserved properties for backward compatibility and specialized inspectors
  final Color? neonColor;
  final double blur;
  final MetalType? metalType;

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
  });

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
