import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Contactless payment indicator icon drawn with native vector curves.
class ContactlessIcon extends StatelessWidget {
  final double size;
  final Color color;

  const ContactlessIcon({
    super.key,
    this.size = 20.0,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ContactlessPainter(color: color),
    );
  }
}

class _ContactlessPainter extends CustomPainter {
  final Color color;

  _ContactlessPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width * 0.09
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width * 0.1, size.height * 0.5);

    // Draw 4 curved arcs radiating towards the right
    final radii = [
      size.width * 0.32,
      size.width * 0.52,
      size.width * 0.72,
      size.width * 0.92,
    ];

    const startAngle = -math.pi / 4;
    const sweepAngle = math.pi / 2;

    for (final r in radii) {
      final rect = Rect.fromCircle(center: center, radius: r);
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ContactlessPainter oldDelegate) =>
      oldDelegate.color != color;
}
