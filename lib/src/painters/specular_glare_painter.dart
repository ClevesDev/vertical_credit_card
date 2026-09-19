import 'package:flutter/material.dart';

/// Renders a dynamic, realistic specular light reflection that glides across
/// the card surface according to the 3D tilt perspective.
class SpecularGlarePainter extends CustomPainter {
  final double tiltX;
  final double tiltY;
  final double intensity;

  const SpecularGlarePainter({
    required this.tiltX,
    required this.tiltY,
    this.intensity = 0.35,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (intensity <= 0) return;

    final w = size.width;
    final h = size.height;

    // The light reflection center shifts in the direction opposite to the tilt
    final lightCenterX = w * 0.5 - (tiltX * w * 1.8);
    final lightCenterY = h * 0.5 - (tiltY * h * 1.8);

    final rect = Offset.zero & size;

    // Angle of the beam across the card (~45 degrees rotated)
    final glareShader = RadialGradient(
      center: Alignment(
        ((lightCenterX / w) * 2 - 1).clamp(-1.2, 1.2),
        ((lightCenterY / h) * 2 - 1).clamp(-1.2, 1.2),
      ),
      radius: 0.95,
      colors: [
        Colors.white.withValues(alpha: 0.40 * intensity),
        Colors.white.withValues(alpha: 0.15 * intensity),
        Colors.white.withValues(alpha: 0.0),
      ],
      stops: const [0.0, 0.45, 1.0],
    ).createShader(rect);

    final glarePaint = Paint()
      ..shader = glareShader
      ..blendMode = BlendMode.screen;

    canvas.drawRect(rect, glarePaint);

    // Diagonal specular flare streak
    final streakPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment(
          -1.0 + (tiltX * 2),
          -1.0 + (tiltY * 2),
        ),
        end: Alignment(
          1.0 + (tiltX * 2),
          1.0 + (tiltY * 2),
        ),
        colors: [
          Colors.white.withValues(alpha: 0.0),
          Colors.white.withValues(alpha: 0.18 * intensity),
          Colors.white.withValues(alpha: 0.0),
        ],
        stops: const [0.35, 0.50, 0.65],
      ).createShader(rect)
      ..blendMode = BlendMode.overlay;

    canvas.drawRect(rect, streakPaint);
  }

  @override
  bool shouldRepaint(covariant SpecularGlarePainter oldDelegate) =>
      oldDelegate.tiltX != tiltX ||
      oldDelegate.tiltY != tiltY ||
      oldDelegate.intensity != intensity;
}
