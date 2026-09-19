import 'package:flutter/material.dart';

/// Renders flowing minimalist desert sand dunes at sunset with warm copper,
/// terracotta, and caramel tones, featuring sharp metallic gold ridge crests.
class DesertDunePainter extends CustomPainter {
  /// Sunset sky top color.
  final Color skyTop;

  /// Sunset sky horizon color.
  final Color skyBottom;

  /// Primary metallic gold color for dune crest highlights.
  final Color goldRidgeColor;

  /// Shadow tone for the shaded faces of dunes.
  final Color shadowDuneColor;

  const DesertDunePainter({
    this.skyTop = const Color(0xFF2C1408),
    this.skyBottom = const Color(0xFF9E4817),
    this.goldRidgeColor = const Color(0xFFFFD54F),
    this.shadowDuneColor = const Color(0xFF1F0D05),
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final rect = Offset.zero & size;
    final w = size.width;
    final h = size.height;

    // 1. Warm Sunset Atmosphere Gradient
    final skyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          skyTop,
          Color.lerp(skyTop, skyBottom, 0.5)!,
          skyBottom,
        ],
        stops: const [0.0, 0.35, 0.65],
      ).createShader(rect);
    canvas.drawRect(rect, skyPaint);

    // Subtle soft setting sun glow in upper-left
    final sunGlowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFE082).withValues(alpha: 0.40),
          const Color(0xFFFF8F00).withValues(alpha: 0.15),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(
          center: Offset(w * 0.20, h * 0.18), radius: w * 0.45));
    canvas.drawCircle(Offset(w * 0.20, h * 0.18), w * 0.45, sunGlowPaint);

    // Helper to draw a dune with a lit face, shaded face, and gold crest
    final goldRidgePaint = Paint()
      ..color = goldRidgeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    final goldGlowPaint = Paint()
      ..color = goldRidgeColor.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    // --- DUNE 1 (Distant backdrop dune) ---
    final dune1 = Path()
      ..moveTo(0, h * 0.34)
      ..cubicTo(w * 0.35, h * 0.30, w * 0.65, h * 0.40, w, h * 0.32)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    final dune1Paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFC4682E),
          Color(0xFF7A3614),
        ],
      ).createShader(rect);
    canvas.drawPath(dune1, dune1Paint);

    // Ridge 1
    final ridge1 = Path()
      ..moveTo(0, h * 0.34)
      ..cubicTo(w * 0.35, h * 0.30, w * 0.65, h * 0.40, w, h * 0.32);
    canvas.drawPath(ridge1, goldGlowPaint);
    canvas.drawPath(ridge1, goldRidgePaint);

    // --- DUNE 2 (Mid-range sweeping S-curve) ---
    final dune2 = Path()
      ..moveTo(0, h * 0.48)
      ..cubicTo(w * 0.30, h * 0.54, w * 0.60, h * 0.42, w, h * 0.50)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    final dune2Paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          const Color(0xFFD67838),
          shadowDuneColor,
        ],
      ).createShader(rect);
    canvas.drawPath(dune2, dune2Paint);

    // Ridge 2
    final ridge2 = Path()
      ..moveTo(0, h * 0.48)
      ..cubicTo(w * 0.30, h * 0.54, w * 0.60, h * 0.42, w, h * 0.50);
    canvas.drawPath(ridge2, goldGlowPaint);
    canvas.drawPath(ridge2, goldRidgePaint);

    // --- DUNE 3 (Foreground prominent sand wave) ---
    final dune3 = Path()
      ..moveTo(0, h * 0.62)
      ..cubicTo(w * 0.40, h * 0.58, w * 0.70, h * 0.68, w, h * 0.60)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    final dune3Paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFB55722),
          Color(0xFF4A1B07),
        ],
      ).createShader(rect);
    canvas.drawPath(dune3, dune3Paint);

    // Ridge 3
    final ridge3 = Path()
      ..moveTo(0, h * 0.62)
      ..cubicTo(w * 0.40, h * 0.58, w * 0.70, h * 0.68, w, h * 0.60);
    canvas.drawPath(ridge3, goldGlowPaint);
    canvas.drawPath(ridge3, goldRidgePaint);

    // --- DUNE 4 (Base foreground slope) ---
    final dune4 = Path()
      ..moveTo(0, h * 0.76)
      ..cubicTo(w * 0.45, h * 0.80, w * 0.80, h * 0.72, w, h * 0.78)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    final dune4Paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF6E280A),
          Color(0xFF1F0D05),
        ],
      ).createShader(rect);
    canvas.drawPath(dune4, dune4Paint);

    // Ridge 4
    final ridge4 = Path()
      ..moveTo(0, h * 0.76)
      ..cubicTo(w * 0.45, h * 0.80, w * 0.80, h * 0.72, w, h * 0.78);
    canvas.drawPath(ridge4, goldRidgePaint);
  }

  @override
  bool shouldRepaint(covariant DesertDunePainter oldDelegate) =>
      oldDelegate.skyTop != skyTop ||
      oldDelegate.skyBottom != skyBottom ||
      oldDelegate.goldRidgeColor != goldRidgeColor ||
      oldDelegate.shadowDuneColor != shadowDuneColor;
}
