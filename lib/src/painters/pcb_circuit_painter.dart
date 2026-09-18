import 'package:flutter/material.dart';

/// Renders a high-tech printed circuit board (PCB) with authentic 45-degree chamfered traces, vias, and IC pads.
class PcbCircuitPainter extends CustomPainter {
  /// Base substrate / solder mask color.
  final Color boardColor;

  /// Primary routing trace color (e.g. cyber cyan, electric neon, or copper).
  final Color traceColor;

  /// Surface pad and via solder color (e.g. gold or silver).
  final Color padColor;

  /// Accent highlight color for micro vias and indicators.
  final Color accentColor;

  /// Stroke width for primary circuit traces.
  final double traceWidth;

  const PcbCircuitPainter({
    this.boardColor = const Color(0xFF0B1017),
    this.traceColor = const Color(0xFF00E5FF),
    this.padColor = const Color(0xFFFFD700),
    this.accentColor = const Color(0xFF00FF88),
    this.traceWidth = 1.4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final rect = Offset.zero & size;

    // 1. Matte PCB substrate background with subtle radial gradient
    final bgPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 0.9,
        colors: [
          Color.lerp(boardColor, traceColor, 0.08)!,
          boardColor,
        ],
        stops: const [0.0, 1.0],
      ).createShader(rect);

    canvas.drawRect(rect, bgPaint);

    final w = size.width;
    final h = size.height;

    // 2. Subtle silkscreen micro grid (dots)
    final gridDotPaint = Paint()
      ..color = traceColor.withOpacity(0.06)
      ..style = PaintingStyle.fill;

    const gridStep = 18.0;
    for (double x = gridStep; x < w; x += gridStep) {
      for (double y = gridStep; y < h; y += gridStep) {
        canvas.drawCircle(Offset(x, y), 0.8, gridDotPaint);
      }
    }

    // 3. Traces Paint
    final tracePaint = Paint()
      ..color = traceColor.withOpacity(0.40)
      ..style = PaintingStyle.stroke
      ..strokeWidth = traceWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final accentTracePaint = Paint()
      ..color = accentColor.withOpacity(0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = traceWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Helper to draw a via (circular pad with drill hole)
    void drawVia(Offset center, {double radius = 3.2, bool isGold = true}) {
      final padPaint = Paint()
        ..color = (isGold ? padColor : traceColor).withOpacity(0.75)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, radius, padPaint);

      // Drill hole (dark center)
      final holePaint = Paint()
        ..color = boardColor
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, radius * 0.42, holePaint);
    }

    // 4. Procedural 45°/90° PCB Traces
    // Trace Bundle A: Top right down to center
    final pathA1 = Path()
      ..moveTo(w * 0.85, 0)
      ..lineTo(w * 0.85, h * 0.15)
      ..lineTo(w * 0.65, h * 0.28)
      ..lineTo(w * 0.65, h * 0.45);
    canvas.drawPath(pathA1, tracePaint);
    drawVia(Offset(w * 0.65, h * 0.45));

    final pathA2 = Path()
      ..moveTo(w * 0.92, 0)
      ..lineTo(w * 0.92, h * 0.13)
      ..lineTo(w * 0.72, h * 0.26)
      ..lineTo(w * 0.72, h * 0.50);
    canvas.drawPath(pathA2, tracePaint);
    drawVia(Offset(w * 0.72, h * 0.50));

    // Trace Bundle B: Left side bus
    final pathB1 = Path()
      ..moveTo(0, h * 0.40)
      ..lineTo(w * 0.20, h * 0.40)
      ..lineTo(w * 0.35, h * 0.50)
      ..lineTo(w * 0.35, h * 0.68)
      ..lineTo(w * 0.48, h * 0.76);
    canvas.drawPath(pathB1, tracePaint);
    drawVia(Offset(w * 0.48, h * 0.76));

