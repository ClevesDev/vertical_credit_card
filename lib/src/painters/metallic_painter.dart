import 'package:flutter/material.dart';
import '../models/card_theme.dart';

/// Renders a realistic brushed metallic gradient with specular light reflections.
class MetallicCardPainter extends CustomPainter {
  final MetalType metalType;

  MetallicCardPainter({required this.metalType});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    List<Color> baseColors;
    List<double> stops;

    switch (metalType) {
      case MetalType.brushedTitanium:
        baseColors = const [
          Color(0xFF2A2D32),
          Color(0xFF3F444D),
          Color(0xFF282B30),
          Color(0xFF555B66),
          Color(0xFF2E3136),
          Color(0xFF484E59),
          Color(0xFF1E2024),
        ];
        stops = const [0.0, 0.18, 0.35, 0.52, 0.70, 0.88, 1.0];
        break;

      case MetalType.gold:
        baseColors = const [
          Color(0xFF795516),
          Color(0xFFC59E47),
          Color(0xFFE5C878),
          Color(0xFF996B1F),
          Color(0xFFF3DE9A),
          Color(0xFFB3872F),
          Color(0xFF6B470F),
        ];
        stops = const [0.0, 0.15, 0.32, 0.50, 0.68, 0.85, 1.0];
        break;

      case MetalType.silver:
        baseColors = const [
          Color(0xFF8E949E),
          Color(0xFFD3D7DF),
          Color(0xFFF2F4F8),
          Color(0xFFAEB4BF),
          Color(0xFFE8EBF0),
          Color(0xFF9BA0AA),
          Color(0xFF757A84),
        ];
        stops = const [0.0, 0.16, 0.34, 0.52, 0.70, 0.86, 1.0];
        break;

      case MetalType.obsidian:
        baseColors = const [
          Color(0xFF0D0E10),
          Color(0xFF1B1C20),
          Color(0xFF0F1012),
          Color(0xFF282A30),
          Color(0xFF141518),
          Color(0xFF1F2025),
          Color(0xFF08090A),
        ];
        stops = const [0.0, 0.15, 0.33, 0.50, 0.67, 0.85, 1.0];
        break;

      case MetalType.roseGold:
        baseColors = const [
          Color(0xFF8B4D4F),
          Color(0xFFD68B8D),
          Color(0xFFF7C3C4),
          Color(0xFFB56769),
          Color(0xFFEBB1B3),
          Color(0xFF9E5456),
          Color(0xFF6B3335),
        ];
        stops = const [0.0, 0.15, 0.32, 0.50, 0.68, 0.85, 1.0];
        break;
    }

    // Diagonal metallic sweep shader
    final paint = Paint()
      ..shader = LinearGradient(
        begin: const Alignment(-0.8, -1.0),
        end: const Alignment(0.8, 1.0),
        colors: baseColors,
        stops: stops,
      ).createShader(rect);

    canvas.drawRect(rect, paint);

    // Subtle brushed hair-lines texture
    final brushPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.025)
      ..strokeWidth = 0.5;

    for (double y = 0; y < size.height; y += 3) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y + 2), brushPaint);
    }
  }

  @override
  bool shouldRepaint(covariant MetallicCardPainter oldDelegate) =>
      oldDelegate.metalType != metalType;
}
