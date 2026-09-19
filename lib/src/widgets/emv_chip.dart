import 'package:flutter/material.dart';
import '../models/card_theme.dart';

/// A realistic, resolution-independent EMV Smart Card Chip drawn with vector paths.
class EmvChip extends StatelessWidget {
  final double width;
  final double height;
  final ChipColor chipColor;

  const EmvChip({
    super.key,
    this.width = 38.0,
    this.height = 30.0,
    this.chipColor = ChipColor.gold,
  });

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors;
    Color trackColor;

    switch (chipColor) {
      case ChipColor.silver:
        gradientColors = const [
          Color(0xFFE2E4E8),
          Color(0xFFC0C4CB),
          Color(0xFFA5AAB3),
          Color(0xFFD4D7DC),
        ];
        trackColor = const Color(0xFF7A808C).withValues(alpha: 0.5);
        break;

      case ChipColor.black:
        gradientColors = const [
          Color(0xFF333538),
          Color(0xFF1E2022),
          Color(0xFF121314),
          Color(0xFF282A2D),
        ];
        trackColor = Colors.white.withValues(alpha: 0.2);
        break;

      case ChipColor.gold:
        gradientColors = const [
          Color(0xFFFFE082),
          Color(0xFFFFCA28),
          Color(0xFFFFA000),
          Color(0xFFFFD54F),
        ];
        trackColor = const Color(0xFF795548).withValues(alpha: 0.4);
        break;
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: CustomPaint(
        painter: _ChipLinesPainter(trackColor: trackColor),
      ),
    );
  }
}

class _ChipLinesPainter extends CustomPainter {
  final Color trackColor;

  _ChipLinesPainter({required this.trackColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = trackColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final w = size.width;
    final h = size.height;

    // Outer chip perimeter line
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(1, 1, w - 2, h - 2),
      const Radius.circular(4),
    );
    canvas.drawRRect(rrect, paint);

    // Horizontal division line
    canvas.drawLine(Offset(0, h * 0.5), Offset(w, h * 0.5), paint);

    // Left contact track
    canvas.drawLine(Offset(w * 0.35, 0), Offset(w * 0.35, h * 0.35), paint);
    canvas.drawLine(Offset(w * 0.35, h * 0.35), Offset(0, h * 0.35), paint);

    canvas.drawLine(Offset(w * 0.35, h), Offset(w * 0.35, h * 0.65), paint);
    canvas.drawLine(Offset(w * 0.35, h * 0.65), Offset(0, h * 0.65), paint);

    // Right contact track
    canvas.drawLine(Offset(w * 0.65, 0), Offset(w * 0.65, h * 0.35), paint);
    canvas.drawLine(Offset(w * 0.65, h * 0.35), Offset(w, h * 0.35), paint);

    canvas.drawLine(Offset(w * 0.65, h), Offset(w * 0.65, h * 0.65), paint);
    canvas.drawLine(Offset(w * 0.65, h * 0.65), Offset(0, h * 0.65), paint);

    // Center circular contact
    final centerCircle = Rect.fromCenter(
      center: Offset(w * 0.5, h * 0.5),
      width: w * 0.3,
      height: h * 0.36,
    );
    canvas.drawOval(centerCircle, paint);
  }

  @override
  bool shouldRepaint(covariant _ChipLinesPainter oldDelegate) =>
      oldDelegate.trackColor != trackColor;
}