    final pathB2 = Path()
      ..moveTo(0, h * 0.45)
      ..lineTo(w * 0.18, h * 0.45)
      ..lineTo(w * 0.30, h * 0.53)
      ..lineTo(w * 0.30, h * 0.72);
    canvas.drawPath(pathB2, accentTracePaint);
    drawVia(Offset(w * 0.30, h * 0.72), isGold: false);

    // Trace Bundle C: Bottom bus
    final pathC1 = Path()
      ..moveTo(w * 0.25, h)
      ..lineTo(w * 0.25, h * 0.86)
      ..lineTo(w * 0.40, h * 0.76);
    canvas.drawPath(pathC1, tracePaint);

    final pathC2 = Path()
      ..moveTo(w * 0.75, h)
      ..lineTo(w * 0.75, h * 0.82)
      ..lineTo(w * 0.58, h * 0.71)
      ..lineTo(w * 0.58, h * 0.58);
    canvas.drawPath(pathC2, tracePaint);
    drawVia(Offset(w * 0.58, h * 0.58));

    // 5. IC Microcontroller Footprint (Center/Right area)
    final icCenter = Offset(w * 0.68, h * 0.65);
    const icWidth = 32.0;
    const icHeight = 32.0;
    final icRect =
        Rect.fromCenter(center: icCenter, width: icWidth, height: icHeight);

    // IC Body
    canvas.drawRect(
      icRect,
      Paint()..color = const Color(0xFF070A0F),
    );
    canvas.drawRect(
      icRect,
      Paint()
        ..color = traceColor.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8,
    );

    // IC Pin 1 indicator dot
    canvas.drawCircle(
      icRect.topLeft + const Offset(5, 5),
      1.5,
      Paint()..color = accentColor,
    );

    // IC Pins (left and right sides)
    final pinPaint = Paint()
      ..color = padColor.withOpacity(0.9)
      ..strokeWidth = 1.2;

    for (int p = 0; p < 4; p++) {
      final pinY = icRect.top + 6 + (p * 6.5);
      // Left pins
      canvas.drawLine(
          Offset(icRect.left - 4, pinY), Offset(icRect.left, pinY), pinPaint);
      // Right pins
      canvas.drawLine(
          Offset(icRect.right, pinY), Offset(icRect.right + 4, pinY), pinPaint);
    }

    // 6. SMD Passive Components (Resistors/Capacitors)
    void drawSmdComponent(Offset center, double angle) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle);
      // Ceramic body
      canvas.drawRect(
        const Rect.fromLTWH(-5, -2.5, 10, 5),
        Paint()..color = const Color(0xFF1E2836),
      );
      // Solder end caps
      canvas.drawRect(
        const Rect.fromLTWH(-5, -2.5, 2.5, 5),
        Paint()..color = padColor.withOpacity(0.85),
      );
      canvas.drawRect(
        const Rect.fromLTWH(2.5, -2.5, 2.5, 5),
        Paint()..color = padColor.withOpacity(0.85),
      );
      canvas.restore();
    }

    drawSmdComponent(Offset(w * 0.22, h * 0.22), 0.785); // 45 deg
    drawSmdComponent(Offset(w * 0.38, h * 0.35), 0.0);
    drawSmdComponent(Offset(w * 0.82, h * 0.38), 1.57); // 90 deg

    // 7. Extra decorative micro test points
    drawVia(Offset(w * 0.15, h * 0.18), radius: 2.2);
    drawVia(Offset(w * 0.18, h * 0.15), radius: 2.2);
    drawVia(Offset(w * 0.88, h * 0.78), radius: 2.4, isGold: false);
  }

  @override
  bool shouldRepaint(covariant PcbCircuitPainter oldDelegate) =>
      oldDelegate.boardColor != boardColor ||
      oldDelegate.traceColor != traceColor ||
      oldDelegate.padColor != padColor ||
      oldDelegate.accentColor != accentColor ||
      oldDelegate.traceWidth != traceWidth;
}
