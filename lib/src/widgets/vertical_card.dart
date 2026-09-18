import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/card_brand.dart';
import '../models/card_theme.dart';
import '../painters/frost_painter.dart';
import '../painters/specular_glare_painter.dart';
import '../presets/card_presets.dart';
import 'card_back.dart';
import 'card_front.dart';

/// A modern, customizable vertical credit/debit card widget with 3D flip animation,
/// interactive 3D tilt with specular glare, privacy mode, and multiple fintech states.
class VerticalCard extends StatefulWidget {
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final String cvv;
  final String? bankName;
  final CardBrand? brand;
  final VerticalCardTheme cardTheme;
  final bool isFrozen;
  final bool isExpired;
  final bool isPrivacyMode;
  final bool enablePrivacyToggle;
  final bool enableFlip;
  final bool enable3DTilt;
  final bool enableSpecularGlare;
  final double maxTiltAngle;
  final double width;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onFlipChange;
  final ValueChanged<bool>? onPrivacyChange;

  // Customization Slots (Open-Closed Principle)
  final Widget? bankLogo;
  final Widget? chipWidget;
  final Widget? actionBadge;

  /// Default constructor accepting a custom or preset [VerticalCardTheme].
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
    this.isExpired = false,
    this.isPrivacyMode = false,
    this.enablePrivacyToggle = true,
    this.enableFlip = true,
    this.enable3DTilt = true,
    this.enableSpecularGlare = true,
    this.maxTiltAngle = 0.24, // ~14 degrees
    this.width = 240.0,
    this.onTap,
    this.onFlipChange,
    this.onPrivacyChange,
    this.bankLogo,
    this.chipWidget,
    this.actionBadge,
  });

  /// Convenient factory to instantiate a card directly using a preset from [CardPresets].
  factory VerticalCard.preset({
    Key? key,
    required String cardNumber,
    required String cardHolder,
    required String expiryDate,
    required String cvv,
    required VerticalCardTheme preset,
    String? bankName,
    CardBrand? brand,
    bool isFrozen = false,
    bool isExpired = false,
    bool isPrivacyMode = false,
    bool enablePrivacyToggle = true,
    bool enableFlip = true,
    bool enable3DTilt = true,
    bool enableSpecularGlare = true,
    double width = 240.0,
    VoidCallback? onTap,
    ValueChanged<bool>? onFlipChange,
    ValueChanged<bool>? onPrivacyChange,
    Widget? bankLogo,
    Widget? chipWidget,
    Widget? actionBadge,
  }) {
    return VerticalCard(
      key: key,
      cardNumber: cardNumber,
      cardHolder: cardHolder,
      expiryDate: expiryDate,
      cvv: cvv,
      bankName: bankName,
      brand: brand,
      cardTheme: preset,
      isFrozen: isFrozen,
      isExpired: isExpired,
      isPrivacyMode: isPrivacyMode,
      enablePrivacyToggle: enablePrivacyToggle,
      enableFlip: enableFlip,
      enable3DTilt: enable3DTilt,
      enableSpecularGlare: enableSpecularGlare,
      width: width,
      onTap: onTap,
      onFlipChange: onFlipChange,
      onPrivacyChange: onPrivacyChange,
      bankLogo: bankLogo,
      chipWidget: chipWidget,
      actionBadge: actionBadge,
    );
  }

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
    ChipColor chipColor = ChipColor.gold,
    bool isFrozen = false,
    bool isExpired = false,
    bool isPrivacyMode = false,
    bool enableFlip = true,
    bool enable3DTilt = true,
    double width = 240.0,
    VoidCallback? onTap,
    ValueChanged<bool>? onFlipChange,
    Widget? bankLogo,
    Widget? chipWidget,
    Widget? actionBadge,
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
        chipColor: chipColor,
      ),
      isFrozen: isFrozen,
      isExpired: isExpired,
      isPrivacyMode: isPrivacyMode,
      enableFlip: enableFlip,
      enable3DTilt: enable3DTilt,
      width: width,
      onTap: onTap,
      onFlipChange: onFlipChange,
      bankLogo: bankLogo,
      chipWidget: chipWidget,
      actionBadge: actionBadge,
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
    ChipColor? chipColor,
    bool isFrozen = false,
    bool isExpired = false,
    bool isPrivacyMode = false,
    bool enableFlip = true,
    bool enable3DTilt = true,
    double width = 240.0,
    VoidCallback? onTap,
    ValueChanged<bool>? onFlipChange,
    Widget? bankLogo,
    Widget? chipWidget,
    Widget? actionBadge,
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
        chipColor: chipColor,
      ),
      isFrozen: isFrozen,
      isExpired: isExpired,
      isPrivacyMode: isPrivacyMode,
      enableFlip: enableFlip,
      enable3DTilt: enable3DTilt,
      width: width,
      onTap: onTap,
      onFlipChange: onFlipChange,
      bankLogo: bankLogo,
      chipWidget: chipWidget,
      actionBadge: actionBadge,
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
    ChipColor chipColor = ChipColor.silver,
    bool isFrozen = false,
    bool isExpired = false,
    bool isPrivacyMode = false,
    bool enableFlip = true,
    bool enable3DTilt = true,
    double width = 240.0,
    VoidCallback? onTap,
    ValueChanged<bool>? onFlipChange,
    Widget? bankLogo,
    Widget? chipWidget,
    Widget? actionBadge,
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
        chipColor: chipColor,
      ),
      isFrozen: isFrozen,
      isExpired: isExpired,
      isPrivacyMode: isPrivacyMode,
      enableFlip: enableFlip,
      enable3DTilt: enable3DTilt,
      width: width,
      onTap: onTap,
      onFlipChange: onFlipChange,
      bankLogo: bankLogo,
      chipWidget: chipWidget,
      actionBadge: actionBadge,
    );
  }

  /// Convenient factory for custom artistic patterns (Family D).
  factory VerticalCard.artistic({
    Key? key,
    required String cardNumber,
    required String cardHolder,
    required String expiryDate,
    required String cvv,
    required CustomPainter painter,
    String? bankName,
    CardBrand? brand,
    Color textColor = Colors.white,
    ChipColor chipColor = ChipColor.gold,
    bool isFrozen = false,
    bool isExpired = false,
    bool isPrivacyMode = false,
    bool enableFlip = true,
    bool enable3DTilt = true,
    double width = 240.0,
    VoidCallback? onTap,
    ValueChanged<bool>? onFlipChange,
    Widget? bankLogo,
    Widget? chipWidget,
    Widget? actionBadge,
  }) {
    return VerticalCard(
      key: key,
      cardNumber: cardNumber,
      cardHolder: cardHolder,
      expiryDate: expiryDate,
      cvv: cvv,
      bankName: bankName,
      brand: brand,
      cardTheme: VerticalCardTheme.artistic(
        painter: painter,
        textColor: textColor,
        chipColor: chipColor,
      ),
      isFrozen: isFrozen,
      isExpired: isExpired,
      isPrivacyMode: isPrivacyMode,
      enableFlip: enableFlip,
      enable3DTilt: enable3DTilt,
      width: width,
      onTap: onTap,
      onFlipChange: onFlipChange,
      bankLogo: bankLogo,
      chipWidget: chipWidget,
      actionBadge: actionBadge,
    );
  }

  @override
  State<VerticalCard> createState() => _VerticalCardState();
}

