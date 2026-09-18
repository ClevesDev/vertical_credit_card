import 'package:flutter/material.dart';
import '../models/card_brand.dart';

/// Renders a native, crisp vector representation of the credit card brand logo.
class BrandLogo extends StatelessWidget {
  final CardBrand brand;
  final double height;

  const BrandLogo({
    super.key,
    required this.brand,
    this.height = 28.0,
  });

  @override
  Widget build(BuildContext context) {
    switch (brand) {
      case CardBrand.visa:
        return _buildVisaLogo();
      case CardBrand.mastercard:
        return _buildMastercardLogo();
      case CardBrand.americanExpress:
        return _buildAmexLogo();
      case CardBrand.discover:
        return _buildDiscoverLogo();
      default:
        return _buildGenericLogo();
    }
  }

  Widget _buildVisaLogo() {
    return SizedBox(
      height: height,
      child: Center(
        child: Text(
          'VISA',
          style: TextStyle(
            fontSize: height * 0.85,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            letterSpacing: 1.5,
            color: Colors.white,
            shadows: const [
              Shadow(
                color: Color(0x66000000),
                offset: Offset(1, 1),
                blurRadius: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMastercardLogo() {
    final circleDiameter = height * 0.95;
    return SizedBox(
      height: height,
      width: circleDiameter * 1.6,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: circleDiameter,
              height: circleDiameter,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEB001B), // Mastercard Red
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: circleDiameter,
              height: circleDiameter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF79E1B)
                    .withOpacity(0.92), // Mastercard Yellow
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmexLogo() {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF007BC1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Center(
        child: Text(
          'AMEX',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 11,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildDiscoverLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'DISC',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: height * 0.55,
          ),
        ),
        Container(
          width: height * 0.45,
          height: height * 0.45,
          margin: const EdgeInsets.symmetric(horizontal: 1.5),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFFF6000),
          ),
        ),
        Text(
          'VER',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: height * 0.55,
          ),
        ),
      ],
    );
  }

  Widget _buildGenericLogo() {
    return Container(
      height: height,
      width: height * 1.4,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Icon(
        Icons.credit_card,
        size: height * 0.65,
        color: Colors.white.withOpacity(0.8),
      ),
    );
  }
}
