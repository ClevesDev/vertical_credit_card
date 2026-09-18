import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Renders a breathtaking minimalist solar eclipse with pitch-black obsidian void,
/// incandescent liquid gold corona glow, and a radiant diamond ring lens flare.
class SolarEclipsePainter extends CustomPainter {
  /// Base space / background void color.
  final Color spaceColor;

  /// Primary incandescent solar corona gold color.
  final Color coronaColor;

  /// Specular bright white-gold highlight color for the diamond flare.
  final Color flareColor;

  /// Color of the central dark moon disc.
  final Color moonColor;

  /// Whether to render the diamond ring lens flare starburst.
  final bool showDiamondFlare;

  /// Whether to render solar prominence flares around the corona.
  final bool showProminences;

  const SolarEclipsePainter({
    this.spaceColor = const Color(0xFF05060A),
    this.coronaColor = const Color(0xFFFFB300),
    this.flareColor = const Color(0xFFFFF9E6),
    this.moonColor = const Color(0xFF07080D),
    this.showDiamondFlare = true,
    this.showProminences = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final rect = Offset.zero & size;
    final w = size.width;
    final h = size.height;

    // 1. Deep Space Obsidian Background
    final bgPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.0, -0.2),
        radius: 1.1,
        colors: [
          Color.lerp(spaceColor, const Color(0xFF101322), 0.5)!,
          spaceColor,
          const Color(0xFF020205),
        ],
        stops: const [0.0, 0.7, 1.0],
      ).createShader(rect);
    canvas.drawRect(rect, bgPaint);

    // 2. Subtle Twinkling Distant Stars
    final starPaint = Paint()..color = Colors.white;
    const starPoints = [
      Offset(0.10, 0.08),
      Offset(0.22, 0.05),
      Offset(0.82, 0.07),
      Offset(0.90, 0.14),
      Offset(0.15, 0.18),
      Offset(0.85, 0.22),
      Offset(0.08, 0.55),
      Offset(0.92, 0.58),
      Offset(0.14, 0.65),
      Offset(0.86, 0.68),
      Offset(0.06, 0.28),
      Offset(0.94, 0.32),
    ];
    for (int i = 0; i < starPoints.length; i++) {
      final pos = Offset(starPoints[i].dx * w, starPoints[i].dy * h);
      final r = (i % 3 == 0) ? 1.3 : 0.75;
      final alpha = (i % 2 == 0) ? 0.60 : 0.30;
      starPaint.color = Colors.white.withOpacity(alpha);
      canvas.drawCircle(pos, r, starPaint);
    }

    // 3. Central Eclipse Geometry
    // Sits in the hero zone between chip and card number
    final center = Offset(w * 0.50, h * 0.40);
    final moonRadius = w * 0.26; // ~62px on 240px card

