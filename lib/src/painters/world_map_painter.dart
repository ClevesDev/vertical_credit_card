import 'package:flutter/material.dart';

/// Renders a luxury world navigator map with stylized vector continents,
/// geodesic global flight route arcs, and navigational coordinate lines.
class WorldMapPainter extends CustomPainter {
  /// Base ocean / background color.
  final Color oceanColor;

  /// Landmass continent silhouette color.
  final Color continentColor;

  /// Geodesic flight route arc line color.
  final Color flightRouteColor;

  /// Latitude/longitude and compass grid line color.
  final Color gridColor;

  /// Whether to render geodesic intercontinental flight paths.
  final bool showFlightRoutes;

  /// Whether to render coordinate grid lines.
  final bool showGrid;

  const WorldMapPainter({
    this.oceanColor = const Color(0xFF090E17),
    this.continentColor = const Color(0xFF1D2836),
    this.flightRouteColor = const Color(0xFF00E5FF),
    this.gridColor = const Color(0xFF151E28),
    this.showFlightRoutes = true,
    this.showGrid = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final rect = Offset.zero & size;
    final w = size.width;
    final h = size.height;

    // 1. Deep Ocean Radial Background
    final bgPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 0.9,
        colors: [
          Color.lerp(oceanColor, const Color(0xFF142030), 0.3)!,
          oceanColor,
        ],
      ).createShader(rect);

    canvas.drawRect(rect, bgPaint);

    // 2. Coordinate Grid (Parallels & Meridians)
    if (showGrid) {
      final gridPaint = Paint()
        ..color = gridColor.withOpacity(0.40)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8;

      // Parallels (Horizontals)
      for (double y = h * 0.2; y <= h * 0.8; y += h * 0.15) {
        canvas.drawLine(Offset(0, y), Offset(w, y), gridPaint);
      }

      // Meridians (Curved ellipses)
      for (double factor in [0.25, 0.50, 0.75]) {
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(w * 0.5, h * 0.5),
            width: w * factor * 2,
            height: h * 0.7,
          ),
          gridPaint,
        );
      }
    }

    // 3. Stylized Vector Continents Map (Positioned cleanly across the vertical card)
    final landPaint = Paint()
      ..color = continentColor
      ..style = PaintingStyle.fill;

    final landBorderPaint = Paint()
      ..color = flightRouteColor.withOpacity(0.20)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    void drawLandmass(Path path) {
      canvas.drawPath(path, landPaint);
      canvas.drawPath(path, landBorderPaint);
    }

    // North America
    final northAmerica = Path()
      ..moveTo(w * 0.10, h * 0.28)
      ..lineTo(w * 0.32, h * 0.26)
      ..lineTo(w * 0.40, h * 0.32)
      ..lineTo(w * 0.35, h * 0.40)
      ..lineTo(w * 0.25, h * 0.45)
      ..lineTo(w * 0.20, h * 0.42)
      ..lineTo(w * 0.12, h * 0.35)
      ..close();
    drawLandmass(northAmerica);

    // South America
    final southAmerica = Path()
      ..moveTo(w * 0.24, h * 0.47)
      ..lineTo(w * 0.36, h * 0.49)
      ..lineTo(w * 0.38, h * 0.58)
      ..lineTo(w * 0.30, h * 0.68)
      ..lineTo(w * 0.26, h * 0.62)
      ..lineTo(w * 0.22, h * 0.52)
      ..close();
    drawLandmass(southAmerica);

    // Europe
    final europe = Path()
      ..moveTo(w * 0.45, h * 0.28)
      ..lineTo(w * 0.58, h * 0.26)
      ..lineTo(w * 0.56, h * 0.35)
      ..lineTo(w * 0.46, h * 0.36)
      ..close();
    drawLandmass(europe);

    // Africa
    final africa = Path()
      ..moveTo(w * 0.45, h * 0.38)
      ..lineTo(w * 0.62, h * 0.38)
      ..lineTo(w * 0.60, h * 0.54)
      ..lineTo(w * 0.52, h * 0.62)
      ..lineTo(w * 0.46, h * 0.52)
      ..close();
    drawLandmass(africa);

    // Asia
    final asia = Path()
      ..moveTo(w * 0.59, h * 0.24)
      ..lineTo(w * 0.88, h * 0.26)
      ..lineTo(w * 0.86, h * 0.40)
      ..lineTo(w * 0.74, h * 0.44)
      ..lineTo(w * 0.64, h * 0.38)
      ..lineTo(w * 0.58, h * 0.30)
      ..close();
    drawLandmass(asia);

    // Australia / Oceania
    final oceania = Path()
      ..moveTo(w * 0.76, h * 0.56)
      ..lineTo(w * 0.88, h * 0.56)
      ..lineTo(w * 0.86, h * 0.65)
      ..lineTo(w * 0.75, h * 0.64)
      ..close();
    drawLandmass(oceania);

    // 4. Geodesic Flight Route Arcs & Global Hub Nodes
    if (showFlightRoutes) {
      final routePaint = Paint()
        ..color = flightRouteColor.withOpacity(0.70)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..strokeCap = StrokeCap.round;

      // Hub locations
      final newYork = Offset(w * 0.30, h * 0.34);
      final london = Offset(w * 0.49, h * 0.30);
      final tokyo = Offset(w * 0.82, h * 0.34);
      final saoPaulo = Offset(w * 0.32, h * 0.56);
      final dubai = Offset(w * 0.62, h * 0.36);
      final sydney = Offset(w * 0.82, h * 0.61);

      void drawGeodesicArc(Offset from, Offset to, double curveHeight) {
        final mid = Offset(
          (from.dx + to.dx) / 2,
          (from.dy + to.dy) / 2 - curveHeight,
        );
        final path = Path()
          ..moveTo(from.dx, from.dy)
          ..quadraticBezierTo(mid.dx, mid.dy, to.dx, to.dy);
        canvas.drawPath(path, routePaint);
      }

      // Route 1: New York -> London
      drawGeodesicArc(newYork, london, 16.0);

      // Route 2: London -> Dubai
      drawGeodesicArc(london, dubai, 12.0);

      // Route 3: Dubai -> Tokyo
      drawGeodesicArc(dubai, tokyo, 18.0);

      // Route 4: São Paulo -> London
      drawGeodesicArc(saoPaulo, london, 22.0);

      // Route 5: Tokyo -> Sydney
      drawGeodesicArc(tokyo, sydney, 14.0);

      // Global Hub Nodes
      final hubOuterPaint = Paint()
        ..color = flightRouteColor.withOpacity(0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      final hubCorePaint = Paint()
        ..color = flightRouteColor
        ..style = PaintingStyle.fill;

      for (final hub in [newYork, london, tokyo, saoPaulo, dubai, sydney]) {
        canvas.drawCircle(hub, 4.0, hubOuterPaint);
        canvas.drawCircle(hub, 1.8, hubCorePaint);
      }
    }

    // 5. Minimalist Compass Crosshair Accent (Top right corner)
    final compassCenter = Offset(w * 0.85, h * 0.16);
    const compassR = 14.0;
    final compassPaint = Paint()
      ..color = flightRouteColor.withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    canvas.drawCircle(compassCenter, compassR, compassPaint);
    canvas.drawLine(
      Offset(compassCenter.dx, compassCenter.dy - compassR - 3),
      Offset(compassCenter.dx, compassCenter.dy + compassR + 3),
      compassPaint,
    );
    canvas.drawLine(
      Offset(compassCenter.dx - compassR - 3, compassCenter.dy),
      Offset(compassCenter.dx + compassR + 3, compassCenter.dy),
      compassPaint,
    );

    // North marker tick
    final northTick = Path()
      ..moveTo(compassCenter.dx, compassCenter.dy - compassR - 2)
      ..lineTo(compassCenter.dx - 2.5, compassCenter.dy - compassR + 4)
      ..lineTo(compassCenter.dx + 2.5, compassCenter.dy - compassR + 4)
      ..close();
    canvas.drawPath(northTick, Paint()..color = flightRouteColor);
  }

  @override
  bool shouldRepaint(covariant WorldMapPainter oldDelegate) =>
      oldDelegate.oceanColor != oceanColor ||
      oldDelegate.continentColor != continentColor ||
      oldDelegate.flightRouteColor != flightRouteColor ||
      oldDelegate.gridColor != gridColor ||
      oldDelegate.showFlightRoutes != showFlightRoutes ||
      oldDelegate.showGrid != showGrid;
}
