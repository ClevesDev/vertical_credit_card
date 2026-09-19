import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Renders a luxury topographic contour map line texture (Family D: Art & Textures).
class TopographicPainter extends CustomPainter {
  final Color backgroundColor;
  final Color lineColor;
  final double strokeWidth;

  const TopographicPainter({
    this.backgroundColor = const Color(0xFF101216),
    this.lineColor = const Color(0xFFD4AF37), // Soft metallic gold
    this.strokeWidth = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Dark charcoal/obsidian gradient background
    final bgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          backgroundColor,
          const Color(0xFF1A1D24),
          backgroundColor,
        ],
      ).createShader(rect);

    canvas.drawRect(rect, bgPaint);

    final w = size.width;
    final h = size.height;

    // Draw concentric topographic elevation contours
    final contourPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Elevation center 1: Top right hill
    final center1 = Offset(w * 0.85, h * 0.25);
    // Elevation center 2: Bottom left valley
    final center2 = Offset(w * 0.15, h * 0.80);

    for (int i = 1; i <= 16; i++) {
      final radius = i * 22.0;
      final opacity = (0.08 + (i % 3 == 0 ? 0.20 : 0.10)).clamp(0.0, 1.0);
      contourPaint.color = lineColor.withValues(alpha: opacity);

      // Distorted organic oval contour 1
      _drawOrganicContour(canvas, center1, radius, contourPaint, seed: i * 7);

      // Distorted organic contour 2
      _drawOrganicContour(canvas, center2, radius * 0.85, contourPaint,
          seed: i * 11);
    }
  }

  void _drawOrganicContour(
    Canvas canvas,
    Offset center,
    double radius,
    Paint paint, {
    required int seed,
  }) {
    final path = Path();
    const steps = 36;

    for (int i = 0; i <= steps; i++) {
      final theta = (i / steps) * 2 * math.pi;
      // Organic waviness offset
      final distortion = math.sin(theta * 3 + seed) * (radius * 0.08) +
          math.cos(theta * 2) * (radius * 0.06);

      final r = radius + distortion;
      final x = center.dx + r * math.cos(theta);
      final y = center.dy + r * math.sin(theta);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant TopographicPainter oldDelegate) =>
      oldDelegate.lineColor != lineColor ||
      oldDelegate.backgroundColor != backgroundColor;
}
