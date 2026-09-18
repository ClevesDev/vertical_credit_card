import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Custom painter rendering a dynamic iridescent holographic foil sheen
/// that shifts its spectrum diffraction angles based on 3D tilt coordinates.
class HolographicFoilPainter extends CustomPainter {
  /// Normalized horizontal deflection from -1.0 to 1.0.
  final double tiltX;

  /// Normalized vertical deflection from -1.0 to 1.0.
  final double tiltY;

  /// Corner border radius of the card.
  final BorderRadius borderRadius;

  /// Base opacity of the holographic sheen.
  final double intensity;

  /// Creates a [HolographicFoilPainter].
  const HolographicFoilPainter({
    this.tiltX = 0.0,
    this.tiltY = 0.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.intensity = 0.32,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = borderRadius.toRRect(rect);

    canvas.save();
    canvas.clipRRect(rrect);

    // Dynamic diffraction angle calculated from the tilt vector
    final angle = math.atan2(tiltY, tiltX) + (math.pi / 4);
    final sweepCenter = Offset(
      size.width * (0.5 + tiltX * 0.35),
      size.height * (0.5 + tiltY * 0.35),
    );

    // 1. Iridescent Sweep Spectrum
    final spectrumColors = [
      const Color(0x0000FFFF), // Transparent cyan
      const Color(0x6600FFFF), // Cyan
      const Color(0x6600FF66), // Lime green
      const Color(0x88FFFF00), // Gold yellow
      const Color(0x88FF007F), // Magenta / hot pink
      const Color(0x667F00FF), // Violet
      const Color(0x6600FFFF), // Cyan
      const Color(0x0000FFFF), // Transparent cyan
    ];

    final sweepPaint = Paint()
      ..shader = SweepGradient(
        center: Alignment(
          (sweepCenter.dx / size.width) * 2 - 1,
          (sweepCenter.dy / size.height) * 2 - 1,
        ),
        startAngle: angle,
        endAngle: angle + (math.pi * 2),
        colors: spectrumColors,
        stops: const [0.0, 0.15, 0.3, 0.5, 0.7, 0.85, 0.95, 1.0],
      ).createShader(rect)
      ..blendMode = BlendMode.screen;

    canvas.drawRect(rect, sweepPaint);

    // 2. Linear Sheen Bar (Dynamic high-luminosity glint)
    final barGradient = LinearGradient(
      begin: Alignment(-1.0 + tiltX, -1.0 + tiltY),
      end: Alignment(1.0 + tiltX, 1.0 + tiltY),
      colors: [
        Colors.transparent,
        Colors.white.withOpacity(intensity * 0.15),
        Colors.cyanAccent.withOpacity(intensity * 0.45),
        Colors.pinkAccent.withOpacity(intensity * 0.45),
        Colors.amberAccent.withOpacity(intensity * 0.45),
        Colors.white.withOpacity(intensity * 0.15),
        Colors.transparent,
      ],
      stops: const [0.0, 0.35, 0.45, 0.50, 0.55, 0.65, 1.0],
    );

    final barPaint = Paint()
      ..shader = barGradient.createShader(rect)
      ..blendMode = BlendMode.overlay;

    canvas.drawRect(rect, barPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant HolographicFoilPainter oldDelegate) {
    return oldDelegate.tiltX != tiltX ||
        oldDelegate.tiltY != tiltY ||
        oldDelegate.intensity != intensity ||
        oldDelegate.borderRadius != borderRadius;
  }
}
