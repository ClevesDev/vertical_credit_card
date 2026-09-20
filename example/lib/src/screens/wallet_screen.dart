import 'package:flutter/material.dart';
import 'package:vertical_credit_card/vertical_credit_card.dart';

/// Screen presenting the Apple Wallet style cascading card stack.
///
/// Demonstrates the [VerticalCardStack] widget, which arranges multiple
/// vertical credit cards in a spatial cascading deck with spring physics
/// and focus expansion upon touch.
///
/// ### Minimal Implementation Guide:
/// ```dart
/// // Step 1: Define your list of cards:
/// final myCards = [
///   VerticalCard.preset(
///     preset: CardPresets.nubankUltravioleta,
///     cardNumber: '5502 •••• •••• 9920',
///     cardHolder: 'YOUR NAME',
///     expiryDate: '12/28',
///     cvv: '123',
///     enableFlip: false,
///   ),
///   VerticalCard.preset(
///     preset: CardPresets.nequi,
///     cardNumber: '4512 •••• •••• 4812',
///     cardHolder: 'YOUR NAME',
///     expiryDate: '08/29',
///     cvv: '456',
///     enableFlip: false,
///   ),
/// ];
///
/// // Step 2: Wrap inside a VerticalCardStack:
/// VerticalCardStack(
///   cards: myCards,
///   cardSpacing: 62.0, // Vertical distance between overlapping card headers
///   cardHeight: 380.0,  // Base height constraint for the stack
/// )
/// ```
class WalletScreen extends StatelessWidget {
  /// Default constructor for the Wallet screen.
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final walletCards = [
      VerticalCard.preset(
        preset: CardPresets.holoInfinite,
        cardNumber: '4532 9812 3456 7890',
        cardHolder: 'DIMAS CLEVES',
        expiryDate: '12/28',
        cvv: '942',
        bankName: 'HOLO INFINITE',
        enableFlip: false,
      ),
      VerticalCard.preset(
        preset: CardPresets.painterlyGlobe,
        cardNumber: '5412 8888 1024 4321',
        cardHolder: 'DIMAS CLEVES',
        expiryDate: '08/29',
        cvv: '821',
        bankName: 'CREDIT AGRICOLE',
        enableFlip: false,
      ),
      VerticalCard.preset(
        preset: CardPresets.topographicGold,
        cardNumber: '4000 1234 5678 9010',
        cardHolder: 'DIMAS CLEVES',
        expiryDate: '05/30',
        cvv: '333',
        bankName: 'GOLD ELEVATION',
        enableFlip: false,
      ),
      VerticalCard.preset(
        preset: CardPresets.carbonStealth,
        cardNumber: '3782 822468 005',
        cardHolder: 'DIMAS CLEVES',
        expiryDate: '11/27',
        cvv: '714',
        bankName: 'CARBON STEALTH',
        enableFlip: false,
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.touch_app_rounded,
                  size: 16, color: Colors.cyanAccent),
              const SizedBox(width: 8),
              Text(
                'Tap any card to expand / focus wallet',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Center(
            child: VerticalCardStack(
              cards: walletCards,
              cardSpacing: 62.0,
              cardHeight: 380.0,
            ),
          ),
        ],
      ),
    );
  }
}
