import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/card_brand.dart';
import 'brand_logo.dart';

/// Interactive checkout input form designed specifically to synchronize with a [VerticalCard].
///
/// Features automatic card number grouping (4-4-4-4), expiry date slash formatting (MM/YY),
/// real-time card brand detection, and an **auto-flip callback** triggered whenever the user focuses
/// or unfocuses the CVV field.
class VerticalCardInputForm extends StatefulWidget {
  /// Controller for the card number field.
  final TextEditingController? cardNumberController;

  /// Controller for the cardholder name field.
  final TextEditingController? cardHolderController;

  /// Controller for the expiration date field.
  final TextEditingController? expiryDateController;

  /// Controller for the CVV verification code field.
  final TextEditingController? cvvController;

  /// Callback notified whenever the card number changes.
  final ValueChanged<String>? onCardNumberChanged;

  /// Callback notified whenever the cardholder name changes.
  final ValueChanged<String>? onCardHolderChanged;

  /// Callback notified whenever the expiry date changes.
  final ValueChanged<String>? onExpiryChanged;

  /// Callback notified whenever the CVV changes.
  final ValueChanged<String>? onCvvChanged;

  /// Callback notified when the detected card network brand changes.
  final ValueChanged<CardBrand>? onBrandChanged;

  /// Callback notified whenever the CVV field gains focus (true) or loses focus (false).
  /// Ideal for synchronizing with [VerticalCard.isFlipped].
  final ValueChanged<bool>? onCvvFocusChanged;

  /// Custom decoration theme for the text fields.
  final InputDecoration? inputDecoration;

  /// Primary text style for input text.
  final TextStyle? textStyle;

  /// Label text style.
  final TextStyle? labelStyle;

  /// Spacing between input fields.
  final double fieldSpacing;

  /// Creates a [VerticalCardInputForm].
  const VerticalCardInputForm({
    super.key,
    this.cardNumberController,
    this.cardHolderController,
    this.expiryDateController,
    this.cvvController,
    this.onCardNumberChanged,
    this.onCardHolderChanged,
    this.onExpiryChanged,
    this.onCvvChanged,
    this.onBrandChanged,
    this.onCvvFocusChanged,
    this.inputDecoration,
    this.textStyle,
    this.labelStyle,
    this.fieldSpacing = 16.0,
  });

  @override
  State<VerticalCardInputForm> createState() => _VerticalCardInputFormState();
}

class _VerticalCardInputFormState extends State<VerticalCardInputForm> {
  late final TextEditingController _cardNumberController;
  late final TextEditingController _cardHolderController;
  late final TextEditingController _expiryDateController;
  late final TextEditingController _cvvController;

  final FocusNode _cvvFocusNode = FocusNode();
  CardBrand _detectedBrand = CardBrand.generic;

  @override
  void initState() {
    super.initState();
    _cardNumberController =
        widget.cardNumberController ?? TextEditingController();
    _cardHolderController =
        widget.cardHolderController ?? TextEditingController();
    _expiryDateController =
        widget.expiryDateController ?? TextEditingController();
    _cvvController = widget.cvvController ?? TextEditingController();

    _cvvFocusNode.addListener(_handleCvvFocus);
  }

  void _handleCvvFocus() {
    widget.onCvvFocusChanged?.call(_cvvFocusNode.hasFocus);
  }

  @override
  void dispose() {
    _cvvFocusNode.removeListener(_handleCvvFocus);
    _cvvFocusNode.dispose();
    if (widget.cardNumberController == null) _cardNumberController.dispose();
    if (widget.cardHolderController == null) _cardHolderController.dispose();
    if (widget.expiryDateController == null) _expiryDateController.dispose();
    if (widget.cvvController == null) _cvvController.dispose();
    super.dispose();
  }

  InputDecoration _buildDecoration({
    required String labelText,
    required String hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    if (widget.inputDecoration != null) {
      return widget.inputDecoration!.copyWith(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      );
    }

    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelStyle: widget.labelStyle ??
          TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13),
      hintStyle:
          TextStyle(color: Colors.white.withValues(alpha: 0.25), fontSize: 13),
      filled: true,
      fillColor: const Color(0xFF141722),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.cyanAccent, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.textStyle ??
        const TextStyle(
          color: Colors.white,
          fontSize: 14.5,
          fontWeight: FontWeight.w600,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Card Number Field
        TextFormField(
          controller: _cardNumberController,
          keyboardType: TextInputType.number,
          style: style,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
            CardNumberInputFormatter(),
          ],
          decoration: _buildDecoration(
            labelText: 'Card Number',
            hintText: '0000 0000 0000 0000',
            prefixIcon: const Icon(Icons.credit_card_rounded,
                size: 20, color: Colors.cyanAccent),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BrandLogo(brand: _detectedBrand, height: 22),
            ),
          ),
          onChanged: (val) {
            final brand = CardBrand.detect(val);
            if (brand != _detectedBrand) {
              setState(() => _detectedBrand = brand);
              widget.onBrandChanged?.call(brand);
            }
            widget.onCardNumberChanged?.call(val);
          },
        ),

        SizedBox(height: widget.fieldSpacing),

        // 2. Cardholder Name Field
        TextFormField(
          controller: _cardHolderController,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.characters,
          style: style,
          inputFormatters: [
            LengthLimitingTextInputFormatter(26),
          ],
          decoration: _buildDecoration(
            labelText: 'Cardholder Name',
            hintText: 'ELENA ROJAS',
            prefixIcon: const Icon(Icons.person_outline_rounded,
                size: 20, color: Colors.white54),
          ),
          onChanged: (val) => widget.onCardHolderChanged?.call(val),
        ),

        SizedBox(height: widget.fieldSpacing),

        // 3. Row for Expiry Date & CVV
        Row(
          children: [
            // Expiration Date
            Expanded(
              child: TextFormField(
                controller: _expiryDateController,
                keyboardType: TextInputType.number,
                style: style,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                  CardExpiryInputFormatter(),
                ],
                decoration: _buildDecoration(
                  labelText: 'Expires',
                  hintText: 'MM/YY',
                  prefixIcon: const Icon(Icons.calendar_today_outlined,
                      size: 18, color: Colors.white54),
                ),
                onChanged: (val) => widget.onExpiryChanged?.call(val),
              ),
            ),

            const SizedBox(width: 14),

            // CVV / CVC
            Expanded(
              child: TextFormField(
                controller: _cvvController,
                focusNode: _cvvFocusNode,
                keyboardType: TextInputType.number,
                obscureText: true,
                style: style,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                decoration: _buildDecoration(
                  labelText: 'CVV / CVC',
                  hintText: '•••',
                  prefixIcon: const Icon(Icons.lock_outline_rounded,
                      size: 18, color: Colors.amberAccent),
                ),
                onChanged: (val) => widget.onCvvChanged?.call(val),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Custom [TextInputFormatter] that automatically formats digits into 4-character chunks.
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    if (text.isEmpty) return newValue;

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      final nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Custom [TextInputFormatter] that automatically inserts a slash after the 2-digit month (MM/YY).
class CardExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text.replaceAll('/', '');
    if (newText.isEmpty) return newValue;

    final buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      if (i == 1 && newText.length > 2) {
        buffer.write('/');
      }
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
