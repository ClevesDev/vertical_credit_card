import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Renders a forged Damascus steel wavy folded metal pattern (Family D: Art & Textures).
class DamascusSteelPainter extends CustomPainter {
  /// Deep etched carbon steel tone.
  final Color darkSteel;

  /// Mid-tone gunmetal gray.
  final Color midSteel;

  /// Polished high-nickel steel alloy tone.
  final Color lightSteel;

  /// Specular etched metallic highlight.
  final Color etchedHighlight;

  /// Number of forged fold ribbons.
  final int foldCount;

  /// Ripple frequency of the forge waves.
  final double rippleFrequency;

  const DamascusSteelPainter({
    this.darkSteel = const Color(0xFF141619),
    this.midSteel = const Color(0xFF2C313A),
    this.lightSteel = const Color(0xFF5C6370),
    this.etchedHighlight = const Color(0xFFA0A8B7),
    this.foldCount = 20,
    this.rippleFrequency = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final rect = Offset.zero & size;

    // 1. Base gunmetal forged gradient
    final bgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          darkSteel,
          midSteel,
          darkSteel,
          midSteel.withValues(alpha: 0.9),
        ],
        stops: const [0.0, 0.4, 0.75, 1.0],
      ).createShader(rect);

    canvas.drawRect(rect, bgPaint);

    final w = size.width;
    final h = size.height;

    // 2. Flowing folded steel ribbons
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final stepY = (h + 80.0) / (foldCount + 2);

    for (int i = 0; i <= foldCount + 2; i++) {
      final baseY = (i * stepY) - 40.0;
      final path = Path();
      path.moveTo(0, baseY);

      const segments = 28;
      final stepX = w / segments;

      for (int s = 1; s <= segments; s++) {
        final currentX = s * stepX;
        final normX = currentX / w;

        // Multi-frequency wave simulating hand-forged folded steel
        final wave1 =
            math.sin((normX * 3.5 * math.pi * rippleFrequency) + (i * 0.45)) *
                14.0;
        final wave2 =
            math.cos((normX * 7.0 * math.pi * rippleFrequency) - (i * 0.3)) *
                6.0;
        final wave3 = math.sin((normX * 1.5 * math.pi) + (i * 0.8)) * 10.0;

        final targetY = baseY + wave1 + wave2 + wave3;
        path.lineTo(currentX, targetY);
      }

      final isBrightRidge = i % 3 == 0;
      final isCoreEtch = i % 5 == 0;

      final color = isBrightRidge
          ? etchedHighlight.withValues(alpha: 0.35)
          : isCoreEtch
              ? lightSteel.withValues(alpha: 0.40)
              : lightSteel.withValues(alpha: 0.18);

      final width = isBrightRidge ? 1.6 : (isCoreEtch ? 2.2 : 1.0);

      strokePaint
        ..color = color
        ..strokeWidth = width;

      canvas.drawPath(path, strokePaint);

      // Dark etched shadow valley adjacent to bright ridge
      if (isBrightRidge) {
        final shadowPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 1.0
          ..color = darkSteel.withValues(alpha: 0.65);

        final shadowPath = Path();
        shadowPath.moveTo(0, baseY + 2.0);
        for (int s = 1; s <= segments; s++) {
          final currentX = s * stepX;
          final normX = currentX / w;
          final wave1 =
              math.sin((normX * 3.5 * math.pi * rippleFrequency) + (i * 0.45)) *
                  14.0;
          final wave2 =
              math.cos((normX * 7.0 * math.pi * rippleFrequency) - (i * 0.3)) *
                  6.0;
          final wave3 = math.sin((normX * 1.5 * math.pi) + (i * 0.8)) * 10.0;
          shadowPath.lineTo(currentX, baseY + 2.0 + wave1 + wave2 + wave3);
        }
        canvas.drawPath(shadowPath, shadowPaint);
      }
    }

    // 3. Diagonal specular reflection across Damascus folds
    final glarePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.transparent,
          Colors.white.withValues(alpha: 0.08),
          Colors.transparent,
        ],
        stops: const [0.35, 0.5, 0.65],
      ).createShader(rect);

    canvas.drawRect(rect, glarePaint);
  }

  @override
  bool shouldRepaint(covariant DamascusSteelPainter oldDelegate) =>
      oldDelegate.darkSteel != darkSteel ||
      oldDelegate.midSteel != midSteel ||
      oldDelegate.lightSteel != lightSteel ||
      oldDelegate.etchedHighlight != etchedHighlight ||
      oldDelegate.foldCount != foldCount ||
      oldDelegate.rippleFrequency != rippleFrequency;
}
