import 'package:flutter/material.dart';

/// Renders authentic Japanese Golden Kintsugi ceramic fractures.
///
/// Simulates fractured obsidian/porcelain plates repaired with molten lacquer
/// and 24k gold leaf, featuring:
/// - Radial spiderweb impact shatter fissures radiating across the card.
/// - 3D chiseled depth shadows beneath each fracture seam.
/// - Radiant molten gold core with specular bright highlight lines.
/// - Organic gold powder flecks and solder nodules around fracture junctions.
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
    this.baseColor = const Color(0xFF0D0F14),
    this.goldColor = const Color(0xFFFFD700),
    this.highlightGold = const Color(0xFFFFF7B8),
    this.shadowCrack = const Color(0xFF020406),
    this.crackWidth = 2.4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final rect = Offset.zero & size;
    final w = size.width;
    final h = size.height;

    // 1. Ceramic Matte Obsidian Surface with Subtle Vignette
    final bgPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.1, -0.2),
        radius: 1.15,
        colors: [
          const Color(0xFF1E222D),
          baseColor,
          const Color(0xFF050608),
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(rect);

    canvas.drawRect(rect, bgPaint);

    // 2. Spiderweb Fracture Epicenter & Radiating Seams
    // Epicenter located at (w * 0.65, h * 0.35)
    final veins = <Path>[
      // Vein 1: Sweeps upward towards top edge
      Path()
        ..moveTo(w * 0.65, h * 0.35)
        ..lineTo(w * 0.62, h * 0.22)
        ..lineTo(w * 0.68, h * 0.12)
        ..lineTo(w * 0.60, 0),

      // Vein 2: Sweeps diagonally up-left towards top-left corner
      Path()
        ..moveTo(w * 0.65, h * 0.35)
        ..lineTo(w * 0.48, h * 0.28)
        ..lineTo(w * 0.36, h * 0.18)
        ..lineTo(w * 0.22, h * 0.12)
        ..lineTo(w * 0.15, 0),

      // Vein 3: Sweeps left across the middle (above chip)
      Path()
        ..moveTo(w * 0.65, h * 0.35)
        ..lineTo(w * 0.50, h * 0.42)
        ..lineTo(w * 0.38, h * 0.38)
        ..lineTo(w * 0.18, h * 0.46)
        ..lineTo(0, h * 0.44),

      // Vein 4: Sweeps diagonally down-left towards bottom-left
      Path()
        ..moveTo(w * 0.65, h * 0.35)
        ..lineTo(w * 0.58, h * 0.52)
        ..lineTo(w * 0.45, h * 0.62)
        ..lineTo(w * 0.32, h * 0.74)
        ..lineTo(w * 0.18, h * 0.86)
        ..lineTo(0, h * 0.92),

      // Vein 5: Sweeps straight down through center
      Path()
        ..moveTo(w * 0.58, h * 0.52)
        ..lineTo(w * 0.64, h * 0.68)
        ..lineTo(w * 0.55, h * 0.82)
        ..lineTo(w * 0.62, h),

      // Vein 6: Sweeps diagonally down-right towards bottom-right corner
      Path()
        ..moveTo(w * 0.65, h * 0.35)
        ..lineTo(w * 0.78, h * 0.48)
        ..lineTo(w * 0.86, h * 0.65)
        ..lineTo(w * 0.92, h * 0.82)
        ..lineTo(w * 0.88, h),

      // Vein 7: Sweeps right to right edge
      Path()
        ..moveTo(w * 0.65, h * 0.35)
        ..lineTo(w * 0.78, h * 0.30)
        ..lineTo(w * 0.90, h * 0.32)
        ..lineTo(w, h * 0.28),

      // Sub-branch 7B: Upper right corner fracture
      Path()
        ..moveTo(w * 0.78, h * 0.30)
        ..lineTo(w * 0.88, h * 0.18)
        ..lineTo(w, h * 0.14),
    ];

    // 3. Draw Fissure Depth Shadows (Recessed physical 3D crack groove)
    final shadowPaint = Paint()
      ..color = shadowCrack.withValues(alpha: 0.95)
      ..style = PaintingStyle.stroke
      ..strokeWidth = crackWidth + 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (final vein in veins) {
      canvas.drawPath(vein.shift(const Offset(0.8, 1.2)), shadowPaint);
    }

    // 4. Soft Golden Ambient Glow around Seams
    final goldGlowPaint = Paint()
      ..color = goldColor.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = crackWidth * 2.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);

    for (final vein in veins) {
      canvas.drawPath(vein, goldGlowPaint);
    }

    // 5. Molten Gold Liquid Seams (Rich 24k gold body)
    final goldPaint = Paint()
      ..color = goldColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = crackWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (final vein in veins) {
      canvas.drawPath(vein, goldPaint);
    }

    // 6. Specular Radiant Gold Highlights (Intense reflective core)
    final highlightPaint = Paint()
      ..color = highlightGold.withValues(alpha: 0.90)
      ..style = PaintingStyle.stroke
      ..strokeWidth = crackWidth * 0.40
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (final vein in veins) {
      canvas.drawPath(vein, highlightPaint);
    }

    // 7. Gold Solder Nodules & Leaf Flecks at Fracture Hubs
    final goldFleckPaint = Paint()
      ..color = highlightGold
      ..style = PaintingStyle.fill;

    final hubs = [
      Offset(w * 0.65, h * 0.35), // Primary epicenter
      Offset(w * 0.58, h * 0.52),
      Offset(w * 0.48, h * 0.28),
      Offset(w * 0.78, h * 0.30),
      Offset(w * 0.45, h * 0.62),
      Offset(w * 0.78, h * 0.48),
    ];

    // Draw solid gold beads at intersections
    for (final hub in hubs) {
      canvas.drawCircle(hub, crackWidth * 0.85, Paint()..color = goldColor);
      canvas.drawCircle(hub, crackWidth * 0.45, goldFleckPaint);
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
