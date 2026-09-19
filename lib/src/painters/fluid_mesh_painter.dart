import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Renders a dynamic, organic chromatic fluid mesh gradient background
/// reminiscent of Revolut Metal, Apple Card, and modern fintech branding.
class FluidMeshPainter extends CustomPainter {
  /// Continuous time parameter in seconds (or animation value) driving the organic fluid motion.
  final double time;

  /// Palette of 4-5 chromatic fluid colors.
  final List<Color> colors;

  /// Base dark or light canvas background color.
  final Color backgroundColor;

  FluidMeshPainter({
    required this.time,
    this.colors = const [
      Color(0xFF6C11D9), // Vibrant Deep Violet
      Color(0xFF00E5FF), // Neon Cyan
      Color(0xFFFF007A), // Hot Magenta
      Color(0xFF4A00E0), // Electric Indigo
    ],
    this.backgroundColor = const Color(0xFF0A0A16),
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Base dark background
    final basePaint = Paint()..color = backgroundColor;
    canvas.drawRect(Offset.zero & size, basePaint);

    final w = size.width;
    final h = size.height;

    // 2. Define 4 floating chromatic orbs with harmonic motion orbits
    final orbs = [
      _Orb(
        x: w * (0.35 + 0.3 * math.sin(time * 0.8)),
        y: h * (0.3 + 0.25 * math.cos(time * 0.6)),
        radius: w * 0.75,
        color: colors[0 % colors.length],
      ),
      _Orb(
        x: w * (0.65 + 0.25 * math.cos(time * 0.9 + 1.2)),
        y: h * (0.7 + 0.2 * math.sin(time * 0.7 + 2.0)),
        radius: w * 0.85,
        color: colors[1 % colors.length],
      ),
      _Orb(
        x: w * (0.2 + 0.3 * math.sin(time * 1.1 + 3.0)),
        y: h * (0.8 + 0.2 * math.cos(time * 0.85 + 0.5)),
        radius: w * 0.7,
        color: colors[2 % colors.length],
      ),
      _Orb(
        x: w * (0.75 + 0.2 * math.cos(time * 0.75 + 4.0)),
        y: h * (0.25 + 0.25 * math.sin(time * 1.0 + 1.5)),
        radius: w * 0.8,
        color: colors[3 % colors.length],
      ),
    ];

    // Draw each orb with soft radial gradient
    for (final orb in orbs) {
      final orbPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            orb.color.withValues(alpha: 0.65),
            orb.color.withValues(alpha: 0.25),
            orb.color.withValues(alpha: 0.0),
          ],
          stops: const [0.0, 0.55, 1.0],
        ).createShader(
          Rect.fromCircle(center: Offset(orb.x, orb.y), radius: orb.radius),
        );

      canvas.drawCircle(Offset(orb.x, orb.y), orb.radius, orbPaint);
    }
  }

  @override
  bool shouldRepaint(covariant FluidMeshPainter oldDelegate) =>
      oldDelegate.time != time ||
      oldDelegate.colors != colors ||
      oldDelegate.backgroundColor != backgroundColor;
}

class _Orb {
  final double x;
  final double y;
  final double radius;
  final Color color;

  const _Orb({
    required this.x,
    required this.y,
    required this.radius,
    required this.color,
  });
}
