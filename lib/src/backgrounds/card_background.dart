import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/card_theme.dart';
import '../painters/fluid_mesh_painter.dart';
import '../painters/metallic_painter.dart';

/// Defines the background visual appearance of a vertical credit card.
abstract class CardBackground {
  const CardBackground();

  /// Builds the background widget.
  Widget build(BuildContext context,
      {required BorderRadius borderRadius, required Widget child});

  /// Solid color background.
  const factory CardBackground.solid(Color color) = _SolidCardBackground;

  /// Gradient background (linear, sweep, radial).
  const factory CardBackground.gradient(Gradient gradient) =
      _GradientCardBackground;

  /// Luxury brushed metallic finish.
  const factory CardBackground.metallic(MetalType metalType) =
      _MetallicCardBackground;

  /// Futuristic glassmorphism background with frosted blur and neon border.
  const factory CardBackground.glass({
    Color neonColor,
    double blur,
    Color backgroundColor,
  }) = _GlassCardBackground;

  /// Custom painter background (ideal for artistic textures, waves, and patterns).
  const factory CardBackground.painter(CustomPainter painter,
      {Color backgroundColor}) = _PainterCardBackground;

  /// Chromatic animated fluid mesh gradient background (Revolut Metal & Apple Card style).
  const factory CardBackground.fluid({
    List<Color>? colors,
    Color backgroundColor,
    double speed,
  }) = _FluidCardBackground;

  /// Completely custom builder for maximum flexibility.
  const factory CardBackground.custom(
          Widget Function(BuildContext context, Widget child) builder) =
      _CustomCardBackground;
}

class _SolidCardBackground extends CardBackground {
  final Color color;
  const _SolidCardBackground(this.color);

  @override
  Widget build(BuildContext context,
      {required BorderRadius borderRadius, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class _GradientCardBackground extends CardBackground {
  final Gradient gradient;
  const _GradientCardBackground(this.gradient);

  @override
  Widget build(BuildContext context,
      {required BorderRadius borderRadius, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class _MetallicCardBackground extends CardBackground {
  final MetalType metalType;
  const _MetallicCardBackground(this.metalType);

  @override
  Widget build(BuildContext context,
      {required BorderRadius borderRadius, required Widget child}) {
    return CustomPaint(
      painter: MetallicCardPainter(metalType: metalType),
      child: child,
    );
  }
}

class _GlassCardBackground extends CardBackground {
  final Color neonColor;
  final double blur;
  final Color backgroundColor;

  const _GlassCardBackground({
    this.neonColor = const Color(0xFF00F0FF),
    this.blur = 14.0,
    this.backgroundColor = const Color(0x14FFFFFF),
  });

  @override
  Widget build(BuildContext context,
      {required BorderRadius borderRadius, required Widget child}) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
          border: Border.all(
            color: neonColor.withOpacity(0.65),
            width: 1.5,
          ),
        ),
        child: child,
      ),
    );
  }
}

class _PainterCardBackground extends CardBackground {
  final CustomPainter painter;
  final Color backgroundColor;

  const _PainterCardBackground(this.painter,
      {this.backgroundColor = Colors.transparent});

  @override
  Widget build(BuildContext context,
      {required BorderRadius borderRadius, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: CustomPaint(
        painter: painter,
        child: child,
      ),
    );
  }
}

class _CustomCardBackground extends CardBackground {
  final Widget Function(BuildContext context, Widget child) builder;
  const _CustomCardBackground(this.builder);

  @override
  Widget build(BuildContext context,
      {required BorderRadius borderRadius, required Widget child}) {
    return builder(context, child);
  }
}

class _FluidCardBackground extends CardBackground {
  final List<Color>? colors;
  final Color backgroundColor;
  final double speed;

  const _FluidCardBackground({
    this.colors,
    this.backgroundColor = const Color(0xFF0A0A16),
    this.speed = 1.0,
  });

  @override
  Widget build(BuildContext context,
      {required BorderRadius borderRadius, required Widget child}) {
    return _FluidAnimatedBackgroundWidget(
      colors: colors,
      backgroundColor: backgroundColor,
      speed: speed,
      borderRadius: borderRadius,
      child: child,
    );
  }
}

class _FluidAnimatedBackgroundWidget extends StatefulWidget {
  final List<Color>? colors;
  final Color backgroundColor;
  final double speed;
  final BorderRadius borderRadius;
  final Widget child;

  const _FluidAnimatedBackgroundWidget({
    this.colors,
    required this.backgroundColor,
    required this.speed,
    required this.borderRadius,
    required this.child,
  });

  @override
  State<_FluidAnimatedBackgroundWidget> createState() =>
      _FluidAnimatedBackgroundWidgetState();
}

class _FluidAnimatedBackgroundWidgetState
    extends State<_FluidAnimatedBackgroundWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (12000 / widget.speed).round()),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: FluidMeshPainter(
            time: _controller.value * 2 * 3.141592653589793,
            colors: widget.colors ??
                const [
                  Color(0xFF6C11D9),
                  Color(0xFF00E5FF),
                  Color(0xFFFF007A),
                  Color(0xFF4A00E0),
                ],
            backgroundColor: widget.backgroundColor,
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