class _VerticalCardState extends State<VerticalCard>
    with TickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  // 3D Tilt controllers & state
  late AnimationController _tiltResetController;
  Animation<Offset>? _tiltResetAnimation;
  double _tiltX = 0.0;
  double _tiltY = 0.0;

  bool _showBack = false;
  late bool _isPrivate;

  @override
  void initState() {
    super.initState();
    _isPrivate = widget.isPrivacyMode;

    // Flip animation controller
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

    // Tilt spring reset controller
    _tiltResetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void didUpdateWidget(covariant VerticalCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPrivacyMode != oldWidget.isPrivacyMode) {
      setState(() {
        _isPrivate = widget.isPrivacyMode;
      });
    }
  }

  @override
  void dispose() {
    _flipController.dispose();
    _tiltResetController.dispose();
    super.dispose();
  }

  void _handleTap() {
    HapticFeedback.selectionClick();
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

  void _handlePanUpdate(DragUpdateDetails details, double cardHeight) {
    if (!widget.enable3DTilt) return;

    _tiltResetController.stop();

    setState(() {
      // Calculate normalized tilt delta
      final dx = (details.localPosition.dx - widget.width / 2) / (widget.width / 2);
      final dy = (details.localPosition.dy - cardHeight / 2) / (cardHeight / 2);

      _tiltX = (dx * widget.maxTiltAngle).clamp(-widget.maxTiltAngle, widget.maxTiltAngle);
      _tiltY = (dy * widget.maxTiltAngle).clamp(-widget.maxTiltAngle, widget.maxTiltAngle);
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    if (!widget.enable3DTilt) return;

    _tiltResetAnimation = Tween<Offset>(
      begin: Offset(_tiltX, _tiltY),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _tiltResetController,
        curve: Curves.easeOutBack,
      ),
    )..addListener(() {
        setState(() {
          _tiltX = _tiltResetAnimation!.value.dx;
          _tiltY = _tiltResetAnimation!.value.dy;
        });
      });

    _tiltResetController.forward(from: 0.0);
  }

  void _togglePrivacy() {
    if (!widget.enablePrivacyToggle) return;
    HapticFeedback.lightImpact();
    setState(() {
      _isPrivate = !_isPrivate;
    });
    widget.onPrivacyChange?.call(_isPrivate);
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.width * 1.586;
    final detectedBrand = widget.brand ?? CardBrand.detect(widget.cardNumber);

    return Center(
      child: GestureDetector(
        onTap: _handleTap,
        onPanUpdate: (d) => _handlePanUpdate(d, height),
        onPanEnd: _handlePanEnd,
        behavior: HitTestBehavior.opaque,
        child: AnimatedBuilder(
          animation: _flipAnimation,
          builder: (context, child) {
            final flipAngle = _flipAnimation.value * math.pi;

            // Matrix4 combining 3D Flip + 3D Tilt perspective
            final transform = Matrix4.identity()
              ..setEntry(3, 2, 0.0012)
              ..rotateX(-_tiltY)
              ..rotateY(flipAngle + _tiltX);

            Widget cardFace = !_showBack
                ? CardFront(
                    cardNumber: widget.cardNumber,
                    cardHolder: widget.cardHolder,
                    expiryDate: widget.expiryDate,
                    bankName: widget.bankName,
                    brand: detectedBrand,
                    cardTheme: widget.cardTheme,
                    isFrozen: widget.isFrozen,
                    isPrivacyMode: _isPrivate,
                    onPrivacyToggle: _togglePrivacy,
                    bankLogo: widget.bankLogo,
                    chipWidget: widget.chipWidget,
                    actionBadge: widget.actionBadge,
                  )
                : Transform(
                    transform: Matrix4.rotationY(math.pi),
                    alignment: Alignment.center,
                    child: CardBack(
                      cvv: widget.cvv,
                      cardTheme: widget.cardTheme,
                      bankName: widget.bankName,
                      isPrivacyMode: _isPrivate,
                    ),
                  );

            // Expired grayscale filter
            if (widget.isExpired) {
              cardFace = ColorFiltered(
                colorFilter: const ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]),
                child: cardFace,
              );
            }

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
                    // Face Content (Front or Back)
                    cardFace,

                    // Specular light reflection gliding across the surface
                    if (widget.enableSpecularGlare && !widget.isFrozen)
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: widget.cardTheme.borderRadius,
                          child: IgnorePointer(
                            child: CustomPaint(
                              painter: SpecularGlarePainter(
                                tiltX: _tiltX,
                                tiltY: _tiltY,
                              ),
                            ),
                          ),
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

                    // Expired Diagonal Rubber Stamp
                    if (widget.isExpired)
                      Center(
                        child: Transform.rotate(
                          angle: -math.pi / 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFE53935),
                                width: 3.0,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0x33E53935),
                            ),
                            child: const Text(
                              'EXPIRED',
                              style: TextStyle(
                                color: Color(0xFFE53935),
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 4.0,
                              ),
                            ),
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
