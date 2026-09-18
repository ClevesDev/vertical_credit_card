import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Custom painter rendering a realistic metallic security hologram sticker
/// with iridescent diffraction colors and an embossed security globe emblem.
class SecurityHologramPainter extends CustomPainter {
  /// Base brightness/intensity of the metallic foil.
  final double shimmerOffset;

  /// Corner radius of the hologram sticker.
  final BorderRadius borderRadius;

  /// Creates a [SecurityHologramPainter].
  const SecurityHologramPainter({
    this.shimmerOffset = 0.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = borderRadius.toRRect(rect);

    canvas.save();
    canvas.clipRRect(rrect);

    // 1. Base brushed silver/platinum foil background
    final baseGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: const [
        Color(0xFFE0E0E6),
        Color(0xFFB8B8C2),
        Color(0xFFE8E8EE),
        Color(0xFFA0A0AA),
        Color(0xFFD0D0D8),
      ],
      stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
    );
    canvas.drawRect(rect, Paint()..shader = baseGradient.createShader(rect));

    // 2. Iridescent rainbow diffraction sweep
    final rainbowGradient = SweepGradient(
      center: Alignment.center,
      startAngle: shimmerOffset * math.pi,
      endAngle: (shimmerOffset * math.pi) + (math.pi * 2),
      colors: const [
        Color(0x5500FFFF), // Cyan
        Color(0x5500FF66), // Lime
        Color(0x66FFFF00), // Yellow
        Color(0x66FF007F), // Magenta
        Color(0x557F00FF), // Violet
        Color(0x5500FFFF), // Cyan
      ],
    );
    canvas.drawRect(
      rect,
      Paint()
        ..shader = rainbowGradient.createShader(rect)
        ..blendMode = BlendMode.colorDodge,
    );

    // 3. Security micro-etching grid lines
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.22)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    for (double x = -size.height; x < size.width; x += 4.0) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + size.height, 0),
        linePaint,
      );
    }

    // 4. Embossed Security Emblem (Globe with latitude/longitude rings)
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) * 0.35;

    final emblemPaint = Paint()
      ..color = const Color(0x99FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9;

    // Outer globe ring
    canvas.drawCircle(center, radius, emblemPaint);

    // Latitude ellipses
    final ovalRect1 = Rect.fromCenter(
      center: center,
      width: radius * 2,
      height: radius * 1.1,
    );
    canvas.drawOval(ovalRect1, emblemPaint);

    final ovalRect2 = Rect.fromCenter(
      center: center,
      width: radius * 1.1,
      height: radius * 2,
    );
    canvas.drawOval(ovalRect2, emblemPaint);

    // Equator line
    canvas.drawLine(
      Offset(center.dx - radius, center.dy),
      Offset(center.dx + radius, center.dy),
      emblemPaint,
    );

    // 5. Specular highlight glint across edge
    final borderPaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRRect(rrect, borderPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant SecurityHologramPainter oldDelegate) {
    return oldDelegate.shimmerOffset != shimmerOffset ||
        oldDelegate.borderRadius != borderRadius;
  }
}
