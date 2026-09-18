import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/card_brand.dart';
import '../models/card_theme.dart';
import '../painters/frost_painter.dart';
import 'card_back.dart';
import 'card_front.dart';

/// A modern, customizable vertical credit/debit card widget with 3D flip animation,
/// luxury metallic textures, glassmorphism, and frozen card states.
class VerticalCard extends StatefulWidget {
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final String cvv;
  final String? bankName;
  final CardBrand? brand;
  final VerticalCardTheme cardTheme;
  final bool isFrozen;
  final bool enableFlip;
  final double width;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onFlipChange;

  /// Default constructor accepting a fully customizable [VerticalCardTheme].
  const VerticalCard({
    super.key,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.cvv,
    required this.cardTheme,
    this.bankName,
    this.brand,
    this.isFrozen = false,
    this.enableFlip = true,
    this.width = 240.0,
    this.onTap,
    this.onFlipChange,
  });

  /// Convenient factory for clean, flat or gradient modern neo-bank cards (Nubank/BBVA style).
  factory VerticalCard.flat({
    Key? key,
    required String cardNumber,
    required String cardHolder,
    required String expiryDate,
    required String cvv,
    String? bankName,
    CardBrand? brand,
    Color backgroundColor = const Color(0xFF1E1E2C),
    Gradient? gradient,
    Color textColor = Colors.white,
    bool isFrozen = false,
    bool enableFlip = true,
    double width = 240.0,
    VoidCallback? onTap,
    ValueChanged<bool>? onFlipChange,
  }) {
    return VerticalCard(
      key: key,
      cardNumber: cardNumber,
      cardHolder: cardHolder,
      expiryDate: expiryDate,
      cvv: cvv,
      bankName: bankName,
      brand: brand,
      cardTheme: VerticalCardTheme.flat(
        backgroundColor: backgroundColor,
        gradient: gradient,
        textColor: textColor,
      ),
      isFrozen: isFrozen,
      enableFlip: enableFlip,
      width: width,
      onTap: onTap,
      onFlipChange: onFlipChange,
    );
  }

  /// Convenient factory for luxury metallic finish cards (Apple Card / Amex style).
  factory VerticalCard.metallic({
    Key? key,
    required String cardNumber,
    required String cardHolder,
    required String expiryDate,
    required String cvv,
    String? bankName,
    CardBrand? brand,
    MetalType metalType = MetalType.brushedTitanium,
    Color? textColor,
    bool isFrozen = false,
    bool enableFlip = true,
    double width = 240.0,
    VoidCallback? onTap,
    ValueChanged<bool>? onFlipChange,
  }) {
    return VerticalCard(
      key: key,
      cardNumber: cardNumber,
      cardHolder: cardHolder,
      expiryDate: expiryDate,
      cvv: cvv,
      bankName: bankName,
      brand: brand,
      cardTheme: VerticalCardTheme.metallic(
        metalType: metalType,
        textColor: textColor,
      ),
      isFrozen: isFrozen,
      enableFlip: enableFlip,
      width: width,
      onTap: onTap,
      onFlipChange: onFlipChange,
    );
  }

  /// Convenient factory for futuristic glassmorphic/cyber cards with neon glowing edges.
  factory VerticalCard.glass({
    Key? key,
    required String cardNumber,
    required String cardHolder,
    required String expiryDate,
    required String cvv,
    String? bankName,
    CardBrand? brand,
    Color neonColor = const Color(0xFF00F0FF),
    double blur = 14.0,
    Color textColor = Colors.white,
    bool isFrozen = false,
    bool enableFlip = true,
    double width = 240.0,
    VoidCallback? onTap,
    ValueChanged<bool>? onFlipChange,
  }) {
    return VerticalCard(
      key: key,
      cardNumber: cardNumber,
      cardHolder: cardHolder,
      expiryDate: expiryDate,
      cvv: cvv,
      bankName: bankName,
      brand: brand,
      cardTheme: VerticalCardTheme.glass(
        neonColor: neonColor,
        blur: blur,
        textColor: textColor,
      ),
      isFrozen: isFrozen,
      enableFlip: enableFlip,
      width: width,
      onTap: onTap,
      onFlipChange: onFlipChange,
    );
  }

  @override
  State<VerticalCard> createState() => _VerticalCardState();
}

class _VerticalCardState extends State<VerticalCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  bool _showBack = false;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );

    _flipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOutCubic),
    )..addListener(() {
        final shouldShowBack = _flipAnimation.value >= 0.5;
        if (shouldShowBack != _showBack) {
          setState(() {
            _showBack = shouldShowBack;
          });
        }
      });
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _handleTap() {
    widget.onTap?.call();

    if (widget.enableFlip) {
      if (_flipController.isCompleted) {
        _flipController.reverse();
        widget.onFlipChange?.call(false);
      } else if (_flipController.isDismissed) {
        _flipController.forward();
        widget.onFlipChange?.call(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Standard ISO/IEC 7810 ID-1 card aspect ratio (85.60 mm / 53.98 mm ≈ 1.586)
    final height = widget.width * 1.586;
    final detectedBrand = widget.brand ?? CardBrand.detect(widget.cardNumber);

    return Center(
      child: GestureDetector(
        onTap: _handleTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedBuilder(
          animation: _flipAnimation,
          builder: (context, child) {
            // Angle goes from 0 to pi (180 degrees)
            final angle = _flipAnimation.value * math.pi;

            // 3D perspective transformation matrix
            final transform = Matrix4.identity()
              ..setEntry(3, 2, 0.0012)
              ..rotateY(angle);

            return Transform(
              transform: transform,
              alignment: Alignment.center,
              child: Container(
                width: widget.width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: widget.cardTheme.borderRadius,
                  boxShadow: widget.cardTheme.shadows,
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Face Widget (Front or Back)
                    if (!_showBack)
                      CardFront(
                        cardNumber: widget.cardNumber,
                        cardHolder: widget.cardHolder,
                        expiryDate: widget.expiryDate,
                        bankName: widget.bankName,
                        brand: detectedBrand,
                        cardTheme: widget.cardTheme,
                        isFrozen: widget.isFrozen,
                      )
                    else
                      Transform(
                        transform: Matrix4.rotationY(math.pi),
                        alignment: Alignment.center,
                        child: CardBack(
                          cvv: widget.cvv,
                          cardTheme: widget.cardTheme,
                          bankName: widget.bankName,
                        ),
                      ),

                    // Frozen Overlay Layer
                    if (widget.isFrozen)
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: widget.cardTheme.borderRadius,
                          child: Stack(
                            children: [
                              CustomPaint(
                                size: Size(widget.width, height),
                                painter: FrostOverlayPainter(),
                              ),
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0x990A192F),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.cyanAccent.withOpacity(0.8),
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.cyanAccent.withOpacity(0.35),
                                        blurRadius: 15,
                                      ),
                                    ],
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.lock_outline_rounded,
                                        color: Colors.cyanAccent,
                                        size: 16,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'FROZEN',
                                        style: TextStyle(
                                          color: Colors.cyanAccent,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 11,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
