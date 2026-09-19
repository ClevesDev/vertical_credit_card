import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Renders a 1920s Great Gatsby Art Déco architectural luxury pattern
/// with symmetrical concentric fan arches, sunburst chevrons, and stepped gold borders.
class ArtDecoPainter extends CustomPainter {
  /// Base background tone (e.g. deep emerald green or onyx black).
  final Color backgroundColor;

  /// Primary metallic gold line color.
  final Color goldColor;

  /// Secondary champagne specular highlight color.
  final Color highlightGold;

  /// Default line stroke width.
  final double strokeWidth;

  const ArtDecoPainter({
    this.backgroundColor = const Color(0xFF081C15), // Deep luxury emerald
    this.goldColor = const Color(0xFFD4AF37),
    this.highlightGold = const Color(0xFFF9EDB8),
    this.strokeWidth = 1.2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final rect = Offset.zero & size;
    final w = size.width;
    final h = size.height;

    // 1. Deep Luxury Background Gradient
    final bgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          backgroundColor,
          Color.lerp(backgroundColor, const Color(0xFF14382C), 0.5)!,
          backgroundColor,
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(rect);

    canvas.drawRect(rect, bgPaint);

    final goldPaint = Paint()
      ..color = goldColor.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.square;

    final brightPaint = Paint()
      ..color = highlightGold.withValues(alpha: 0.80)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 0.8
      ..strokeCap = StrokeCap.square;

    // 2. Stepped Art Déco Perimeter Frame
    const m1 = 12.0;
    const m2 = 18.0;

    void drawSteppedBorder(double margin, Paint paint) {
      final p = Path()
        ..moveTo(margin + 16, margin)
        ..lineTo(w - margin - 16, margin)
        ..lineTo(w - margin, margin + 16)
        ..lineTo(w - margin, h - margin - 16)
        ..lineTo(w - margin - 16, h - margin)
        ..lineTo(margin + 16, h - margin)
        ..lineTo(margin, h - margin - 16)
        ..lineTo(margin, margin + 16)
        ..close();
      canvas.drawPath(p, paint);
    }

    drawSteppedBorder(m1, goldPaint);
    drawSteppedBorder(m2, brightPaint);

    // 3. Central Symmetrical Art Déco Sunburst Arches
    final center = Offset(w * 0.5, h * 0.5);

    // Concentric Diamond Chevrons in Center
    for (double r in [20.0, 36.0, 52.0, 68.0, 84.0]) {
      final diamond = Path()
        ..moveTo(center.dx, center.dy - r)
        ..lineTo(center.dx + r * 0.8, center.dy)
        ..lineTo(center.dx, center.dy + r)
        ..lineTo(center.dx - r * 0.8, center.dy)
        ..close();

      canvas.drawPath(diamond, r % 36.0 == 0 ? brightPaint : goldPaint);
    }

    // 4. Symmetrical Fan Arches (Top & Bottom Center)
    void drawFanArches(Offset origin, bool isFlipped) {
      final sign = isFlipped ? -1.0 : 1.0;
      for (int i = 1; i <= 6; i++) {
        final radius = i * 16.0;
        final arcRect = Rect.fromCircle(center: origin, radius: radius);
        final startAngle = isFlipped ? 0.0 : math.pi;
        final sweepAngle = isFlipped ? math.pi : math.pi;

        canvas.drawArc(
          arcRect,
          startAngle,
          sweepAngle,
          false,
          i % 2 == 0 ? brightPaint : goldPaint,
        );
      }

      // Radial sunburst spokes
      for (int a = 0; a <= 8; a++) {
        final angle = (a / 8.0) * math.pi;
        final p2 = Offset(
          origin.dx + math.cos(angle) * 96.0,
          origin.dy + (sign * math.sin(angle) * 96.0),
        );
        canvas.drawLine(origin, p2, goldPaint);
      }
    }

    // Top Crest Fan
    drawFanArches(Offset(w * 0.5, m2), true);

    // Bottom Base Fan
    drawFanArches(Offset(w * 0.5, h - m2), false);

    // 5. Vertical Symmetrical Spine Lines
    canvas.drawLine(
      Offset(w * 0.5, m2 + 96.0),
      Offset(w * 0.5, h - m2 - 96.0),
      brightPaint,
    );

    canvas.drawLine(
      Offset(w * 0.46, m2 + 104.0),
      Offset(w * 0.46, h - m2 - 104.0),
      goldPaint,
    );

    canvas.drawLine(
      Offset(w * 0.54, m2 + 104.0),
      Offset(w * 0.54, h - m2 - 104.0),
      goldPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ArtDecoPainter oldDelegate) =>
      oldDelegate.backgroundColor != backgroundColor ||
      oldDelegate.goldColor != goldColor ||
      oldDelegate.highlightGold != highlightGold ||
      oldDelegate.strokeWidth != strokeWidth;
}
