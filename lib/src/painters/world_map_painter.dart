import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Renders an ultra-luxury private aviation and orbital navigation world map
/// with curved planetary limb atmosphere, high-definition vector continents,
/// bathymetric depth halos, geodesic flight arcs with supersonic delta jets,
/// glowing airport radar beacons, a 16-point 3D faceted gold compass rose,
/// and flight deck telemetry HUD.
class WorldMapPainter extends CustomPainter {
  /// Base ocean / background void color.
  final Color oceanColor;

  /// Landmass continent silhouette color.
  final Color continentColor;

  /// Flight route arc, atmosphere limb, and radar beacon color.
  final Color flightRouteColor;

  /// Latitude/longitude and coordinate grid line color.
  final Color gridColor;

  /// Primary metallic gold color for the 3D compass rose.
  final Color compassGoldColor;

  /// Specular champagne gold highlight for compass facets.
  final Color compassLightGoldColor;

  /// Whether to render geodesic intercontinental flight paths and jets.
  final bool showFlightRoutes;

  /// Whether to render coordinate grid lines.
  final bool showGrid;

  /// Whether to render the 16-point 3D faceted compass rose.
  final bool showCompass;

  /// Whether to render aviation telemetry HUD text.
  final bool showTelemetry;

  /// Whether to render the curved planetary atmosphere limb.
  final bool showAtmosphere;

  const WorldMapPainter({
    this.oceanColor = const Color(0xFF070C16),
    this.continentColor = const Color(0xFF131F33),
    this.flightRouteColor = const Color(0xFF00E5FF),
    this.gridColor = const Color(0xFF16253B),
    this.compassGoldColor = const Color(0xFFD4AF37),
    this.compassLightGoldColor = const Color(0xFFFFF0B3),
    this.showFlightRoutes = true,
    this.showGrid = true,
    this.showCompass = true,
    this.showTelemetry = true,
    this.showAtmosphere = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final rect = Offset.zero & size;
    final w = size.width;
    final h = size.height;

    // -------------------------------------------------------------------------
    // 1. Deep Oceanic Abyss & Atmospheric Radial Gradient
    // -------------------------------------------------------------------------
    final bgPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.0, -0.2),
        radius: 1.1,
        colors: [
          Color.lerp(oceanColor, const Color(0xFF0E1E34), 0.5)!,
          oceanColor,
          const Color(0xFF03060B),
        ],
        stops: const [0.0, 0.65, 1.0],
      ).createShader(rect);

    canvas.drawRect(rect, bgPaint);

    // Subtle twinkling stars in the upper orbital space
    final starPaint = Paint()..color = Colors.white;
    const starCoords = [
      Offset(0.12, 0.08),
      Offset(0.25, 0.05),
      Offset(0.42, 0.12),
      Offset(0.68, 0.06),
      Offset(0.85, 0.09),
      Offset(0.92, 0.15),
      Offset(0.18, 0.16),
      Offset(0.78, 0.18),
      Offset(0.05, 0.19),
      Offset(0.55, 0.04),
      Offset(0.34, 0.15),
      Offset(0.88, 0.03),
    ];
    for (int i = 0; i < starCoords.length; i++) {
      final pos = Offset(starCoords[i].dx * w, starCoords[i].dy * h);
      final r = (i % 3 == 0) ? 1.4 : 0.8;
      final alpha = (i % 2 == 0) ? 0.60 : 0.35;
      starPaint.color = Colors.white.withOpacity(alpha);
      canvas.drawCircle(pos, r, starPaint);
      if (i % 4 == 0) {
        // Micro starburst cross
        final flarePaint = Paint()
          ..color = flightRouteColor.withOpacity(0.40)
          ..strokeWidth = 0.5;
        canvas.drawLine(Offset(pos.dx - 2.5, pos.dy),
            Offset(pos.dx + 2.5, pos.dy), flarePaint);
        canvas.drawLine(Offset(pos.dx, pos.dy - 2.5),
            Offset(pos.dx, pos.dy + 2.5), flarePaint);
      }
    }

