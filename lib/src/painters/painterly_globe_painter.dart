import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Renders a dynamic, painterly orbital globe texture with warm solar brushstrokes
/// inspired by modern artistic banking cards (Family D: Abstract Art & Textures).
class PainterlyGlobePainter extends CustomPainter {
  final Color baseColor;

  const PainterlyGlobePainter({
    this.baseColor = const Color(0xFF074585),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Deep rich navy gradient base
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF063A72),
          Color(0xFF0A4F99),
          Color(0xFF042B57),
        ],
      ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, bgPaint);

    // Center of the orbital circle at the bottom-left corner
    final center = Offset(-w * 0.15, h * 1.02);

    // Layer 1: Outer cyan/azure atmospheric arc
    _drawTexturedArc(
      canvas: canvas,
      center: center,
      minRadius: w * 0.95,
      maxRadius: w * 1.35,
      colors: const [
        Color(0xFF1E88E5),
        Color(0xFF0288D1),
        Color(0xFF29B6F6),
      ],
      seed: 101,
      density: 50,
      splatterCount: 60,
    );

    // Layer 2: Mid orbital band (Azure to deep coral-red & orange)
    _drawTexturedArc(
      canvas: canvas,
      center: center,
      minRadius: w * 0.65,
      maxRadius: w * 1.05,
      colors: const [
        Color(0xFFE53935), // Red
        Color(0xFFFF5722), // Coral
        Color(0xFFFF9800), // Amber
        Color(0xFF1E88E5), // Blue merge
      ],
      seed: 202,
      density: 75,
      splatterCount: 90,
    );

    // Layer 3: Inner solar flare core (Vibrant yellow & fiery orange)
    _drawTexturedArc(
      canvas: canvas,
      center: center,
      minRadius: w * 0.35,
      maxRadius: w * 0.75,
      colors: const [
        Color(0xFFFFEB3B), // Bright solar yellow
        Color(0xFFFFC107), // Gold
        Color(0xFFFF9800), // Orange
      ],
      seed: 303,
      density: 90,
      splatterCount: 110,
    );
  }

  void _drawTexturedArc({
    required Canvas canvas,
    required Offset center,
    required double minRadius,
    required double maxRadius,
    required List<Color> colors,
    required int seed,
    required int density,
    required int splatterCount,
  }) {
    final random = math.Random(seed);

    // Draw textured brushstroke segments
    for (int i = 0; i < density; i++) {
      final radius = minRadius + random.nextDouble() * (maxRadius - minRadius);
      final angleStart = -math.pi * 0.55 + random.nextDouble() * 0.15;
      final sweep = math.pi * 0.38 + random.nextDouble() * 0.22;

      final color = colors[random.nextInt(colors.length)]
          .withOpacity(0.55 + random.nextDouble() * 0.4);

      final strokePaint = Paint()
        ..color = color
        ..strokeWidth = 3.5 + random.nextDouble() * 9.0
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        angleStart,
        sweep,
        false,
        strokePaint,
      );
    }

    // Draw artistic paint splatter flecks
    for (int i = 0; i < splatterCount; i++) {
      final radius = minRadius - 20 + random.nextDouble() * (maxRadius - minRadius + 40);
      final angle = -math.pi * 0.52 + random.nextDouble() * 0.55;

      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);

      final color = colors[random.nextInt(colors.length)]
          .withOpacity(0.65 + random.nextDouble() * 0.35);

      final splatterPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      final size = 1.5 + random.nextDouble() * 4.5;

      // Draw irregular dabs
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(angle + math.pi * 0.5 + (random.nextDouble() - 0.5) * 0.4);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset.zero,
          width: size,
          height: size * (1.5 + random.nextDouble() * 2.0),
        ),
        splatterPaint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant PainterlyGlobePainter oldDelegate) => false;
}
