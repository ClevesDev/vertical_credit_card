import 'package:flutter/material.dart';

/// The visual style type of the vertical card.
enum VerticalCardThemeType {
  flat,
  metallic,
  glass,
}

/// The metallic material finish.
enum MetalType {
  brushedTitanium,
  gold,
  silver,
  obsidian,
  roseGold,
}

/// Configuration class defining the aesthetics of a [VerticalCard].
class VerticalCardTheme {
  final VerticalCardThemeType type;
  final Color backgroundColor;
  final Gradient? gradient;
  final Color textColor;
  final Color secondaryTextColor;
  final Color? neonColor;
  final double blur;
  final MetalType? metalType;
  final BorderRadius borderRadius;
  final List<BoxShadow>? shadows;

  const VerticalCardTheme._({
    required this.type,
    required this.backgroundColor,
    this.gradient,
    this.textColor = Colors.white,
    this.secondaryTextColor = const Color(0xAAFFFFFF),
    this.neonColor,
    this.blur = 12.0,
    this.metalType,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.shadows,
  });

  /// Factory for clean, flat or gradient modern neo-bank cards.
  factory VerticalCardTheme.flat({
    Color backgroundColor = const Color(0xFF1E1E2C),
    Gradient? gradient,
    Color textColor = Colors.white,
    Color secondaryTextColor = const Color(0xAAFFFFFF),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(16)),
    List<BoxShadow>? shadows,
  }) {
    return VerticalCardTheme._(
      type: VerticalCardThemeType.flat,
      backgroundColor: backgroundColor,
      gradient: gradient,
      textColor: textColor,
      secondaryTextColor: secondaryTextColor,
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
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(16)),
    List<BoxShadow>? shadows,
  }) {
    Color txtColor;
    Color secColor;

    switch (metalType) {
      case MetalType.gold:
      case MetalType.silver:
      case MetalType.roseGold:
        txtColor = textColor ?? const Color(0xFF222222);
        secColor = const Color(0x99222222);
        break;
      case MetalType.brushedTitanium:
      case MetalType.obsidian:
        txtColor = textColor ?? Colors.white;
        secColor = const Color(0xAAFFFFFF);
        break;
    }

    return VerticalCardTheme._(
      type: VerticalCardThemeType.metallic,
      backgroundColor: Colors.transparent,
      metalType: metalType,
      textColor: txtColor,
      secondaryTextColor: secColor,
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
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(16)),
  }) {
    return VerticalCardTheme._(
      type: VerticalCardThemeType.glass,
      backgroundColor: Colors.white.withOpacity(0.08),
      neonColor: neonColor,
      blur: blur,
      textColor: textColor,
      secondaryTextColor: secondaryTextColor,
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
}
