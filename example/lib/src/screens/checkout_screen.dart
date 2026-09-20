import 'package:flutter/material.dart';
import 'package:vertical_credit_card/vertical_credit_card.dart';

/// Screen exhibiting the synchronized checkout form with real-time card updates.
///
/// Features:
/// - Real-time input synchronization (number grouping, cardholder name, expiry MM/YY).
/// - Automatic card brand detection (Visa, Mastercard, Amex, Discover).
/// - Intelligent auto-flip to reverse side when the CVV input field receives focus.
///
/// ### Minimal Implementation Guide:
/// ```dart
/// // Step 1: Manage state or use a controller:
/// String cardNumber = '';
/// String cardHolder = '';
/// String expiry = '';
/// String cvv = '';
/// bool isFlipped = false;
///
/// // Step 2: Bind VerticalCard with VerticalCardInputForm:
/// Column(
///   children: [
///     VerticalCard(
///       cardNumber: cardNumber,
///       cardHolder: cardHolder,
///       expiryDate: expiry,
///       cvv: cvv,
///       isFlipped: isFlipped,
///     ),
///     VerticalCardInputForm(
///       onCardNumberChanged: (val) => setState(() => cardNumber = val),
///       onCardHolderChanged: (val) => setState(() => cardHolder = val),
///       onExpiryChanged: (val) => setState(() => expiry = val),
///       onCvvChanged: (val) => setState(() => cvv = val),
///       onCvvFocusChanged: (focused) => setState(() => isFlipped = focused),
///     ),
///   ],
/// )
/// ```
class CheckoutScreen extends StatefulWidget {
  /// Default constructor for the Checkout screen.
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _formCardNumber = '';
  String _formCardHolder = '';
  String _formExpiry = '';
  String _formCvv = '';
  CardBrand _formBrand = CardBrand.generic;
  bool _isCheckoutFlipped = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          // Live synchronized card preview
          Center(
            child: VerticalCard.preset(
              preset: CardPresets.holoInfinite,
              cardNumber: _formCardNumber.isEmpty
                  ? '0000 0000 0000 0000'
                  : _formCardNumber,
              cardHolder:
                  _formCardHolder.isEmpty ? 'YOUR NAME' : _formCardHolder,
              expiryDate: _formExpiry.isEmpty ? 'MM/YY' : _formExpiry,
              cvv: _formCvv.isEmpty ? '•••' : _formCvv,
              brand: _formBrand == CardBrand.generic ? null : _formBrand,
              bankName: 'NEXUS BANK',
              isFlipped: _isCheckoutFlipped,
            ),
          ),

          const SizedBox(height: 20),

          // Instruction badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.cyanAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: Colors.cyanAccent.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.auto_awesome,
                    size: 16, color: Colors.cyanAccent),
                const SizedBox(width: 8),
                Text(
                  'Focus CVV field to watch the 3D auto-flip!',
                  style: TextStyle(
                    color: Colors.cyanAccent.withValues(alpha: 0.9),
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // The interactive form widget
          VerticalCardInputForm(
            onCardNumberChanged: (val) => setState(() => _formCardNumber = val),
            onCardHolderChanged: (val) => setState(() => _formCardHolder = val),
            onExpiryChanged: (val) => setState(() => _formExpiry = val),
            onCvvChanged: (val) => setState(() => _formCvv = val),
            onBrandChanged: (val) => setState(() => _formBrand = val),
            onCvvFocusChanged: (hasFocus) {
              setState(() => _isCheckoutFlipped = hasFocus);
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