    // 4. Solar Corona Glowing Haze Layers
    // Layer A: Wide atmospheric ambient bloom
    final outerHazePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          coronaColor.withOpacity(0.30),
          coronaColor.withOpacity(0.12),
          Colors.transparent,
        ],
        stops: const [0.65, 0.85, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: moonRadius * 2.0));
    canvas.drawCircle(center, moonRadius * 2.0, outerHazePaint);

    // Layer B: Mid intense golden thermal corona
    final midCoronaPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Color.lerp(coronaColor, Colors.white, 0.3)!.withOpacity(0.55),
          coronaColor.withOpacity(0.35),
          Colors.transparent,
        ],
        stops: const [0.75, 0.90, 1.0],
      ).createShader(
          Rect.fromCircle(center: center, radius: moonRadius * 1.45));
    canvas.drawCircle(center, moonRadius * 1.45, midCoronaPaint);

    // 5. Solar Prominence Wisps (Flame-like coronal tongues)
    if (showProminences) {
      final prominencePaint = Paint()
        ..color = Color.lerp(coronaColor, Colors.white, 0.4)!.withOpacity(0.40)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4;

      const numRays = 32;
      for (int i = 0; i < numRays; i++) {
        final angle = (i / numRays) * 2 * math.pi;
        // Vary ray height pseudo-randomly based on angle
        final rayLen =
            4.0 + (math.sin(i * 1.7) * 7.0).abs() + (i % 4 == 0 ? 8.0 : 0.0);
        final start = Offset(
          center.dx + math.cos(angle) * (moonRadius - 1.0),
          center.dy + math.sin(angle) * (moonRadius - 1.0),
        );
        final end = Offset(
          center.dx + math.cos(angle) * (moonRadius + rayLen),
          center.dy + math.sin(angle) * (moonRadius + rayLen),
        );
        canvas.drawLine(start, end, prominencePaint);
      }
    }

    // 6. Brilliant Inner Rim Ring
    final rimPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.transparent,
          Color.lerp(coronaColor, Colors.white, 0.6)!.withOpacity(0.85),
          Colors.white,
          Colors.transparent,
        ],
        stops: const [0.85, 0.96, 0.99, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: moonRadius + 2.0));
    canvas.drawCircle(center, moonRadius + 2.0, rimPaint);

    // 7. Dark Moon Silhouette
    final moonPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.2, -0.2),
        radius: 0.9,
        colors: [
          Color.lerp(moonColor, const Color(0xFF141724), 0.3)!,
          moonColor,
          const Color(0xFF030306),
        ],
        stops: const [0.0, 0.65, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: moonRadius));
    canvas.drawCircle(center, moonRadius, moonPaint);

    // Faint lunar rim back-glow
    final moonEdgePaint = Paint()
      ..color = coronaColor.withOpacity(0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawCircle(center, moonRadius, moonEdgePaint);

    // 8. Diamond Ring Lens Flare (The Iconic Baily's Bead)
    if (showDiamondFlare) {
      // Positioned at the 2 o'clock position on the moon's rim
      const flareAngle = -math.pi * 0.28;
      final flarePos = Offset(
        center.dx + math.cos(flareAngle) * moonRadius,
        center.dy + math.sin(flareAngle) * moonRadius,
      );

      // A. Intense Circular Core Glow
      final flareCoreBloom = Paint()
        ..shader = RadialGradient(
          colors: [
            flareColor,
            Color.lerp(coronaColor, Colors.white, 0.5)!.withOpacity(0.8),
            coronaColor.withOpacity(0.3),
            Colors.transparent,
          ],
          stops: const [0.0, 0.25, 0.6, 1.0],
        ).createShader(Rect.fromCircle(center: flarePos, radius: 26.0));
      canvas.drawCircle(flarePos, 26.0, flareCoreBloom);

      // B. 4-Point Starburst Diffraction Flare Spikes
      final spikePaint = Paint()
        ..color = Colors.white.withOpacity(0.90)
        ..strokeWidth = 1.4
        ..strokeCap = StrokeCap.round;

      final subSpikePaint = Paint()
        ..color = Color.lerp(coronaColor, Colors.white, 0.7)!.withOpacity(0.60)
        ..strokeWidth = 0.8
        ..strokeCap = StrokeCap.round;

      const majorLen = 28.0;
      const minorLen = 14.0;

      // Vertical & Horizontal Spikes
      canvas.drawLine(Offset(flarePos.dx, flarePos.dy - majorLen),
          Offset(flarePos.dx, flarePos.dy + majorLen), spikePaint);
      canvas.drawLine(Offset(flarePos.dx - majorLen, flarePos.dy),
          Offset(flarePos.dx + majorLen, flarePos.dy), spikePaint);

      // Diagonal 45-degree Spikes
      canvas.drawLine(
          Offset(flarePos.dx - minorLen, flarePos.dy - minorLen),
          Offset(flarePos.dx + minorLen, flarePos.dy + minorLen),
          subSpikePaint);
      canvas.drawLine(
          Offset(flarePos.dx + minorLen, flarePos.dy - minorLen),
          Offset(flarePos.dx - minorLen, flarePos.dy + minorLen),
          subSpikePaint);

      // C. Micro-Sparkle Particle Embers
      final sparkPaint = Paint()..color = flareColor;
      final sparkOffsets = [
        Offset(flarePos.dx + 9.0, flarePos.dy - 7.0),
        Offset(flarePos.dx + 15.0, flarePos.dy - 12.0),
        Offset(flarePos.dx + 7.0, flarePos.dy - 16.0),
        Offset(flarePos.dx + 18.0, flarePos.dy - 5.0),
        Offset(flarePos.dx + 12.0, flarePos.dy + 8.0),
        Offset(flarePos.dx + 22.0, flarePos.dy - 10.0),
      ];
      for (int s = 0; s < sparkOffsets.length; s++) {
        final sparkR = (s % 2 == 0) ? 1.2 : 0.8;
        sparkPaint.color = Colors.white.withOpacity((s % 2 == 0) ? 0.85 : 0.50);
        canvas.drawCircle(sparkOffsets[s], sparkR, sparkPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant SolarEclipsePainter oldDelegate) =>
      oldDelegate.spaceColor != spaceColor ||
      oldDelegate.coronaColor != coronaColor ||
      oldDelegate.flareColor != flareColor ||
      oldDelegate.moonColor != moonColor ||
      oldDelegate.showDiamondFlare != showDiamondFlare ||
      oldDelegate.showProminences != showProminences;
}
