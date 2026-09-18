import 'package:flutter/material.dart';

/// Renders a dynamic Japanese Ukiyo-e inspired surging ocean wave pattern
/// (Great Wave of Kanagawa aesthetic) with layered sea swells and crest foam.
class GreatWavePainter extends CustomPainter {
  /// Base sky and atmospheric background color.
  final Color skyColor;

  /// Deep ocean abyss tone.
  final Color deepSeaColor;

  /// Mid-level surging wave body tone.
  final Color midWaveColor;

  /// Wave crest foam and spray color.
  final Color foamColor;

  /// Metallic gold accent line color.
  final Color goldAccentColor;

  const GreatWavePainter({
    this.skyColor = const Color(0xFF0B111A),
    this.deepSeaColor = const Color(0xFF13243D),
    this.midWaveColor = const Color(0xFF1D4A77),
    this.foamColor = const Color(0xFFF1F5F9),
    this.goldAccentColor = const Color(0xFFD4AF37),
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final rect = Offset.zero & size;
    final w = size.width;
    final h = size.height;

    // 1. Atmosphere / Sky Background
    final skyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          skyColor,
          Color.lerp(skyColor, deepSeaColor, 0.4)!,
        ],
      ).createShader(rect);

    canvas.drawRect(rect, skyPaint);

    // 2. Wave Layer 1: Background Swell (Deep oceanic body)
    final swell1 = Path()
      ..moveTo(0, h * 0.76)
      ..cubicTo(w * 0.35, h * 0.72, w * 0.65, h * 0.82, w, h * 0.68)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    canvas.drawPath(
      swell1,
      Paint()..color = deepSeaColor,
    );

    // 3. Wave Layer 2: Mid Swell with Dynamic Rising Wave
    final swell2 = Path()
      ..moveTo(0, h * 0.60)
      ..cubicTo(w * 0.25, h * 0.54, w * 0.50, h * 0.68, w * 0.75, h * 0.52)
      ..cubicTo(w * 0.88, h * 0.42, w * 0.95, h * 0.48, w, h * 0.46)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    canvas.drawPath(
      swell2,
      Paint()..color = midWaveColor,
    );

    // 4. Wave Layer 3: The Great Rising Wave (Surging from right over to the left)
    final mainWave = Path()
      ..moveTo(w, h * 0.78)
      ..cubicTo(w * 0.80, h * 0.70, w * 0.60, h * 0.45, w * 0.40, h * 0.38)
      // Great curl hooking over towards left
      ..cubicTo(w * 0.22, h * 0.32, w * 0.15, h * 0.40, w * 0.18, h * 0.46)
      ..cubicTo(w * 0.24, h * 0.50, w * 0.35, h * 0.48, w * 0.32, h * 0.55)
      // Base slope to bottom left
      ..cubicTo(w * 0.28, h * 0.65, w * 0.15, h * 0.78, 0, h * 0.82)
      ..lineTo(0, h)
      ..lineTo(w, h)
      ..close();

    canvas.drawPath(
      mainWave,
      Paint()..color = deepSeaColor.withOpacity(0.95),
    );

    // 5. Stylized Foam Crests & Claw Sprays (Hokusai finger curls)
    final foamPaint = Paint()
      ..color = foamColor.withOpacity(0.90)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;

    final foamFill = Paint()
      ..color = foamColor.withOpacity(0.85)
      ..style = PaintingStyle.fill;

    // Curl peak crest
    final curlCrest = Path()
      ..moveTo(w * 0.42, h * 0.37)
      ..cubicTo(w * 0.22, h * 0.31, w * 0.14, h * 0.39, w * 0.18, h * 0.46);
    canvas.drawPath(curlCrest, foamPaint);

    // Wave foam finger hooks
    void drawFoamFinger(Offset start, Offset control, Offset end) {
      final finger = Path()
        ..moveTo(start.dx, start.dy)
        ..quadraticBezierTo(control.dx, control.dy, end.dx, end.dy);
      canvas.drawPath(finger, foamPaint);
    }

    drawFoamFinger(
      Offset(w * 0.18, h * 0.46),
      Offset(w * 0.14, h * 0.44),
      Offset(w * 0.12, h * 0.48),
    );
    drawFoamFinger(
      Offset(w * 0.22, h * 0.33),
      Offset(w * 0.18, h * 0.28),
      Offset(w * 0.14, h * 0.32),
    );
    drawFoamFinger(
      Offset(w * 0.30, h * 0.34),
      Offset(w * 0.26, h * 0.29),
      Offset(w * 0.22, h * 0.31),
    );

    // Secondary mid-wave foam fringe
    final midFoam = Path()
      ..moveTo(w * 0.50, h * 0.68)
      ..cubicTo(w * 0.65, h * 0.58, w * 0.78, h * 0.50, w * 0.88, h * 0.43);
    canvas.drawPath(
      midFoam,
      Paint()
        ..color = foamColor.withOpacity(0.65)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6,
    );

    // 6. Flying Sea Spray Particle Dots
    final sprayDots = [
      Offset(w * 0.10, h * 0.42),
      Offset(w * 0.13, h * 0.38),
      Offset(w * 0.16, h * 0.29),
      Offset(w * 0.20, h * 0.26),
      Offset(w * 0.25, h * 0.24),
      Offset(w * 0.28, h * 0.28),
      Offset(w * 0.08, h * 0.47),
      Offset(w * 0.34, h * 0.32),
    ];

    for (final dot in sprayDots) {
      canvas.drawCircle(dot, 1.8, foamFill);
    }

    // 7. Gold Metallic Swell Flow Lines
    final goldLinePaint = Paint()
      ..color = goldAccentColor.withOpacity(0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    final goldPath1 = Path()
      ..moveTo(w * 0.88, h * 0.72)
      ..cubicTo(w * 0.70, h * 0.55, w * 0.52, h * 0.46, w * 0.36, h * 0.44);
    canvas.drawPath(goldPath1, goldLinePaint);

    final goldPath2 = Path()
      ..moveTo(w * 0.78, h * 0.78)
      ..cubicTo(w * 0.62, h * 0.64, w * 0.48, h * 0.58, w * 0.34, h * 0.58);
    canvas.drawPath(goldPath2, goldLinePaint);

    final goldPath3 = Path()
      ..moveTo(w * 0.65, h * 0.85)
      ..cubicTo(w * 0.50, h * 0.75, w * 0.38, h * 0.72, w * 0.24, h * 0.74);
    canvas.drawPath(goldPath3, goldLinePaint);
  }

  @override
  bool shouldRepaint(covariant GreatWavePainter oldDelegate) =>
      oldDelegate.skyColor != skyColor ||
      oldDelegate.deepSeaColor != deepSeaColor ||
      oldDelegate.midWaveColor != midWaveColor ||
      oldDelegate.foamColor != foamColor ||
      oldDelegate.goldAccentColor != goldAccentColor;
}
