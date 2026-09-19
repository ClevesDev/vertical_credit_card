import 'package:flutter/material.dart';

/// Renders the flagship Flutter Impeller GPU Edition card artwork.
///
/// Features:
/// - Brushed midnight-blue anodized titanium surface.
/// - Geometric high-relief vector watermark spelling "IMPELLER".
/// - Glowing neon cyan/blue Flutter wing glyph.
/// - Vector motherboard GPU circuit traces radiating from the EMV chip.
class ImpellerTechPainter extends CustomPainter {
  /// Base titanium midnight dark color.
  final Color baseColor;

  /// Electric neon cyan accent for circuit traces and glow.
  final Color cyanAccent;

  /// Deep electric blue accent.
  final Color blueAccent;

  const ImpellerTechPainter({
    this.baseColor = const Color(0xFF0A111E),
    this.cyanAccent = const Color(0xFF00E5FF),
    this.blueAccent = const Color(0xFF02569B),
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final rect = Offset.zero & size;
    final w = size.width;
    final h = size.height;

    // -------------------------------------------------------------------------
    // 1. ANODIZED TITANIUM BASE GRADIENT WITH RADIAL GLOW
    // -------------------------------------------------------------------------
    final bgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF14243B), // Highlighted deep navy
          baseColor, // Midnight core
          const Color(0xFF060B14), // Deep edge shadow
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(rect);
    canvas.drawRect(rect, bgPaint);

    // Subtle brushed metallic horizontal micro-lines
    final brushPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.015)
      ..strokeWidth = 1.0;
    for (double y = 4; y < h; y += 4.5) {
      canvas.drawLine(Offset(0, y), Offset(w, y), brushPaint);
    }

