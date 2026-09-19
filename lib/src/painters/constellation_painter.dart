import 'package:flutter/material.dart';

/// Renders a celestial cosmos star map with geometric constellations,
/// twinkling stellar flares, and astrolabe orbital rings.
class ConstellationPainter extends CustomPainter {
  /// Base deep space void color.
  final Color spaceColor;

  /// Subtle glowing nebula cloud color.
  final Color nebulaColor;

  /// Primary star particle color.
  final Color starColor;

  /// Constellation geometric connecting line color.
  final Color lineColor;

  /// Major stellar flare accent color (e.g. gold or cyan).
  final Color flareColor;

  /// Whether to render orbital celestial rings.
  final bool showCelestialRings;

  const ConstellationPainter({
    this.spaceColor = const Color(0xFF080B14),
    this.nebulaColor = const Color(0xFF2E124D),
    this.starColor = const Color(0xFFFFFFFF),
    this.lineColor = const Color(0xFF93C5FD),
    this.flareColor = const Color(0xFFFFD700),
    this.showCelestialRings = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final rect = Offset.zero & size;
    final w = size.width;
    final h = size.height;

    // 1. Deep Space Void with Soft Radial Nebula Dust
    final spacePaint = Paint()..color = spaceColor;
    canvas.drawRect(rect, spacePaint);

    final nebula1 = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.4, -0.2),
        radius: 0.8,
        colors: [
          nebulaColor.withValues(alpha: 0.45),
          nebulaColor.withValues(alpha: 0.0),
        ],
      ).createShader(rect);
    canvas.drawRect(rect, nebula1);

