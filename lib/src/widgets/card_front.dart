import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/card_brand.dart';
import '../models/card_theme.dart';
import '../painters/metallic_painter.dart';
import 'brand_logo.dart';
import 'contactless.dart';
import 'emv_chip.dart';

/// The front face layout of the vertical credit card.
class CardFront extends StatelessWidget {
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final String? bankName;
  final CardBrand brand;
  final VerticalCardTheme cardTheme;
  final bool isFrozen;

  const CardFront({
    super.key,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.brand,
    required this.cardTheme,
    this.bankName,
    this.isFrozen = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = cardTheme.textColor;
    final secTextColor = cardTheme.secondaryTextColor;

    Widget cardBody = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Bank name + Contactless indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (bankName != null && bankName!.isNotEmpty)
                Text(
                  bankName!.toUpperCase(),
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 16.0,
                    letterSpacing: 2.0,
                  ),
                )
              else
                const SizedBox.shrink(),
              ContactlessIcon(
                size: 22.0,
                color: textColor.withOpacity(0.75),
              ),
            ],
          ),

          const SizedBox(height: 24.0),

          // EMV Smart Chip
          Row(
            children: [
              EmvChip(
                isSilver: cardTheme.metalType == MetalType.silver ||
                    cardTheme.metalType == MetalType.brushedTitanium,
              ),
              const SizedBox(width: 8.0),
              // Arrow indicator pointing upwards into the chip slot
              Icon(
                Icons.arrow_upward_rounded,
                size: 16,
                color: textColor.withOpacity(0.35),
              ),
            ],
          ),

          const Spacer(),

          // Card Number formatted with modern spacing
          Text(
            _formatCardNumber(cardNumber),
            style: TextStyle(
              color: textColor,
              fontSize: 17.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.4,
              fontFeatures: const [FontFeature.tabularFigures()],
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),

          const SizedBox(height: 18.0),

          // Expiry date and Cardholder details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Expiry Date
                    Row(
                      children: [
                        Text(
                          'VAL THRU',
                          style: TextStyle(
                            color: secTextColor,
                            fontSize: 8.5,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          expiryDate.isEmpty ? 'MM/YY' : expiryDate,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    // Cardholder Name
                    Text(
                      cardHolder.isEmpty ? 'CARDHOLDER NAME' : cardHolder.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              // Brand Logo (Visa, Mastercard, etc.)
              BrandLogo(brand: brand, height: 28.0),
            ],
          ),
        ],
      ),
    );

    // Apply specific theme background decorating
    return ClipRRect(
      borderRadius: cardTheme.borderRadius,
      child: _buildThemedBackground(child: cardBody),
    );
  }

  Widget _buildThemedBackground({required Widget child}) {
    switch (cardTheme.type) {
      case VerticalCardThemeType.glass:
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: cardTheme.blur,
            sigmaY: cardTheme.blur,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: cardTheme.backgroundColor,
              borderRadius: cardTheme.borderRadius,
              border: Border.all(
                color: (cardTheme.neonColor ?? Colors.cyanAccent).withOpacity(0.65),
                width: 1.5,
              ),
            ),
            child: child,
          ),
        );

      case VerticalCardThemeType.metallic:
        return CustomPaint(
          painter: MetallicCardPainter(
            metalType: cardTheme.metalType ?? MetalType.brushedTitanium,
          ),
          child: child,
        );

      case VerticalCardThemeType.flat:
        return Container(
          decoration: BoxDecoration(
            color: cardTheme.backgroundColor,
            gradient: cardTheme.gradient,
            borderRadius: cardTheme.borderRadius,
          ),
          child: child,
        );
    }
  }

  String _formatCardNumber(String number) {
    final clean = number.replaceAll(' ', '');
    if (clean.isEmpty) return '••••  ••••  ••••  ••••';

    final buffer = StringBuffer();
    for (int i = 0; i < clean.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write('  ');
      }
      buffer.write(clean[i]);
    }
    return buffer.toString();
  }
}
