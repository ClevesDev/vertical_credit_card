import 'dart:ui';
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

  CyberEdgeGlowPainter({
    required this.progress,
    required this.glowColor,
    required this.borderRadius,
    this.beamLengthFraction = 0.28,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = borderRadius.toRRect(rect);

    final basePath = Path()..addRRect(rrect);
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

    // 1. Wide diffused outer neon glow
    final outerGlowPaint = Paint()
      ..color = glowColor.withOpacity(0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7.0);

    canvas.drawPath(beamPath, outerGlowPaint);

    // 2. Focused vibrant mid glow
    final midGlowPaint = Paint()
      ..color = glowColor.withOpacity(0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.5);

    canvas.drawPath(beamPath, midGlowPaint);

    // 3. Ultra-bright hot white core
    final corePaint = Paint()
      ..color = Colors.white.withOpacity(0.95)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(beamPath, corePaint);
  }

  @override
  bool shouldRepaint(covariant CyberEdgeGlowPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.glowColor != glowColor ||
      oldDelegate.borderRadius != borderRadius;
}
