import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Renders micro-glitter / diamond dust particles across the card surface
/// that twinkle with 4-point starbursts depending on the 3D tilt coordinates.
class DiamondDustPainter extends CustomPainter {
  /// Horizontal tilt factor (-1.0 to 1.0).
  final double tiltX;

  /// Vertical tilt factor (-1.0 to 1.0).
  final double tiltY;

  /// Overall sparkle intensity / density factor (0.0 to 1.0).
  final double intensity;

  /// Sparkle tint color (default: warm crystalline white/gold).
  final Color sparkleColor;

  static final List<_GlitterParticle> _particles =
      _generateDeterministicParticles(42);

  DiamondDustPainter({
    required this.tiltX,
    required this.tiltY,
    this.intensity = 1.0,
    this.sparkleColor = const Color(0xFFFFF9E6),
  });

  static List<_GlitterParticle> _generateDeterministicParticles(int count) {
    final rand = math.Random(1337); // Fixed seed for reproducible placement
    final list = <_GlitterParticle>[];
    for (int i = 0; i < count; i++) {
      list.add(
        _GlitterParticle(
          relX: rand.nextDouble(),
          relY: rand.nextDouble(),
          optimumTiltX: (rand.nextDouble() * 2.0 - 1.0) * 0.25,
          optimumTiltY: (rand.nextDouble() * 2.0 - 1.0) * 0.25,
          maxSize: 1.5 + rand.nextDouble() * 2.5,
          sensitivity: 5.0 + rand.nextDouble() * 7.0,
        ),
      );
    }
    return list;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (intensity <= 0.0) return;

    for (final p in _particles) {
      final dx = p.relX * size.width;
      final dy = p.relY * size.height;

      // Distance in tilt-space from optimum reflection angle
      final distTilt = math.sqrt(
        math.pow(tiltX - p.optimumTiltX, 2) +
            math.pow(tiltY - p.optimumTiltY, 2),
      );

      // Gaussian-like falloff for sparkle flash
      final flash =
          math.exp(-distTilt * p.sensitivity).clamp(0.0, 1.0) * intensity;
      if (flash < 0.05) continue;

      final pointPaint = Paint()
        ..color = sparkleColor.withOpacity(flash * 0.9)
        ..style = PaintingStyle.fill;

      // Small circular core
      canvas.drawCircle(Offset(dx, dy), p.maxSize * 0.35 * flash, pointPaint);

      // If bright enough, draw 4-point star flare
      if (flash > 0.45) {
        final flareLen = p.maxSize * 2.4 * flash;
        final flarePath = Path()
          ..moveTo(dx - flareLen, dy)
          ..quadraticBezierTo(dx, dy, dx, dy - flareLen)
          ..quadraticBezierTo(dx, dy, dx + flareLen, dy)
          ..quadraticBezierTo(dx, dy, dx, dy + flareLen)
          ..close();

        final flarePaint = Paint()
          ..color = Colors.white.withOpacity(flash * 0.8)
          ..style = PaintingStyle.fill;

        canvas.drawPath(flarePath, flarePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DiamondDustPainter oldDelegate) =>
      oldDelegate.tiltX != tiltX ||
      oldDelegate.tiltY != tiltY ||
      oldDelegate.intensity != intensity ||
      oldDelegate.sparkleColor != sparkleColor;
}

class _GlitterParticle {
  final double relX;
  final double relY;
  final double optimumTiltX;
  final double optimumTiltY;
  final double maxSize;
  final double sensitivity;

  const _GlitterParticle({
    required this.relX,
    required this.relY,
    required this.optimumTiltX,
    required this.optimumTiltY,
    required this.maxSize,
    required this.sensitivity,
  });
}
