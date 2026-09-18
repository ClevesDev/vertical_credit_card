import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Renders Japanese Golden Kintsugi ceramic fractures with branching
/// molten gold veins, fissure depth shadows, and metallic gold foil leaf.
class KintsugiPainter extends CustomPainter {
  /// Base porcelain / obsidian ceramic plate color.
  final Color baseColor;

  /// Primary molten gold vein color.
  final Color goldColor;

  /// Specular bright radiant gold highlight.
  final Color highlightGold;

  /// Deep crack under-shadow color.
  final Color shadowCrack;

  /// Average stroke width of the primary gold seams.
  final double crackWidth;

  const KintsugiPainter({
    this.baseColor = const Color(0xFF12141A),
    this.goldColor = const Color(0xFFFFD700),
    this.highlightGold = const Color(0xFFFFF491),
    this.shadowCrack = const Color(0xFF06070A),
    this.crackWidth = 2.2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final rect = Offset.zero & size;
    final w = size.width;
    final h = size.height;

    // 1. Ceramic Matte Surface with Subtle Radial Depth
    final bgPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.2, -0.3),
        radius: 1.1,
        colors: [
          Color.lerp(baseColor, const Color(0xFF222834), 0.25)!,
          baseColor,
        ],
      ).createShader(rect);

    canvas.drawRect(rect, bgPaint);

    // 2. Main Fracture Paths
    // Vein 1: Sweeps from top-left through center down to bottom-right
    final mainVein1 = Path()
      ..moveTo(w * 0.12, 0)
      ..lineTo(w * 0.22, h * 0.18)
      ..lineTo(w * 0.35, h * 0.26)
      ..lineTo(w * 0.32, h * 0.42)
      ..lineTo(w * 0.52, h * 0.54)
      ..lineTo(w * 0.65, h * 0.72)
      ..lineTo(w * 0.78, h * 0.82)
      ..lineTo(w * 0.88, h);

    // Branch 1A: Breaks off towards right edge
    final branch1A = Path()
      ..moveTo(w * 0.35, h * 0.26)
      ..lineTo(w * 0.55, h * 0.24)
      ..lineTo(w * 0.68, h * 0.32)
      ..lineTo(w * 0.92, h * 0.30)
      ..lineTo(w, h * 0.34);

    // Branch 1B: Breaks off towards left edge
    final branch1B = Path()
      ..moveTo(w * 0.52, h * 0.54)
      ..lineTo(w * 0.42, h * 0.62)
      ..lineTo(w * 0.25, h * 0.68)
      ..lineTo(w * 0.14, h * 0.78)
      ..lineTo(0, h * 0.84);

    // Secondary Vein 2: Top-right corner tension fracture
    final vein2 = Path()
      ..moveTo(w * 0.75, 0)
      ..lineTo(w * 0.80, h * 0.12)
      ..lineTo(w * 0.95, h * 0.16)
      ..lineTo(w, h * 0.18);

    final allVeins = [mainVein1, branch1A, branch1B, vein2];

    // 3. Draw Fissure Shadows (Cast slight shadow for physical crack depth)
    final shadowPaint = Paint()
      ..color = shadowCrack.withOpacity(0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = crackWidth + 1.6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (final vein in allVeins) {
      canvas.drawPath(vein, shadowPaint);
    }

    // 4. Draw Molten Gold Fill Seams
    final goldPaint = Paint()
      ..color = goldColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = crackWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (final vein in allVeins) {
      canvas.drawPath(vein, goldPaint);
    }

    // 5. Specular Radiant Gold Highlights (Fine center bead)
    final highlightPaint = Paint()
      ..color = highlightGold.withOpacity(0.80)
      ..style = PaintingStyle.stroke
      ..strokeWidth = crackWidth * 0.45
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (final vein in allVeins) {
      canvas.drawPath(vein, highlightPaint);
    }

    // 6. Gold Foil Leaf / Powder Flecks around Junctions
    final goldFleckPaint = Paint()
      ..color = goldColor.withOpacity(0.75)
      ..style = PaintingStyle.fill;

    final junctions = [
      Offset(w * 0.35, h * 0.26),
      Offset(w * 0.52, h * 0.54),
      Offset(w * 0.65, h * 0.72),
      Offset(w * 0.22, h * 0.18),
      Offset(w * 0.68, h * 0.32),
    ];

    for (int j = 0; j < junctions.length; j++) {
      final center = junctions[j];
      // Draw 3-4 micro gold flecks
      for (int f = 1; f <= 4; f++) {
        final angle = (f * 1.4) + j;
        final dist = 5.0 + (f * 3.0);
        final fleckOffset = Offset(
          center.dx + math.cos(angle) * dist,
          center.dy + math.sin(angle) * dist,
        );
        final r = (f % 2 == 0) ? 1.4 : 0.9;
        canvas.drawCircle(fleckOffset, r, goldFleckPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant KintsugiPainter oldDelegate) =>
      oldDelegate.baseColor != baseColor ||
      oldDelegate.goldColor != goldColor ||
      oldDelegate.highlightGold != highlightGold ||
      oldDelegate.shadowCrack != shadowCrack ||
      oldDelegate.crackWidth != crackWidth;
}
