import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Renders an expanding, translucent contactless payment sonar pulse across the card.
class PaymentPulsePainter extends CustomPainter {
  /// Progress of the pulse animation from 0.0 to 1.0.
  final double progress;

  /// Pulse glow color (typically vibrant cyan, emerald, or gold).
  final Color pulseColor;

  /// Origin center of the pulse (default: top right near contactless icon).
  final Offset? origin;

  PaymentPulsePainter({
    required this.progress,
    this.pulseColor = const Color(0xFF00FFC2),
    this.origin,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0.0 || progress >= 1.0) return;

    final center = origin ?? Offset(size.width * 0.78, size.height * 0.14);
    final maxRadius =
        math.sqrt(size.width * size.width + size.height * size.height);

    // Render 3 expanding wavefronts with staggered phase offsets
    const waveCount = 3;
    const waveStagger = 0.22;

    for (int i = 0; i < waveCount; i++) {
      final waveProgress = (progress - (i * waveStagger));
      if (waveProgress <= 0.0 || waveProgress > 1.0) continue;

      final curvedProgress = Curves.easeOutCubic.transform(waveProgress);
      final radius = curvedProgress * maxRadius * 0.95;
      final opacity = (1.0 - curvedProgress).clamp(0.0, 1.0);

      // Diffused outer wave
      final wavePaint = Paint()
        ..color = pulseColor.withOpacity(opacity * 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0 + (1.0 - curvedProgress) * 4.0
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);

      canvas.drawCircle(center, radius, wavePaint);

      // Core wave ring
      final corePaint = Paint()
        ..color = Colors.white.withOpacity(opacity * 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      canvas.drawCircle(center, radius, corePaint);
    }

    // Flash burst at the origin
    final flashOpacity =
        (1.0 - Curves.easeOutQuad.transform(progress)).clamp(0.0, 1.0);
    final flashPaint = Paint()
      ..color = pulseColor.withOpacity(flashOpacity * 0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12.0);

    canvas.drawCircle(center, 24.0 * (1.0 + progress * 0.5), flashPaint);
  }

  @override
  bool shouldRepaint(covariant PaymentPulsePainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.pulseColor != pulseColor ||
      oldDelegate.origin != origin;
}
