import 'package:flutter/material.dart';

/// Renders a minimalist layered alpine mountain horizon with twilight sky,
/// faceted 3D ridges, and metallic snow-capped highlights.
class AlpineHorizonPainter extends CustomPainter {
  /// Sky gradient top color.
  final Color skyTop;

  /// Sky gradient bottom color.
  final Color skyBottom;

  /// Distant background mountain silhouette color.
  final Color distantMountainColor;

  /// Mid-range mountain facet color.
  final Color midMountainColor;

  /// Foreground mountain silhouette color.
  final Color foregroundMountainColor;

  /// Specular metallic ridge and snow highlight color.
  final Color ridgeHighlightColor;

  /// Sun or moon disk color.
  final Color sunMoonColor;

  /// Whether to render the celestial sun/moon disk.
  final bool showSunMoon;

  const AlpineHorizonPainter({
    this.skyTop = const Color(0xFF0B1320),
    this.skyBottom = const Color(0xFF1C2A3A),
    this.distantMountainColor = const Color(0xFF1F3146),
    this.midMountainColor = const Color(0xFF162333),
    this.foregroundMountainColor = const Color(0xFF0D1520),
    this.ridgeHighlightColor = const Color(0xFFD4AF37),
    this.sunMoonColor = const Color(0xFFF9A825),
    this.showSunMoon = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final rect = Offset.zero & size;
    final w = size.width;
    final h = size.height;

    // 1. Sky Gradient
    final skyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [skyTop, skyBottom],
        stops: const [0.0, 0.75],
      ).createShader(rect);

    canvas.drawRect(rect, skyPaint);

    // 2. Celestial Sun / Moon Disk with Soft Halo
    if (showSunMoon) {
      final sunCenter = Offset(w * 0.72, h * 0.24);
      final sunRadius = w * 0.09;

      // Halo glow
      final haloPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            sunMoonColor.withOpacity(0.35),
            sunMoonColor.withOpacity(0.0),
          ],
        ).createShader(
            Rect.fromCircle(center: sunCenter, radius: sunRadius * 2.2));
      canvas.drawCircle(sunCenter, sunRadius * 2.2, haloPaint);

      // Core disk
      final sunPaint = Paint()..color = sunMoonColor.withOpacity(0.85);
      canvas.drawCircle(sunCenter, sunRadius, sunPaint);
    }

    // 3. Layer 1: Distant Mountain Range (Soft hazy peaks)
    final distantPath = Path()
      ..moveTo(0, h * 0.58)
      ..lineTo(w * 0.15, h * 0.44)
      ..lineTo(w * 0.32, h * 0.50)
      ..lineTo(w * 0.52, h * 0.38)
      ..lineTo(w * 0.70, h * 0.46)
      ..lineTo(w * 0.88, h * 0.36)
      ..lineTo(w, h * 0.42)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    canvas.drawPath(
      distantPath,
      Paint()..color = distantMountainColor.withOpacity(0.70),
    );

    // 4. Layer 2: Mid-range Faceted Peaks with Directional Shading
    // Left Lit Facet
    final midLeftFacet = Path()
      ..moveTo(0, h * 0.68)
      ..lineTo(w * 0.28, h * 0.48)
      ..lineTo(w * 0.40, h * 0.62)
      ..lineTo(w * 0.28, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(
      midLeftFacet,
      Paint()..color = midMountainColor.withOpacity(0.90),
    );

    // Main Central Peak (Left facet)
    final centerPeakLeft = Path()
      ..moveTo(w * 0.28, h * 0.48)
      ..lineTo(w * 0.46, h * 0.41)
      ..lineTo(w * 0.46, h)
      ..lineTo(w * 0.28, h)
      ..close();
    canvas.drawPath(
      centerPeakLeft,
      Paint()..color = midMountainColor,
    );

    // Main Central Peak (Right shaded facet)
    final centerPeakRight = Path()
      ..moveTo(w * 0.46, h * 0.41)
      ..lineTo(w * 0.74, h * 0.56)
      ..lineTo(w * 0.74, h)
      ..lineTo(w * 0.46, h)
      ..close();
    canvas.drawPath(
      centerPeakRight,
      Paint()..color = foregroundMountainColor.withOpacity(0.85),
    );

    // 5. Layer 3: Dramatic Foreground Ridges
    final fgPath = Path()
      ..moveTo(0, h * 0.72)
      ..lineTo(w * 0.22, h * 0.62)
      ..lineTo(w * 0.55, h * 0.74)
      ..lineTo(w * 0.82, h * 0.55)
      ..lineTo(w, h * 0.64)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    canvas.drawPath(fgPath, Paint()..color = foregroundMountainColor);

    // 6. Metallic Ridge & Snow Contour Highlights
    final ridgePaint = Paint()
      ..color = ridgeHighlightColor.withOpacity(0.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Center peak spine
    final spinePath1 = Path()
      ..moveTo(w * 0.46, h * 0.41)
      ..lineTo(w * 0.46, h * 0.68)
      ..lineTo(w * 0.38, h * 0.78);
    canvas.drawPath(spinePath1, ridgePaint);

    // Crest crest highlights
    final crestPath = Path()
      ..moveTo(w * 0.28, h * 0.48)
      ..lineTo(w * 0.46, h * 0.41)
      ..lineTo(w * 0.74, h * 0.56);
    canvas.drawPath(crestPath, ridgePaint);

    final fgRidgePath = Path()
      ..moveTo(0, h * 0.72)
      ..lineTo(w * 0.22, h * 0.62)
      ..lineTo(w * 0.55, h * 0.74)
      ..lineTo(w * 0.82, h * 0.55)
      ..lineTo(w, h * 0.64);
    canvas.drawPath(
      fgRidgePath,
      Paint()
        ..color = ridgeHighlightColor.withOpacity(0.40)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // 7. Base Fog / Mist Gradient
    final mistPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          foregroundMountainColor,
          foregroundMountainColor.withOpacity(0.0),
        ],
        stops: const [0.0, 0.45],
      ).createShader(rect);

    canvas.drawRect(rect, mistPaint);
  }

  @override
  bool shouldRepaint(covariant AlpineHorizonPainter oldDelegate) =>
      oldDelegate.skyTop != skyTop ||
      oldDelegate.skyBottom != skyBottom ||
      oldDelegate.distantMountainColor != distantMountainColor ||
      oldDelegate.midMountainColor != midMountainColor ||
      oldDelegate.foregroundMountainColor != foregroundMountainColor ||
      oldDelegate.ridgeHighlightColor != ridgeHighlightColor ||
      oldDelegate.sunMoonColor != sunMoonColor ||
      oldDelegate.showSunMoon != showSunMoon;
}
