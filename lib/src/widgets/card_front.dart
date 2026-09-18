import 'package:flutter/material.dart';
import '../models/card_brand.dart';
import '../models/card_theme.dart';
import 'brand_logo.dart';
import 'contactless.dart';
import 'emv_chip.dart';

/// The front face layout of the vertical credit card with slot injection and privacy support.
class CardFront extends StatelessWidget {
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final String? bankName;
  final CardBrand brand;
  final VerticalCardTheme cardTheme;
  final bool isFrozen;
  final bool isPrivacyMode;
  final VoidCallback? onPrivacyToggle;
  final Widget? bankLogo;
  final Widget? chipWidget;
  final Widget? actionBadge;

  const CardFront({
    super.key,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.brand,
    required this.cardTheme,
    this.bankName,
    this.isFrozen = false,
    this.isPrivacyMode = false,
    this.onPrivacyToggle,
    this.bankLogo,
    this.chipWidget,
    this.actionBadge,
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
          // Top Row: Bank Name / Logo + Contactless & Action Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left Slot: Bank Logo or Bank Name
              if (bankLogo != null)
                bankLogo!
              else if (bankName != null && bankName!.isNotEmpty)
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

              // Right Slot: Action Badge + Contactless Indicator
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (actionBadge != null) ...[
                    actionBadge!,
                    const SizedBox(width: 8.0),
                  ],
                  ContactlessIcon(
                    size: 22.0,
                    color: textColor.withOpacity(0.75),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24.0),

          // Chip Slot: Custom chip or default EmvChip
          Row(
            children: [
              chipWidget ?? EmvChip(chipColor: cardTheme.chipColor),
              const SizedBox(width: 8.0),
              Icon(
                Icons.arrow_upward_rounded,
                size: 16,
                color: textColor.withOpacity(0.35),
              ),
            ],
          ),

          const Spacer(),

          // Card Number with Privacy Mode support
          GestureDetector(
            onTap: onPrivacyToggle,
            behavior: HitTestBehavior.opaque,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: FittedBox(
                key: ValueKey<bool>(isPrivacyMode),
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isPrivacyMode
                          ? _formatMaskedCardNumber(cardNumber)
                          : _formatCardNumber(cardNumber),
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: isPrivacyMode ? 1.6 : 2.0,
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
                    const SizedBox(width: 8.0),
                    Icon(
                      isPrivacyMode ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      size: 15.0,
                      color: textColor.withOpacity(0.35),
                    ),
                  ],
                ),
              ),
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
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
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
                            isPrivacyMode ? '••/••' : (expiryDate.isEmpty ? 'MM/YY' : expiryDate),
                            style: TextStyle(
                              color: textColor,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
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

    // Delegate background rendering to CardBackground strategy
    return ClipRRect(
      borderRadius: cardTheme.borderRadius,
      child: cardTheme.background.build(
        context,
        borderRadius: cardTheme.borderRadius,
        child: cardBody,
      ),
    );
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

  String _formatMaskedCardNumber(String number) {
    final clean = number.replaceAll(' ', '');
    if (clean.length <= 4) return '••••  ••••  ••••  $clean';
    final lastFour = clean.substring(clean.length - 4);
    return '••••  ••••  ••••  $lastFour';
  }
}
