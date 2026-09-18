import 'package:flutter/material.dart';

/// A realistic, resolution-independent EMV Smart Card Chip drawn with vector paths.
class EmvChip extends StatelessWidget {
  final double width;
  final double height;
  final bool isSilver;

  const EmvChip({
    super.key,
    this.width = 38.0,
    this.height = 30.0,
    this.isSilver = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isSilver
              ? [
                  const Color(0xFFE2E4E8),
                  const Color(0xFFC0C4CB),
                  const Color(0xFFA5AAB3),
                  const Color(0xFFD4D7DC),
                ]
              : [
                  const Color(0xFFFFE082),
                  const Color(0xFFFFCA28),
                  const Color(0xFFFFA000),
                  const Color(0xFFFFD54F),
                ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: CustomPaint(
        painter: _ChipLinesPainter(isSilver: isSilver),
      ),
    );
  }
}

class _ChipLinesPainter extends CustomPainter {
  final bool isSilver;

  _ChipLinesPainter({required this.isSilver});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isSilver
          ? const Color(0xFF7A808C).withOpacity(0.5)
          : const Color(0xFF795548).withOpacity(0.4)
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
    canvas.drawLine(Offset(w * 0.65, h * 0.65), Offset(w, h * 0.65), paint);

    // Center circular contact
    final centerCircle = Rect.fromCenter(
      center: Offset(w * 0.5, h * 0.5),
      width: w * 0.3,
      height: h * 0.36,
    );
    canvas.drawOval(centerCircle, paint);
  }

  @override
  bool shouldRepaint(covariant _ChipLinesPainter oldDelegate) => false;
}