    // -------------------------------------------------------------------------
    // 2. Curved Planetary Limb & Glowing Horizon Atmosphere Arc
    // -------------------------------------------------------------------------
    if (showAtmosphere) {
      final horizonCenter = Offset(w * 0.5, h * 1.55);
      final horizonRadius = h * 1.32;

      // Atmospheric outer cyan haze glow
      final hazePaint = Paint()
        ..color = flightRouteColor.withOpacity(0.08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 14.0;
      canvas.drawCircle(horizonCenter, horizonRadius, hazePaint);

      // Atmospheric mid soft glow
      final midGlowPaint = Paint()
        ..color = flightRouteColor.withOpacity(0.20)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0;
      canvas.drawCircle(horizonCenter, horizonRadius, midGlowPaint);

      // Crisp planetary limb rim
      final rimPaint = Paint()
        ..color =
            Color.lerp(flightRouteColor, Colors.white, 0.5)!.withOpacity(0.65)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      canvas.drawCircle(horizonCenter, horizonRadius, rimPaint);
    }

    // -------------------------------------------------------------------------
    // 3. Coordinate Grid (Curved Meridians & Latitude Parallels)
    // -------------------------------------------------------------------------
    if (showGrid) {
      final gridPaint = Paint()
        ..color = gridColor.withOpacity(0.45)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.75;

      // Parallels
      for (double yFrac in [0.25, 0.35, 0.45, 0.55, 0.65]) {
        canvas.drawLine(Offset(0, h * yFrac), Offset(w, h * yFrac), gridPaint);
      }

      // Meridians (Curved ellipses simulating spherical projection)
      for (double factor in [0.30, 0.55, 0.80]) {
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(w * 0.5, h * 0.45),
            width: w * factor * 2.0,
            height: h * 0.50,
          ),
          gridPaint,
        );
      }
    }

    // -------------------------------------------------------------------------
    // 4. High-Definition Vector Continents with Bathymetric Coastal Halos
    // -------------------------------------------------------------------------
    final landPaint = Paint()
      ..color = continentColor
      ..style = PaintingStyle.fill;

    final coastlinePaint = Paint()
      ..color = flightRouteColor.withOpacity(0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.85;

    final bathymetryPaint = Paint()
      ..color = flightRouteColor.withOpacity(0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4;

    void drawLandmass(Path path) {
      // Bathymetric depth halo
      canvas.drawPath(path, bathymetryPaint);
      // Continent body fill
      canvas.drawPath(path, landPaint);
      // Crisp neon coastline rim
      canvas.drawPath(path, coastlinePaint);
    }

    // --- NORTH AMERICA ---
    final northAmerica = Path()
      ..moveTo(w * 0.08, h * 0.22) // Alaska
      ..quadraticBezierTo(w * 0.16, h * 0.20, w * 0.24, h * 0.20) // Canada
      ..lineTo(w * 0.26, h * 0.24) // Hudson Bay dip
      ..lineTo(w * 0.30, h * 0.22) // Labrador
      ..quadraticBezierTo(w * 0.34, h * 0.26, w * 0.33, h * 0.31) // East Coast
      ..lineTo(w * 0.30, h * 0.35) // Florida
      ..lineTo(w * 0.26, h * 0.34) // Gulf of Mexico
      ..lineTo(w * 0.23, h * 0.38) // Mexico / Central America
      ..lineTo(w * 0.18, h * 0.34) // Baja California
      ..quadraticBezierTo(
          w * 0.12, h * 0.30, w * 0.08, h * 0.22) // West Coast / Alaska
      ..close();
    drawLandmass(northAmerica);

    // Greenland (distinct arctic island)
    final greenland = Path()
      ..moveTo(w * 0.31, h * 0.17)
      ..lineTo(w * 0.36, h * 0.18)
      ..lineTo(w * 0.34, h * 0.22)
      ..lineTo(w * 0.29, h * 0.21)
      ..close();
    drawLandmass(greenland);

    // --- SOUTH AMERICA ---
    final southAmerica = Path()
      ..moveTo(w * 0.24, h * 0.42) // Colombia / Venezuela
      ..quadraticBezierTo(
          w * 0.32, h * 0.43, w * 0.35, h * 0.47) // Northern coast
      ..lineTo(w * 0.37, h * 0.52) // Brazil eastern bulge
      ..quadraticBezierTo(
          w * 0.34, h * 0.58, w * 0.31, h * 0.63) // Rio / Argentina
      ..lineTo(w * 0.27, h * 0.68) // Tierra del Fuego / Patagonia
      ..lineTo(w * 0.24, h * 0.58) // Chile coast
      ..quadraticBezierTo(
          w * 0.22, h * 0.48, w * 0.24, h * 0.42) // Peru / Pacific
      ..close();
    drawLandmass(southAmerica);

    // --- EUROPE & SCANDINAVIA ---
    final europe = Path()
      ..moveTo(w * 0.44, h * 0.27) // France / Iberia
      ..lineTo(w * 0.48, h * 0.25) // Central Europe
      ..lineTo(w * 0.52, h * 0.21) // Baltic
      ..lineTo(w * 0.54, h * 0.25) // Eastern Europe
      ..lineTo(w * 0.50, h * 0.31) // Balkans / Greece
      ..lineTo(w * 0.47, h * 0.30) // Italy
      ..lineTo(w * 0.43, h * 0.31) // Spain
      ..close();
    drawLandmass(europe);

    // UK & Ireland
    final britishIsles = Path()
      ..moveTo(w * 0.43, h * 0.22)
      ..lineTo(w * 0.45, h * 0.21)
      ..lineTo(w * 0.44, h * 0.25)
      ..lineTo(w * 0.42, h * 0.24)
      ..close();
    drawLandmass(britishIsles);

    // Scandinavia
    final scandinavia = Path()
      ..moveTo(w * 0.49, h * 0.17)
      ..lineTo(w * 0.53, h * 0.18)
      ..lineTo(w * 0.51, h * 0.23)
      ..lineTo(w * 0.48, h * 0.21)
      ..close();
    drawLandmass(scandinavia);

    // --- AFRICA ---
    final africa = Path()
      ..moveTo(w * 0.44, h * 0.33) // Morocco
      ..quadraticBezierTo(
          w * 0.52, h * 0.33, w * 0.58, h * 0.34) // Mediterranean coast
      ..lineTo(w * 0.60, h * 0.40) // Egypt / Red Sea
      ..lineTo(w * 0.61, h * 0.44) // Horn of Africa
      ..quadraticBezierTo(
          w * 0.58, h * 0.54, w * 0.54, h * 0.61) // East / South Africa
      ..lineTo(w * 0.50, h * 0.61) // Cape of Good Hope
      ..quadraticBezierTo(w * 0.46, h * 0.52, w * 0.43,
          h * 0.44) // Gulf of Guinea / West Africa
      ..lineTo(w * 0.41, h * 0.39) // Senegal bulge
      ..close();
    drawLandmass(africa);

    // Madagascar
    final madagascar = Path()
      ..moveTo(w * 0.61, h * 0.52)
      ..lineTo(w * 0.63, h * 0.54)
      ..lineTo(w * 0.62, h * 0.58)
      ..lineTo(w * 0.60, h * 0.56)
      ..close();
    drawLandmass(madagascar);

    // --- ASIA & MIDDLE EAST ---
    final asia = Path()
      ..moveTo(w * 0.56, h * 0.21) // Urals
      ..lineTo(w * 0.88, h * 0.20) // Siberia
      ..lineTo(w * 0.88, h * 0.30) // Kamchatka
      ..quadraticBezierTo(w * 0.82, h * 0.36, w * 0.77, h * 0.37) // China coast
      ..lineTo(w * 0.74, h * 0.45) // Indochina
      ..lineTo(w * 0.69, h * 0.45) // India / Bay of Bengal
      ..lineTo(w * 0.66, h * 0.39) // Arabian Sea
      ..lineTo(w * 0.60, h * 0.38) // Arabian Peninsula
      ..lineTo(w * 0.58, h * 0.31) // Middle East
      ..close();
    drawLandmass(asia);

    // Japan archipelago
    final japan = Path()
      ..moveTo(w * 0.87, h * 0.28)
      ..lineTo(w * 0.89, h * 0.32)
      ..lineTo(w * 0.86, h * 0.35)
      ..lineTo(w * 0.85, h * 0.32)
      ..close();
    drawLandmass(japan);

    // --- AUSTRALIA & OCEANIA ---
    final australia = Path()
      ..moveTo(w * 0.77, h * 0.55) // Darwin / North
      ..quadraticBezierTo(w * 0.85, h * 0.54, w * 0.89, h * 0.58) // Queensland
      ..lineTo(w * 0.87, h * 0.65) // Sydney / Melbourne
      ..lineTo(w * 0.80, h * 0.66) // Great Australian Bight
      ..lineTo(w * 0.75, h * 0.61) // Perth
      ..close();
    drawLandmass(australia);

    // New Zealand
    final newZealand = Path()
      ..moveTo(w * 0.91, h * 0.63)
      ..lineTo(w * 0.93, h * 0.66)
      ..lineTo(w * 0.91, h * 0.68)
      ..close();
    drawLandmass(newZealand);

    // -------------------------------------------------------------------------
    // 5. Geodesic Flight Arcs with Vector Supersonic Delta Jets
    // -------------------------------------------------------------------------
    if (showFlightRoutes) {
      final routePaint = Paint()
        ..color = flightRouteColor.withOpacity(0.65)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      final jetBodyPaint = Paint()
        ..color = compassGoldColor
        ..style = PaintingStyle.fill;

      final jetGlowPaint = Paint()
        ..color = compassLightGoldColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5;

      // Major Hub Coordinates
      final jfk = Offset(w * 0.29, h * 0.33); // New York JFK
      final lhr = Offset(w * 0.46, h * 0.27); // London Heathrow
      final dxb = Offset(w * 0.62, h * 0.36); // Dubai
      final hnd = Offset(w * 0.87, h * 0.31); // Tokyo Haneda
      final syd = Offset(w * 0.86, h * 0.63); // Sydney Kingsford
      final gru = Offset(w * 0.33, h * 0.56); // São Paulo Guarulhos

      // Helper to draw a sleek supersonic delta jet
      void drawDeltaJet(Offset pos, double angle) {
        canvas.save();
        canvas.translate(pos.dx, pos.dy);
        canvas.rotate(angle);

        final jetPath = Path()
          ..moveTo(6.5, 0.0) // Nose cone tip
          ..lineTo(-1.2, 1.8) // Fuselage body right
          ..lineTo(-3.8, 4.4) // Right swept wingtip
          ..lineTo(-2.2, 1.2) // Trailing notch right
          ..lineTo(-4.8, 0.8) // Tail right
          ..lineTo(-4.8, -0.8) // Tail left
          ..lineTo(-2.2, -1.2) // Trailing notch left
          ..lineTo(-3.8, -4.4) // Left swept wingtip
          ..lineTo(-1.2, -1.8) // Fuselage body left
          ..close();

        canvas.drawPath(jetPath, jetBodyPaint);
        canvas.drawPath(jetPath, jetGlowPaint);
        canvas.restore();
      }

      // Helper to compute quadratic Bézier point and tangent angle
      void drawGeodesicRoute(
          Offset p0, Offset p2, double curvePeak, double jetT) {
        final p1 = Offset(
          (p0.dx + p2.dx) / 2,
          (p0.dy + p2.dy) / 2 - curvePeak,
        );

        final arcPath = Path()
          ..moveTo(p0.dx, p0.dy)
          ..quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
        canvas.drawPath(arcPath, routePaint);

        // Compute exact position and tangent angle for the delta jet
        final t = jetT;
        final oneMinusT = 1.0 - t;
        final jetX = (oneMinusT * oneMinusT * p0.dx) +
            (2 * oneMinusT * t * p1.dx) +
            (t * t * p2.dx);
        final jetY = (oneMinusT * oneMinusT * p0.dy) +
            (2 * oneMinusT * t * p1.dy) +
            (t * t * p2.dy);

        final tangentX =
            2 * (oneMinusT * (p1.dx - p0.dx) + t * (p2.dx - p1.dx));
        final tangentY =
            2 * (oneMinusT * (p1.dy - p0.dy) + t * (p2.dy - p1.dy));
        final headingAngle = math.atan2(tangentY, tangentX);

        drawDeltaJet(Offset(jetX, jetY), headingAngle);
      }

      // Route 1: JFK -> LHR (Transatlantic Corridor)
      drawGeodesicRoute(jfk, lhr, 16.0, 0.55);

      // Route 2: LHR -> DXB (Euro-Gulf Corridor)
      drawGeodesicRoute(lhr, dxb, 12.0, 0.50);

      // Route 3: DXB -> HND (Asia Express Corridor)
      drawGeodesicRoute(dxb, hnd, 18.0, 0.52);

      // Route 4: HND -> SYD (West Pacific Corridor)
      drawGeodesicRoute(hnd, syd, -14.0, 0.48);

      // Route 5: JFK -> GRU (Pan-American Corridor)
      drawGeodesicRoute(jfk, gru, 14.0, 0.52);

      // Airport Hub Radar Beacons & IATA Labels
      final beaconOuterPaint = Paint()
        ..color = flightRouteColor.withOpacity(0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8;

      final beaconCorePaint = Paint()
        ..color = flightRouteColor
        ..style = PaintingStyle.fill;

      final hubList = [
        (jfk, 'JFK'),
        (lhr, 'LHR'),
        (dxb, 'DXB'),
        (hnd, 'HND'),
        (syd, 'SYD'),
        (gru, 'GRU'),
      ];

      for (final hub in hubList) {
        final pos = hub.$1;
        final iata = hub.$2;

        // Concentric radar beacon rings
        canvas.drawCircle(pos, 7.0, beaconOuterPaint);
        canvas.drawCircle(pos, 3.5, beaconOuterPaint);
        canvas.drawCircle(pos, 1.8, beaconCorePaint);

        // IATA code text
        final textSpan = TextSpan(
          text: iata,
          style: TextStyle(
            color: flightRouteColor.withOpacity(0.85),
            fontSize: 5.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            fontFamily: 'monospace',
          ),
        );
        final tp =
            TextPainter(text: textSpan, textDirection: TextDirection.ltr);
        tp.layout();
        tp.paint(canvas, Offset(pos.dx + 4.5, pos.dy - 3.5));
      }
    }

    // -------------------------------------------------------------------------
    // 6. 16-Point 3D Faceted Gold Compass Rose & Nautical Astrolabe Bezel
    // -------------------------------------------------------------------------
    if (showCompass) {
      final compassCenter = Offset(w * 0.72, h * 0.74);
      const compassRadius = 32.0;

      // Outer degree bezel ring
      final bezelPaint = Paint()
        ..color = compassGoldColor.withOpacity(0.40)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8;
      canvas.drawCircle(compassCenter, compassRadius, bezelPaint);
      canvas.drawCircle(compassCenter, compassRadius - 5.0, bezelPaint);

      // 36 Degree tick marks (every 10°)
      final tickPaint = Paint()
        ..color = compassGoldColor.withOpacity(0.60)
        ..strokeWidth = 0.75;
      for (int i = 0; i < 36; i++) {
        final tickAngle = (i * 10.0) * (math.pi / 180.0);
        final isMajor = (i % 9 == 0); // 0, 90, 180, 270
        final innerR = isMajor ? compassRadius - 5.0 : compassRadius - 2.5;
        final p1 = Offset(
          compassCenter.dx + math.cos(tickAngle) * innerR,
          compassCenter.dy + math.sin(tickAngle) * innerR,
        );
        final p2 = Offset(
          compassCenter.dx + math.cos(tickAngle) * compassRadius,
          compassCenter.dy + math.sin(tickAngle) * compassRadius,
        );
        canvas.drawLine(p1, p2, tickPaint);
      }

      // Rhumb navigation rays radiating from compass into ocean
      final rhumbPaint = Paint()
        ..color = compassGoldColor.withOpacity(0.12)
        ..strokeWidth = 0.6;
      for (int r = 0; r < 8; r++) {
        final rhumbAngle = (r * 45.0) * (math.pi / 180.0);
        final rayEnd = Offset(
          compassCenter.dx + math.cos(rhumbAngle) * 75.0,
          compassCenter.dy + math.sin(rhumbAngle) * 75.0,
        );
        canvas.drawLine(compassCenter, rayEnd, rhumbPaint);
      }

      // 16-Point 3D Faceted Star
      final lightFacetPaint = Paint()
        ..color = compassLightGoldColor
        ..style = PaintingStyle.fill;

      final darkFacetPaint = Paint()
        ..color = compassGoldColor
        ..style = PaintingStyle.fill;

      const totalPoints = 16;
      const angleStep = (2 * math.pi) / totalPoints;
      const innerNotchR = compassRadius * 0.22;

      for (int p = 0; p < totalPoints; p++) {
        final centerAngle =
            (p * angleStep) - (math.pi / 2); // Start pointing North
        double pointLength;
        if (p % 4 == 0) {
          pointLength = compassRadius * 1.02; // Primary N, E, S, W
        } else if (p % 2 == 0) {
          pointLength = compassRadius * 0.72; // Secondary NE, SE, SW, NW
        } else {
          pointLength = compassRadius * 0.48; // Tertiary
        }

        final tip = Offset(
          compassCenter.dx + math.cos(centerAngle) * pointLength,
          compassCenter.dy + math.sin(centerAngle) * pointLength,
        );

        final rightBase = Offset(
          compassCenter.dx +
              math.cos(centerAngle + (angleStep * 0.5)) * innerNotchR,
          compassCenter.dy +
              math.sin(centerAngle + (angleStep * 0.5)) * innerNotchR,
        );

        final leftBase = Offset(
          compassCenter.dx +
              math.cos(centerAngle - (angleStep * 0.5)) * innerNotchR,
          compassCenter.dy +
              math.sin(centerAngle - (angleStep * 0.5)) * innerNotchR,
        );

        // Light facet (3D highlight half)
        final lightPath = Path()
          ..moveTo(compassCenter.dx, compassCenter.dy)
          ..lineTo(tip.dx, tip.dy)
          ..lineTo(rightBase.dx, rightBase.dy)
          ..close();
        canvas.drawPath(lightPath, lightFacetPaint);

        // Dark facet (3D shadow half)
        final darkPath = Path()
          ..moveTo(compassCenter.dx, compassCenter.dy)
          ..lineTo(tip.dx, tip.dy)
          ..lineTo(leftBase.dx, leftBase.dy)
          ..close();
        canvas.drawPath(darkPath, darkFacetPaint);
      }

      // Compass Center Jewel Hub
      canvas.drawCircle(
          compassCenter, 4.2, Paint()..color = const Color(0xFF0A1422));
      canvas.drawCircle(compassCenter, 3.2, Paint()..color = compassGoldColor);
      canvas.drawCircle(compassCenter, 1.4, Paint()..color = flightRouteColor);

      // Cardinal N, S, E, W Text Labels
      void drawCardinal(String text, Offset pos) {
        final span = TextSpan(
          text: text,
          style: TextStyle(
            color: compassLightGoldColor,
            fontSize: 6.5,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        );
        final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
        tp.layout();
        tp.paint(
            canvas, Offset(pos.dx - (tp.width / 2), pos.dy - (tp.height / 2)));
      }

      drawCardinal('N',
          Offset(compassCenter.dx, compassCenter.dy - compassRadius - 5.5));
      drawCardinal('S',
          Offset(compassCenter.dx, compassCenter.dy + compassRadius + 5.5));
      drawCardinal('E',
          Offset(compassCenter.dx + compassRadius + 5.5, compassCenter.dy));
      drawCardinal('W',
          Offset(compassCenter.dx - compassRadius - 5.5, compassCenter.dy));
    }

    // -------------------------------------------------------------------------
    // 7. Aviation Telemetry Flight HUD Block (Bottom Left)
    // -------------------------------------------------------------------------
    if (showTelemetry) {
      final hudLines = [
        'LAT  34.0522° N',
        'LON 118.2437° W',
        'ALT 41,000 FT',
        'HDG 072° · M 0.85',
        'GS  560 KTS',
      ];

      double hudY = h * 0.70;
      const lineSpacing = 8.5;

      for (int i = 0; i < hudLines.length; i++) {
        final span = TextSpan(
          text: hudLines[i],
          style: TextStyle(
            color: flightRouteColor.withOpacity(i == 0 || i == 2 ? 0.75 : 0.50),
            fontSize: 5.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
            fontFamily: 'monospace',
          ),
        );
        final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
        tp.layout();
        tp.paint(canvas, Offset(w * 0.08, hudY));
        hudY += lineSpacing;
      }
    }
  }

  @override
  bool shouldRepaint(covariant WorldMapPainter oldDelegate) =>
      oldDelegate.oceanColor != oceanColor ||
      oldDelegate.continentColor != continentColor ||
      oldDelegate.flightRouteColor != flightRouteColor ||
      oldDelegate.gridColor != gridColor ||
      oldDelegate.compassGoldColor != compassGoldColor ||
      oldDelegate.compassLightGoldColor != compassLightGoldColor ||
      oldDelegate.showFlightRoutes != showFlightRoutes ||
      oldDelegate.showGrid != showGrid ||
      oldDelegate.showCompass != showCompass ||
      oldDelegate.showTelemetry != showTelemetry ||
      oldDelegate.showAtmosphere != showAtmosphere;
}
