import 'package:flutter/material.dart';

/// Renders flowing vertical chromatic neon silk ribbons with vibrant
/// magenta, cyan, and purple waves, glossy highlight crests, and deep obsidian depth.
class ChromaticRibbonsPainter extends CustomPainter {
  /// Base deep dark background color.
  final Color backgroundColor;

  /// Primary hot magenta neon color.
  final Color magenta;

  /// Secondary electric cyan neon color.
  final Color cyan;

  /// Deep electric violet / purple color.
  final Color violet;

  const ChromaticRibbonsPainter({
    this.backgroundColor = const Color(0xFF07040F),
    this.magenta = const Color(0xFFFF007A),
    this.cyan = const Color(0xFF00E5FF),
    this.violet = const Color(0xFF7928CA),
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final rect = Offset.zero & size;
    final w = size.width;
    final h = size.height;

    // 1. Base dark obsidian void
    final bgPaint = Paint()..color = backgroundColor;
    canvas.drawRect(rect, bgPaint);

    // 2. Ambient background glow pools
    final ambientPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, 0.2),
        radius: 0.9,
        colors: [
          magenta.withValues(alpha: 0.25),
          violet.withValues(alpha: 0.15),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(rect);
    canvas.drawRect(rect, ambientPaint);

    // 3. Draw Undulating Ribbon 1 (Deep Violet base wave)
    _drawRibbon(
      canvas: canvas,
      size: size,
      startOffset: Offset(w * 0.15, 0),
      ctrl1: Offset(w * -0.05, h * 0.28),
      ctrl2: Offset(w * 0.45, h * 0.65),
      endOffset: Offset(w * 0.20, h),
      width: w * 0.45,
      gradientColors: [
        violet.withValues(alpha: 0.85),
        const Color(0xFF4A00E0).withValues(alpha: 0.70),
        violet.withValues(alpha: 0.0),
      ],
      glowColor: violet,
    );

    // 4. Draw Undulating Ribbon 2 (Hot Magenta central wave)
    _drawRibbon(
      canvas: canvas,
      size: size,
      startOffset: Offset(w * 0.42, 0),
      ctrl1: Offset(w * 0.15, h * 0.32),
      ctrl2: Offset(w * 0.72, h * 0.62),
      endOffset: Offset(w * 0.38, h),
      width: w * 0.36,
      gradientColors: [
        magenta.withValues(alpha: 0.90),
        const Color(0xFFFF2E93).withValues(alpha: 0.75),
        magenta.withValues(alpha: 0.0),
      ],
      glowColor: magenta,
    );

    // 5. Draw Undulating Ribbon 3 (Electric Cyan foreground highlights)
    _drawRibbon(
      canvas: canvas,
      size: size,
      startOffset: Offset(w * 0.68, 0),
      ctrl1: Offset(w * 0.35, h * 0.35),
      ctrl2: Offset(w * 0.92, h * 0.68),
      endOffset: Offset(w * 0.55, h),
      width: w * 0.28,
      gradientColors: [
        cyan.withValues(alpha: 0.95),
        const Color(0xFF70F3FF).withValues(alpha: 0.80),
        cyan.withValues(alpha: 0.0),
      ],
      glowColor: cyan,
    );

    // 6. Specular Silk Crest Highlights (Thin white/cyan razor glow lines along crests)
    final crestPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 1.2);

    final crest1 = Path()
      ..moveTo(w * 0.42, 0)
      ..cubicTo(w * 0.15, h * 0.32, w * 0.72, h * 0.62, w * 0.38, h);
    canvas.drawPath(crest1, crestPaint);

    final crest2 = Path()
      ..moveTo(w * 0.68, 0)
      ..cubicTo(w * 0.35, h * 0.35, w * 0.92, h * 0.68, w * 0.55, h);
    canvas.drawPath(crest2, crestPaint);
  }

  void _drawRibbon({
    required Canvas canvas,
    required Size size,
    required Offset startOffset,
    required Offset ctrl1,
    required Offset ctrl2,
    required Offset endOffset,
    required double width,
    required List<Color> gradientColors,
    required Color glowColor,
  }) {
    final path = Path()
      ..moveTo(startOffset.dx - width * 0.5, startOffset.dy)
      ..cubicTo(
        ctrl1.dx - width * 0.5,
        ctrl1.dy,
        ctrl2.dx - width * 0.5,
        ctrl2.dy,
        endOffset.dx - width * 0.5,
        endOffset.dy,
      )
      ..lineTo(endOffset.dx + width * 0.5, endOffset.dy)
      ..cubicTo(
        ctrl2.dx + width * 0.5,
        ctrl2.dy,
        ctrl1.dx + width * 0.5,
        ctrl1.dy,
        startOffset.dx + width * 0.5,
        startOffset.dy,
      )
      ..close();

    // Outer soft atmospheric glow
    final glowPaint = Paint()
      ..color = glowColor.withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);
    canvas.drawPath(path, glowPaint);

    // Core ribbon gradient
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: gradientColors,
      ).createShader(Offset.zero & size);
    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant ChromaticRibbonsPainter oldDelegate) =>
      oldDelegate.backgroundColor != backgroundColor ||
      oldDelegate.magenta != magenta ||
      oldDelegate.cyan != cyan ||
      oldDelegate.violet != violet;
}
