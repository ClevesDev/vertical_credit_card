import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Renders a crystalline frost and ice crack texture for frozen cards.
class FrostOverlayPainter extends CustomPainter {
  final double animationValue;

  FrostOverlayPainter({this.animationValue = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Cold translucent frosty mist
    final frostMist = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.0, -0.2),
        radius: 0.9,
        colors: [
          const Color(0xC0C7E5F9), // Ice blue
          const Color(0x908AC4EC),
          const Color(0x604E9BCF),
          const Color(0x30184E77),
        ],
        stops: const [0.0, 0.45, 0.75, 1.0],
      ).createShader(rect);

    canvas.drawRect(rect, frostMist);

    // Subtle crystalline crack lines
    final iceCrackPaint = Paint()
      ..color = Colors.white.withOpacity(0.35 * animationValue)
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final w = size.width;
    final h = size.height;

    // Top-left ice crystals
    final path1 = Path()
      ..moveTo(0, h * 0.15)
      ..lineTo(w * 0.22, h * 0.19)
      ..lineTo(w * 0.35, h * 0.12)
      ..moveTo(w * 0.22, h * 0.19)
      ..lineTo(w * 0.28, h * 0.28);
    canvas.drawPath(path1, iceCrackPaint);

    // Bottom-right frost branching
    final path2 = Path()
      ..moveTo(w, h * 0.82)
      ..lineTo(w * 0.76, h * 0.78)
      ..lineTo(w * 0.62, h * 0.85)
      ..moveTo(w * 0.76, h * 0.78)
      ..lineTo(w * 0.71, h * 0.69);
    canvas.drawPath(path2, iceCrackPaint);

    // Scattered micro frost sparkles
    final sparklePaint = Paint()..color = Colors.white.withOpacity(0.5);
    final random = math.Random(42); // Deterministic seed
    for (int i = 0; i < 24; i++) {
      final x = random.nextDouble() * w;
      final y = random.nextDouble() * h;
      final radius = random.nextDouble() * 1.5 + 0.5;
      canvas.drawCircle(Offset(x, y), radius, sparklePaint);
    }
  }

  @override
  bool shouldRepaint(covariant FrostOverlayPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
