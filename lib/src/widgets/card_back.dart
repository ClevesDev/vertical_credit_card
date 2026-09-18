import 'package:flutter/material.dart';
import '../models/card_theme.dart';

/// The back face layout of the vertical credit card.
class CardBack extends StatelessWidget {
  final String cvv;
  final VerticalCardTheme cardTheme;
  final String? bankName;

  const CardBack({
    super.key,
    required this.cvv,
    required this.cardTheme,
    this.bankName,
  });

  @override
  Widget build(BuildContext context) {
    final secTextColor = cardTheme.secondaryTextColor;

    Widget cardBody = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24.0),

        // Dark magnetic stripe
        Container(
          height: 42.0,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF141416),
                Color(0xFF28282C),
                Color(0xFF18181B),
              ],
            ),
          ),
        ),

        const SizedBox(height: 22.0),

        // Signature strip and CVV box
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AUTHORIZED SIGNATURE • NOT VALID UNLESS SIGNED',
                style: TextStyle(
                  color: secTextColor.withOpacity(0.6),
                  fontSize: 7.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  // White signature panel with security micro-lines
                  Expanded(
                    flex: 7,
                    child: Container(
                      height: 34.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F4F8),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0xFFD0D4DC)),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'John Doe',
                        style: TextStyle(
                          fontFamily: 'cursive',
                          fontSize: 14.0,
                          color: Colors.black.withOpacity(0.55),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  // CVV security code box
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 34.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0xFFB0B5C0)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        cvv.isEmpty ? '•••' : cvv,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: 13.5,
                          letterSpacing: 1.5,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const Spacer(),

        // Hologram seal and customer service disclaimer
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Security disclaimer
              Expanded(
                child: Text(
                  'This card is issued pursuant to license by the financial institution. '
                  'Use of this card is governed by the cardholder agreement.',
                  style: TextStyle(
                    color: secTextColor.withOpacity(0.55),
                    fontSize: 7.5,
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(width: 14.0),
              // Holographic security badge
              Container(
                width: 38.0,
                height: 28.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFE0C3FC),
                      Color(0xFF8EC5FC),
                      Color(0xFFE0C3FC),
                    ],
                  ),
                  border: Border.all(color: Colors.white.withOpacity(0.4)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.security,
                    size: 16.0,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return ClipRRect(
      borderRadius: cardTheme.borderRadius,
      child: cardTheme.background.build(
        context,
        borderRadius: cardTheme.borderRadius,
        child: cardBody,
      ),
    );
  }
}
