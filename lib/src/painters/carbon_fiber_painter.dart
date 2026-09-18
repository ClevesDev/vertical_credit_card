import 'package:flutter/material.dart';

/// Renders a realistic 45-degree twill-weave carbon fiber texture (Family D: Art & Textures).
class CarbonFiberPainter extends CustomPainter {
  final double cellSize;

  const CarbonFiberPainter({this.cellSize = 8.0});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Base deep obsidian dark background
    canvas.drawRect(
      rect,
      Paint()..color = const Color(0xFF101113),
    );

    final w = size.width;
    final h = size.height;

    final cell = cellSize;
    final half = cell / 2;

    final darkPaint = Paint()..color = const Color(0xFF181A1E);
    final lightPaint = Paint()..color = const Color(0xFF262930);
    final highlightPaint = Paint()..color = const Color(0xFF333742);

    for (double y = 0; y < h + cell; y += cell) {
      for (double x = 0; x < w + cell; x += cell) {
        final isEvenRow = ((y / cell).round() % 2 == 0);
        final isEvenCol = ((x / cell).round() % 2 == 0);

        if ((isEvenRow && isEvenCol) || (!isEvenRow && !isEvenCol)) {
          // Horizontal fiber thread
          final path = Path()
            ..moveTo(x, y)
            ..lineTo(x + half, y - half)
            ..lineTo(x + cell, y)
            ..lineTo(x + half, y + half)
            ..close();
          canvas.drawPath(path, lightPaint);
        } else {
          // Vertical fiber thread
          final path = Path()
            ..moveTo(x, y)
            ..lineTo(x - half, y + half)
            ..lineTo(x, y + cell)
            ..lineTo(x + half, y + half)
            ..close();
          canvas.drawPath(path, darkPaint);
        }

        // Micro weave specular highlight
        if (isEvenRow && !isEvenCol) {
          canvas.drawCircle(Offset(x, y), 0.7, highlightPaint);
        }
      }
    }

    // Subtle dark vignette to enhance depth
    final vignette = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 0.85,
        colors: [
          Colors.transparent,
          Colors.black.withOpacity(0.55),
        ],
        stops: const [0.55, 1.0],
      ).createShader(rect);

    canvas.drawRect(rect, vignette);
  }

  @override
  bool shouldRepaint(covariant CarbonFiberPainter oldDelegate) =>
      oldDelegate.cellSize != cellSize;
}
