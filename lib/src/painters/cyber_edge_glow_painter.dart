import 'package:flutter/material.dart';

/// Renders a dynamic, animated neon light beam running around the rounded perimeter of the card.
class CyberEdgeGlowPainter extends CustomPainter {
  /// Animation progress from 0.0 to 1.0 determining the current position of the beam.
  final double progress;

  /// The primary glowing neon color of the beam.
  final Color glowColor;

  /// Card corner radius to follow along the border.
  final BorderRadius borderRadius;

  /// Beam length as a fraction of the total perimeter (default 0.28 = 28% of perimeter).
  final double beamLengthFraction;

  /// Whether to cycle continuously through the full 360-degree RGB chroma spectrum.
  final bool isRgbChroma;

  /// Whether to render a continuous 360-degree glowing neon tube around the entire perimeter.
  final bool continuousTube;

  CyberEdgeGlowPainter({
    required this.progress,
    required this.glowColor,
    required this.borderRadius,
    this.beamLengthFraction = 0.28,
    this.isRgbChroma = false,
    this.continuousTube = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = borderRadius.toRRect(rect);

    final basePath = Path()..addRRect(rrect);

    final Path targetPath;
    if (continuousTube || beamLengthFraction >= 1.0) {
      targetPath = basePath;
    } else {
      final metrics = basePath.computeMetrics().toList();
      if (metrics.isEmpty) return;

      final metric = metrics.first;
      final totalLength = metric.length;
      final beamLength = totalLength * beamLengthFraction;

      final currentOffset = (progress * totalLength) % totalLength;

      // Extract path segment(s). Handle wrap-around if beam crosses the end of the perimeter.
      final beamPath = Path();
      if (currentOffset + beamLength <= totalLength) {
        beamPath.addPath(
          metric.extractPath(currentOffset, currentOffset + beamLength),
          Offset.zero,
        );
      } else {
        // First part up to totalLength
        beamPath.addPath(
          metric.extractPath(currentOffset, totalLength),
          Offset.zero,
        );
        // Second part wrapped from 0
        final remainder = (currentOffset + beamLength) - totalLength;
        beamPath.addPath(
          metric.extractPath(0, remainder),
          Offset.zero,
        );
      }
      targetPath = beamPath;
    }

    // Determine effective color (dynamic RGB chroma sweep or fixed glow color)
    final effectiveColor = isRgbChroma
        ? HSVColor.fromAHSV(1.0, ((progress * 360.0) % 360.0), 0.92, 1.0)
            .toColor()
        : glowColor;

    // 1. Wide diffused outer neon glow
    final outerGlowPaint = Paint()
      ..color = effectiveColor.withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7.0);

    canvas.drawPath(targetPath, outerGlowPaint);

    // 2. Focused vibrant mid glow
    final midGlowPaint = Paint()
      ..color = effectiveColor.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.5);

    canvas.drawPath(targetPath, midGlowPaint);

    // 3. Ultra-bright hot white core
    final corePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.95)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(targetPath, corePaint);
  }

  @override
  bool shouldRepaint(covariant CyberEdgeGlowPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.glowColor != glowColor ||
      oldDelegate.borderRadius != borderRadius ||
      oldDelegate.isRgbChroma != isRgbChroma ||
      oldDelegate.continuousTube != continuousTube;
}