    final nebula2 = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.5, 0.6),
        radius: 0.7,
        colors: [
          const Color(0xFF1E1B4B).withValues(alpha: 0.40),
          Colors.transparent,
        ],
      ).createShader(rect);
    canvas.drawRect(rect, nebula2);

    // 2. Celestial Astrolabe / Coordinate Rings
    if (showCelestialRings) {
      final ringCenter = Offset(w * 0.5, h * 0.48);
      final ringPaint = Paint()
        ..color = lineColor.withValues(alpha: 0.16)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8;

      for (double r in [w * 0.35, w * 0.55, w * 0.75]) {
        canvas.drawCircle(ringCenter, r, ringPaint);
      }

      // Orbital ellipse
      canvas.drawOval(
        Rect.fromCenter(center: ringCenter, width: w * 0.9, height: h * 0.55),
        ringPaint,
      );
    }

    // 3. Scattered Micro Star Field (Procedural deterministic pseudo-random)
    final microStarPaint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < 60; i++) {
      final sx = ((i * 37) % 97) / 97.0 * w;
      final sy = ((i * 59) % 101) / 101.0 * h;
      final opacity = (0.20 + (((i * 13) % 80) / 100.0)).clamp(0.15, 0.90);
      final radius = (i % 7 == 0) ? 1.5 : ((i % 3 == 0) ? 1.1 : 0.7);

      microStarPaint.color = starColor.withValues(alpha: opacity);
      canvas.drawCircle(Offset(sx, sy), radius, microStarPaint);
    }

    // 4. Major Constellation: Ursa Major / The Big Dipper (Upper half)
    final dipperStars = [
      Offset(w * 0.18, h * 0.22), // Alkaid
      Offset(w * 0.28, h * 0.24), // Mizar
      Offset(w * 0.38, h * 0.26), // Alioth
      Offset(w * 0.46, h * 0.24), // Megrez
      Offset(w * 0.48, h * 0.31), // Phecda
      Offset(w * 0.62, h * 0.30), // Merak
      Offset(w * 0.60, h * 0.21), // Dubhe
    ];

    final constLinePaint = Paint()
      ..color = lineColor.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final dipperPath = Path()
      ..moveTo(dipperStars[0].dx, dipperStars[0].dy)
      ..lineTo(dipperStars[1].dx, dipperStars[1].dy)
      ..lineTo(dipperStars[2].dx, dipperStars[2].dy)
      ..lineTo(dipperStars[3].dx, dipperStars[3].dy)
      ..lineTo(dipperStars[4].dx, dipperStars[4].dy)
      ..lineTo(dipperStars[5].dx, dipperStars[5].dy)
      ..lineTo(dipperStars[6].dx, dipperStars[6].dy)
      ..lineTo(dipperStars[3].dx, dipperStars[3].dy); // close bowl

    canvas.drawPath(dipperPath, constLinePaint);

    // 5. Major Constellation: Orion (Lower half)
    final orionBetelgeuse = Offset(w * 0.32, h * 0.62);
    final orionBellatrix = Offset(w * 0.68, h * 0.60);
    final orionBelt1 = Offset(w * 0.44, h * 0.70);
    final orionBelt2 = Offset(w * 0.50, h * 0.71);
    final orionBelt3 = Offset(w * 0.56, h * 0.72);
    final orionSaiph = Offset(w * 0.36, h * 0.82);
    final orionRigel = Offset(w * 0.64, h * 0.80);

    final orionPath = Path()
      ..moveTo(orionBetelgeuse.dx, orionBetelgeuse.dy)
      ..lineTo(orionBelt1.dx, orionBelt1.dy)
      ..lineTo(orionBelt2.dx, orionBelt2.dy)
      ..lineTo(orionBelt3.dx, orionBelt3.dy)
      ..lineTo(orionBellatrix.dx, orionBellatrix.dy)
      ..moveTo(orionBetelgeuse.dx, orionBetelgeuse.dy)
      ..lineTo(orionBellatrix.dx, orionBellatrix.dy)
      ..moveTo(orionBelt1.dx, orionBelt1.dy)
      ..lineTo(orionSaiph.dx, orionSaiph.dy)
      ..lineTo(orionRigel.dx, orionRigel.dy)
      ..lineTo(orionBelt3.dx, orionBelt3.dy);

    canvas.drawPath(orionPath, constLinePaint);

    // 6. Draw Constellation Star Nodes
    final starNodePaint = Paint()
      ..color = starColor
      ..style = PaintingStyle.fill;

    final allConstellationStars = [
      ...dipperStars,
      orionBetelgeuse,
      orionBellatrix,
      orionBelt1,
      orionBelt2,
      orionBelt3,
      orionSaiph,
      orionRigel,
    ];

    for (final star in allConstellationStars) {
      canvas.drawCircle(star, 2.4, starNodePaint);
      canvas.drawCircle(
        star,
        4.5,
        Paint()
          ..color = starColor.withValues(alpha: 0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8,
      );
    }

    // 7. 4-Point Diamond Starburst Flares on Alpha Stars
    void drawStarburstFlare(Offset center, double flareLength, Color color) {
      final flarePaint = Paint()
        ..color = color.withValues(alpha: 0.85)
        ..strokeWidth = 1.1
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(
        Offset(center.dx - flareLength, center.dy),
        Offset(center.dx + flareLength, center.dy),
        flarePaint,
      );
      canvas.drawLine(
        Offset(center.dx, center.dy - flareLength),
        Offset(center.dx, center.dy + flareLength),
        flarePaint,
      );
    }

    // Polaris (North Star, top center)
    final polaris = Offset(w * 0.50, h * 0.12);
    canvas.drawCircle(polaris, 3.2, Paint()..color = flareColor);
    drawStarburstFlare(polaris, 12.0, flareColor);

    // Betelgeuse (Red Supergiant flare)
    drawStarburstFlare(orionBetelgeuse, 10.0, const Color(0xFFFF8A65));

    // Rigel (Blue Supergiant flare)
    drawStarburstFlare(orionRigel, 10.0, const Color(0xFF67E8F9));
  }

  @override
  bool shouldRepaint(covariant ConstellationPainter oldDelegate) =>
      oldDelegate.spaceColor != spaceColor ||
      oldDelegate.nebulaColor != nebulaColor ||
      oldDelegate.starColor != starColor ||
      oldDelegate.lineColor != lineColor ||
      oldDelegate.flareColor != flareColor ||
      oldDelegate.showCelestialRings != showCelestialRings;
}
