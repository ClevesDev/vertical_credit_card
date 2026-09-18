import 'package:flutter/material.dart';

/// Renders concentric copper NFC antenna coils and solder traces for skeleton/transparent cards.
class NfcAntennaPainter extends CustomPainter {
  /// Base copper trace color.
  final Color copperColor;

  /// Specular highlight color for copper metallic sheen.
  final Color highlightColor;

  /// Number of concentric rectangular loops.
  final int loops;

  /// Stroke width of each trace.
  final double traceWidth;

  /// Spacing between loops.
  final double loopSpacing;

  /// Corner radius of the outermost loop.
  final double cornerRadius;

  const NfcAntennaPainter({
    this.copperColor = const Color(0xFFC87533),
    this.highlightColor = const Color(0xFFFFB070),
    this.loops = 5,
    this.traceWidth = 1.4,
    this.loopSpacing = 5.0,
    this.cornerRadius = 16.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final basePaint = Paint()
      ..color = copperColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = traceWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final sheenPaint = Paint()
      ..color = highlightColor.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = traceWidth * 0.6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final padFillPaint = Paint()
      ..color = copperColor
      ..style = PaintingStyle.fill;

    final padStrokePaint = Paint()
      ..color = highlightColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const baseMargin = 16.0;

    // Draw concentric rectangular spiral antenna loops
    for (int i = 0; i < loops; i++) {
      final inset = baseMargin + (i * loopSpacing);
      final r = (cornerRadius - (i * 1.5)).clamp(4.0, cornerRadius);

      final rect = Rect.fromLTRB(
        inset,
        inset,
        size.width - inset,
        size.height - inset,
      );

      if (rect.width <= 0 || rect.height <= 0) break;

      final rrect = RRect.fromRectAndRadius(rect, Radius.circular(r));

      // Leave a tiny gap on the bottom-left of loops to simulate continuous spiral coil
      if (i < loops - 1) {
        canvas.drawRRect(rrect, basePaint);
        canvas.drawRRect(rrect, sheenPaint);
      } else {
        // Inner-most loop routes to chip terminal pads
        canvas.drawRRect(rrect, basePaint);
        canvas.drawRRect(rrect, sheenPaint);
      }
    }

    // Lead-in feed traces towards the chip zone (typical vertical card chip is at top left or center left)
    final chipAreaX = size.width * 0.22;
    final chipAreaY = size.height * 0.32;

    final innerInset = baseMargin + ((loops - 1) * loopSpacing);

    // Trace 1: From left side of coil to chip
    final feedPath1 = Path()
      ..moveTo(innerInset, chipAreaY - 12)
      ..lineTo(chipAreaX - 10, chipAreaY - 12)
      ..lineTo(chipAreaX - 10, chipAreaY - 6);
    canvas.drawPath(feedPath1, basePaint);

    // Trace 2: Return trace
    final feedPath2 = Path()
      ..moveTo(innerInset, chipAreaY + 12)
      ..lineTo(chipAreaX - 10, chipAreaY + 12)
      ..lineTo(chipAreaX - 10, chipAreaY + 6);
    canvas.drawPath(feedPath2, basePaint);

    // Solder contact points (SMD bond pads)
    final pad1 = Offset(chipAreaX - 10, chipAreaY - 6);
    final pad2 = Offset(chipAreaX - 10, chipAreaY + 6);

    canvas.drawCircle(pad1, 2.5, padFillPaint);
    canvas.drawCircle(pad1, 2.5, padStrokePaint);
    canvas.drawCircle(pad2, 2.5, padFillPaint);
    canvas.drawCircle(pad2, 2.5, padStrokePaint);

    // Micro capacitor bridge representation next to antenna input
    final capRect = Rect.fromCenter(
      center: Offset(innerInset + 14, chipAreaY),
      width: 4.5,
      height: 8.0,
    );
    canvas.drawRect(
      capRect,
      Paint()..color = const Color(0xFF4A3525),
    );
    canvas.drawRect(
      capRect,
      Paint()
        ..color = highlightColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.6,
    );
  }

  @override
  bool shouldRepaint(covariant NfcAntennaPainter oldDelegate) =>
      oldDelegate.copperColor != copperColor ||
      oldDelegate.highlightColor != highlightColor ||
      oldDelegate.loops != loops ||
      oldDelegate.traceWidth != traceWidth ||
      oldDelegate.loopSpacing != loopSpacing ||
      oldDelegate.cornerRadius != cornerRadius;
}
