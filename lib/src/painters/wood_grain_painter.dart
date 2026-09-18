import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Renders organic natural wood grain textures for eco-friendly and bamboo cards.
class WoodGrainPainter extends CustomPainter {
  /// Base primary wood tone.
  final Color baseColor;

  /// Secondary grain tone for streaks and fibers.
  final Color grainColor;

  /// Deeper accent tone for rings and knots.
  final Color ringColor;

  /// Total number of grain lines across the card.
  final int lineCount;

  /// Waviness factor of the wood fibers.
  final double waviness;

  const WoodGrainPainter({
    this.baseColor = const Color(0xFFD8B277),
    this.grainColor = const Color(0xFFA67B42),
    this.ringColor = const Color(0xFF6B4B22),
    this.lineCount = 26,
    this.waviness = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final rect = Offset.zero & size;

    // 1. Base wood tonal gradient
    final bgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          baseColor,
          Color.lerp(baseColor, grainColor, 0.25)!,
          baseColor,
          Color.lerp(baseColor, ringColor, 0.15)!,
        ],
        stops: const [0.0, 0.35, 0.7, 1.0],
      ).createShader(rect);

    canvas.drawRect(rect, bgPaint);

    final w = size.width;
    final h = size.height;

    // Wood knot position (natural imperfection)
    final knotCenter = Offset(w * 0.72, h * 0.42);

    // 2. Wavy organic grain lines
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final stepX = w / (lineCount + 2);

    for (int i = 0; i <= lineCount; i++) {
      final startX = stepX * (i + 1);
      final path = Path();
      path.moveTo(startX, 0);

      const segments = 24;
      final stepY = h / segments;

      for (int s = 1; s <= segments; s++) {
        final currentY = s * stepY;

        // Base wavy sine wave variation
        double offsetX = math.sin((currentY / h) * 4 * math.pi + (i * 0.8)) *
            (4.0 * waviness);

        // Deflect around the knot center
        final dy = currentY - knotCenter.dy;
        final distToKnot = (startX - knotCenter.dx).abs() + dy.abs() * 0.6;
        if (distToKnot < 80.0) {
          final push = (80.0 - distToKnot) * 0.35;
          offsetX += (startX < knotCenter.dx ? -push : push);
        }

        final targetX = (startX + offsetX).clamp(0.0, w);
        path.lineTo(targetX, currentY);
      }

      final isDarkerStreak = i % 4 == 0;
      final isAccentStreak = i % 7 == 0;

      final color = isAccentStreak
          ? ringColor.withOpacity(0.35)
          : isDarkerStreak
              ? grainColor.withOpacity(0.28)
              : grainColor.withOpacity(0.12);

      final width = isAccentStreak ? 1.4 : (isDarkerStreak ? 1.0 : 0.6);

      strokePaint
        ..color = color
        ..strokeWidth = width;

      canvas.drawPath(path, strokePaint);
    }

    // 3. Draw subtle growth knot rings
    final knotPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    for (int r = 1; r <= 4; r++) {
      knotPaint.color = ringColor.withOpacity(0.22 - (r * 0.04));
      canvas.drawOval(
        Rect.fromCenter(
          center: knotCenter,
          width: r * 14.0,
          height: r * 24.0,
        ),
        knotPaint,
      );
    }

    // 4. Subtle porous fiber sheen overlay
    final fiberPaint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..strokeWidth = 0.5;

    for (double x = 4; x < w; x += 12) {
      canvas.drawLine(Offset(x, 0), Offset(x, h), fiberPaint);
    }
  }

  @override
  bool shouldRepaint(covariant WoodGrainPainter oldDelegate) =>
      oldDelegate.baseColor != baseColor ||
      oldDelegate.grainColor != grainColor ||
      oldDelegate.ringColor != ringColor ||
      oldDelegate.lineCount != lineCount ||
      oldDelegate.waviness != waviness;
}