    // -------------------------------------------------------------------------
    // 2. AMBIENT GLOW ORB BEHIND FLUTTER EMBLEM & CHIP
    // -------------------------------------------------------------------------
    final glowPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.25, -0.35),
        radius: 0.75,
        colors: [
          cyanAccent.withValues(alpha: 0.22),
          blueAccent.withValues(alpha: 0.12),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(rect);
    canvas.drawRect(rect, glowPaint);

    // -------------------------------------------------------------------------
    // 3. VECTOR MOTHERBOARD CIRCUIT TRACES & GPU BUS LINES
    // -------------------------------------------------------------------------
    _drawCircuitTraces(canvas, w, h);

    // -------------------------------------------------------------------------
    // 4. CHISELED "IMPELLER" GEOMETRIC WATERMARK
    // -------------------------------------------------------------------------
    _drawImpellerWatermark(canvas, w, h);

    // -------------------------------------------------------------------------
    // 5. GLOWING NEON FLUTTER WING EMBLEM (CENTER-LEFT)
    // -------------------------------------------------------------------------
    _drawFlutterEmblem(canvas, w, h);
  }

  void _drawCircuitTraces(Canvas canvas, double w, double h) {
    // Outer soft glow for circuit lines
    final glowTracePaint = Paint()
      ..color = cyanAccent.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    // Crisp high-speed core trace
    final coreTracePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    // Small solder via / micro-connection pad paint
    final viaFill = Paint()..color = const Color(0xFF8CEEFF);
    final viaRing = Paint()
      ..color = cyanAccent.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final traces = <Path>[
      // Trace 1: From chip region sweeping diagonally down to the right
      Path()
        ..moveTo(w * 0.58, h * 0.24)
        ..lineTo(w * 0.70, h * 0.24)
        ..lineTo(w * 0.85, h * 0.34)
        ..lineTo(w * 0.85, h * 0.44),

      // Trace 2: Upper horizontal bus line
      Path()
        ..moveTo(w * 0.54, h * 0.20)
        ..lineTo(w * 0.65, h * 0.20)
        ..lineTo(w * 0.78, h * 0.12)
        ..lineTo(w * 0.92, h * 0.12),

      // Trace 3: Lower bus line with 45-degree dog-leg
      Path()
        ..moveTo(w * 0.48, h * 0.28)
        ..lineTo(w * 0.58, h * 0.35)
        ..lineTo(w * 0.72, h * 0.35)
        ..lineTo(w * 0.82, h * 0.42)
        ..lineTo(w * 0.94, h * 0.42),

      // Trace 4: Vertical bus drop
      Path()
        ..moveTo(w * 0.62, h * 0.26)
        ..lineTo(w * 0.62, h * 0.32)
        ..lineTo(w * 0.68, h * 0.38)
        ..lineTo(w * 0.68, h * 0.46),
    ];

    for (final path in traces) {
      canvas.drawPath(path, glowTracePaint);
      canvas.drawPath(path, coreTracePaint);
    }

    // Solder Vias (terminal connection dots)
    final viaPoints = [
      Offset(w * 0.85, h * 0.44),
      Offset(w * 0.92, h * 0.12),
      Offset(w * 0.94, h * 0.42),
      Offset(w * 0.68, h * 0.46),
      Offset(w * 0.70, h * 0.24),
      Offset(w * 0.82, h * 0.42),
    ];

    for (final pt in viaPoints) {
      canvas.drawCircle(pt, 2.5, viaFill);
      canvas.drawCircle(pt, 4.0, viaRing);
    }
  }

  void _drawImpellerWatermark(Canvas canvas, double w, double h) {
    // Renders the bold geometric uppercase word "IMPELLER" across the lower half
    final shadowPaint = Paint()
      ..color = const Color(0xFF03070D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4;

    final rimPaint = Paint()
      ..color = const Color(0xFF1F3A5F).withValues(alpha: 0.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    final highlightPaint = Paint()
      ..color = const Color(0xFF4882C2).withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    canvas.save();
    canvas.translate(w * 0.08, h * 0.54);

    // Letter specifications: width, height, and kerning
    final letterW = w * 0.088;
    final letterH = h * 0.15;
    final gap = w * 0.024;

    final letters = ['I', 'M', 'P', 'E', 'L', 'L', 'E', 'R'];

    for (int i = 0; i < letters.length; i++) {
      final x = i * (letterW + gap);
      final p = _getLetterPath(letters[i], x, 0, letterW, letterH);

      // Deep drop shadow (recessed into titanium)
      canvas.drawPath(p.shift(const Offset(0.8, 1.2)), shadowPaint);
      // Chiseled rim
      canvas.drawPath(p, rimPaint);
      // Top-left bevel highlight
      canvas.drawPath(p.shift(const Offset(-0.6, -0.6)), highlightPaint);
    }

    canvas.restore();
  }

  Path _getLetterPath(String char, double x, double y, double w, double h) {
    final p = Path();
    switch (char) {
      case 'I':
        p.moveTo(x + w * 0.5, y);
        p.lineTo(x + w * 0.5, y + h);
        break;
      case 'M':
        p.moveTo(x, y + h);
        p.lineTo(x, y);
        p.lineTo(x + w * 0.5, y + h * 0.55);
        p.lineTo(x + w, y);
        p.lineTo(x + w, y + h);
        break;
      case 'P':
        p.moveTo(x, y + h);
        p.lineTo(x, y);
        p.lineTo(x + w * 0.8, y);
        p.arcToPoint(
          Offset(x + w * 0.8, y + h * 0.52),
          radius: Radius.circular(h * 0.26),
          clockwise: true,
        );
        p.lineTo(x, y + h * 0.52);
        break;
      case 'E':
        p.moveTo(x + w, y);
        p.lineTo(x, y);
        p.lineTo(x, y + h);
        p.lineTo(x + w, y + h);
        p.moveTo(x, y + h * 0.5);
        p.lineTo(x + w * 0.75, y + h * 0.5);
        break;
      case 'L':
        p.moveTo(x, y);
        p.lineTo(x, y + h);
        p.lineTo(x + w, y + h);
        break;
      case 'R':
        p.moveTo(x, y + h);
        p.lineTo(x, y);
        p.lineTo(x + w * 0.75, y);
        p.arcToPoint(
          Offset(x + w * 0.75, y + h * 0.48),
          radius: Radius.circular(h * 0.24),
          clockwise: true,
        );
        p.lineTo(x, y + h * 0.48);
        p.moveTo(x + w * 0.4, y + h * 0.48);
        p.lineTo(x + w, y + h);
        break;
    }
    return p;
  }

  void _drawFlutterEmblem(Canvas canvas, double w, double h) {
    // Prominent neon stylized Flutter wing in upper-center-left
    canvas.save();
    canvas.translate(w * 0.14, h * 0.14);

    final scale = w * 0.0035;
    canvas.scale(scale, scale);

    // Flutter Wing 1 (Top small chevron)
    final wing1 = Path()
      ..moveTo(24, 0)
      ..lineTo(0, 24)
      ..lineTo(7.5, 31.5)
      ..lineTo(39, 0)
      ..close();

    // Flutter Wing 2 (Lower forward chevron)
    final wing2 = Path()
      ..moveTo(14, 38)
      ..lineTo(22, 30)
      ..lineTo(44, 52)
      ..lineTo(28, 52)
      ..close();

    // Flutter Wing 3 (Lower tail return)
    final wing3 = Path()
      ..moveTo(22, 30)
      ..lineTo(14, 38)
      ..lineTo(28, 52)
      ..lineTo(36, 44)
      ..close();

    // Glow halo
    final glow = Paint()
      ..color = cyanAccent.withValues(alpha: 0.45)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawPath(wing1, glow);
    canvas.drawPath(wing2, glow);
    canvas.drawPath(wing3, glow);

    // Radiant gradient core
    final corePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF80F3FF), Color(0xFF00B0FF), Color(0xFF0070F3)],
      ).createShader(const Rect.fromLTWH(0, 0, 52, 52));

    canvas.drawPath(wing1, corePaint);
    canvas.drawPath(wing2, corePaint);
    canvas.drawPath(wing3, corePaint);

    // Crisp white laser rim
    final laserRim = Paint()
      ..color = Colors.white.withValues(alpha: 0.75)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawPath(wing1, laserRim);
    canvas.drawPath(wing2, laserRim);
    canvas.drawPath(wing3, laserRim);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant ImpellerTechPainter oldDelegate) =>
      oldDelegate.baseColor != baseColor ||
      oldDelegate.cyanAccent != cyanAccent ||
      oldDelegate.blueAccent != blueAccent;
}
