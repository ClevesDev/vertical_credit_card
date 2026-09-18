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
      // Horizon arc curving over the upper third of the card
      final horizonCenter = Offset(w * 0.5, h * 0.85);
      final horizonRadius = h * 0.66;

      // Atmospheric outer cyan haze glow
      final hazePaint = Paint()
        ..color = flightRouteColor.withOpacity(0.08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 14.0;
      canvas.drawCircle(horizonCenter, horizonRadius, hazePaint);

      // Atmospheric mid soft glow
      final midGlowPaint = Paint()
        ..color = flightRouteColor.withOpacity(0.22)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5;
      canvas.drawCircle(horizonCenter, horizonRadius, midGlowPaint);

      // Crisp planetary limb rim
      final rimPaint = Paint()
        ..color =
            Color.lerp(flightRouteColor, Colors.white, 0.6)!.withOpacity(0.70)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawCircle(horizonCenter, horizonRadius, rimPaint);
    }

    // -------------------------------------------------------------------------
    // 3. Proportional 2:1 World Map Canvas Definition
    // -------------------------------------------------------------------------
    // Positioned strictly in the hero band between the chip and card number
    // Map width: 90% of card width. Map height: mapWidth / 2.1 (preserves real geography!)
    final mapOriginX = w * 0.05;
    final mapOriginY = h * 0.24;
    final mapW = w * 0.90;
    final mapH = mapW / 2.1; // ~103px high on a 240px card

    double mx(double u) => mapOriginX + (u * mapW);
    double my(double v) => mapOriginY + (v * mapH);

    // Coordinate Grid (Parallels & Meridians within the geographic bounding box)
    if (showGrid) {
      final gridPaint = Paint()
        ..color = gridColor.withOpacity(0.40)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.65;

      // Parallels (Tropic of Cancer, Equator, Tropic of Capricorn)
      for (double v in [0.25, 0.50, 0.75]) {
        canvas.drawLine(
            Offset(mx(0.0), my(v)), Offset(mx(1.0), my(v)), gridPaint);
      }

      // Meridians (Curved ellipses across the map)
      for (double u in [0.25, 0.50, 0.75]) {
        canvas.drawLine(
            Offset(mx(u), my(0.0)), Offset(mx(u), my(1.0)), gridPaint);
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
      ..strokeWidth = 2.2;

    void drawLandmass(Path path) {
      canvas.drawPath(path, bathymetryPaint);
      canvas.drawPath(path, landPaint);
      canvas.drawPath(path, coastlinePaint);
    }

    // --- NORTH AMERICA ---
    final northAmerica = Path()
      ..moveTo(mx(0.02), my(0.12)) // Alaska
      ..quadraticBezierTo(
          mx(0.10), my(0.04), mx(0.18), my(0.04)) // Northern Canada
      ..lineTo(mx(0.23), my(0.10)) // Hudson Bay
      ..lineTo(mx(0.28), my(0.08)) // Labrador
      ..quadraticBezierTo(
          mx(0.28), my(0.16), mx(0.26), my(0.22)) // US East Coast
      ..lineTo(mx(0.25), my(0.32)) // Florida
      ..lineTo(mx(0.21), my(0.30)) // Gulf of Mexico
      ..lineTo(mx(0.20), my(0.42)) // Central America
      ..lineTo(mx(0.16), my(0.36)) // Mexico Pacific
      ..lineTo(mx(0.13), my(0.28)) // Baja California
      ..quadraticBezierTo(
          mx(0.08), my(0.20), mx(0.02), my(0.12)) // West Coast / Alaska
      ..close();
    drawLandmass(northAmerica);

    // Greenland
    final greenland = Path()
      ..moveTo(mx(0.31), my(0.02))
      ..lineTo(mx(0.36), my(0.04))
      ..lineTo(mx(0.34), my(0.10))
      ..lineTo(mx(0.29), my(0.08))
      ..close();
    drawLandmass(greenland);

    // --- SOUTH AMERICA ---
    final southAmerica = Path()
      ..moveTo(mx(0.21), my(0.46)) // Colombia / Venezuela
      ..quadraticBezierTo(mx(0.28), my(0.48), mx(0.32), my(0.52)) // Guianas
      ..lineTo(mx(0.36), my(0.60)) // Brazil eastern bulge
      ..quadraticBezierTo(
          mx(0.33), my(0.72), mx(0.29), my(0.82)) // Rio / Buenos Aires
      ..lineTo(mx(0.25), my(0.96)) // Patagonia
      ..lineTo(mx(0.22), my(0.74)) // Chile Pacific
      ..quadraticBezierTo(
          mx(0.18), my(0.56), mx(0.21), my(0.46)) // Peru / Pacific
      ..close();
    drawLandmass(southAmerica);

    // --- EUROPE & SCANDINAVIA ---
    final europe = Path()
      ..moveTo(mx(0.41), my(0.24)) // Iberia
      ..lineTo(mx(0.44), my(0.18)) // France
      ..lineTo(mx(0.48), my(0.16)) // Central Europe
      ..lineTo(mx(0.52), my(0.14)) // Baltic
      ..lineTo(mx(0.53), my(0.20)) // Eastern Europe
      ..lineTo(mx(0.50), my(0.26)) // Balkans
      ..lineTo(mx(0.47), my(0.26)) // Italy
      ..lineTo(mx(0.44), my(0.25)) // Mediterranean
      ..close();
    drawLandmass(europe);

    // UK & Ireland
    final britishIsles = Path()
      ..moveTo(mx(0.42), my(0.14))
      ..lineTo(mx(0.45), my(0.12))
      ..lineTo(mx(0.44), my(0.18))
      ..lineTo(mx(0.41), my(0.17))
      ..close();
    drawLandmass(britishIsles);

    // Scandinavia
    final scandinavia = Path()
      ..moveTo(mx(0.48), my(0.04))
      ..lineTo(mx(0.52), my(0.05))
      ..lineTo(mx(0.50), my(0.13))
      ..lineTo(mx(0.47), my(0.11))
      ..close();
    drawLandmass(scandinavia);

    // --- AFRICA ---
    final africa = Path()
      ..moveTo(mx(0.41), my(0.28)) // Morocco
      ..quadraticBezierTo(
          mx(0.48), my(0.27), mx(0.55), my(0.28)) // Mediterranean
      ..lineTo(mx(0.57), my(0.33)) // Egypt / Red Sea
      ..lineTo(mx(0.61), my(0.38)) // Horn of Africa
      ..quadraticBezierTo(
          mx(0.58), my(0.52), mx(0.53), my(0.76)) // East / South Africa
      ..lineTo(mx(0.48), my(0.76)) // Cape of Good Hope
      ..quadraticBezierTo(
          mx(0.45), my(0.58), mx(0.43), my(0.46)) // Gulf of Guinea
      ..lineTo(mx(0.37), my(0.38)) // Senegal bulge
      ..close();
    drawLandmass(africa);

    // Madagascar
    final madagascar = Path()
      ..moveTo(mx(0.61), my(0.58))
      ..lineTo(mx(0.63), my(0.61))
      ..lineTo(mx(0.62), my(0.70))
      ..lineTo(mx(0.60), my(0.66))
      ..close();
    drawLandmass(madagascar);

    // --- ASIA & MIDDLE EAST ---
    final asia = Path()
      ..moveTo(mx(0.53), my(0.10)) // Urals
      ..lineTo(mx(0.88), my(0.08)) // Siberia
      ..lineTo(mx(0.92), my(0.14)) // Kamchatka
      ..quadraticBezierTo(mx(0.84), my(0.24), mx(0.80), my(0.26)) // China coast
      ..lineTo(mx(0.77), my(0.42)) // Indochina
      ..lineTo(mx(0.71), my(0.42)) // India
      ..lineTo(mx(0.66), my(0.36)) // Arabian Sea
      ..lineTo(mx(0.60), my(0.34)) // Arabian Peninsula
      ..lineTo(mx(0.56), my(0.28)) // Middle East
      ..close();
    drawLandmass(asia);

    // Japan
    final japan = Path()
      ..moveTo(mx(0.86), my(0.22))
      ..lineTo(mx(0.88), my(0.25))
      ..lineTo(mx(0.86), my(0.30))
      ..lineTo(mx(0.84), my(0.26))
      ..close();
    drawLandmass(japan);

    // --- AUSTRALIA & OCEANIA ---
    final australia = Path()
      ..moveTo(mx(0.77), my(0.64)) // North / Darwin
      ..quadraticBezierTo(mx(0.84), my(0.62), mx(0.88), my(0.68)) // Queensland
      ..lineTo(mx(0.86), my(0.80)) // Sydney / Melbourne
      ..lineTo(mx(0.79), my(0.82)) // Great Australian Bight
      ..lineTo(mx(0.74), my(0.74)) // Perth
      ..close();
    drawLandmass(australia);

    // New Zealand
    final newZealand = Path()
      ..moveTo(mx(0.90), my(0.78))
      ..lineTo(mx(0.92), my(0.82))
      ..lineTo(mx(0.90), my(0.86))
      ..close();
    drawLandmass(newZealand);

    // -------------------------------------------------------------------------
    // 5. Geodesic Flight Arcs with Vector Supersonic Delta Jets
    // -------------------------------------------------------------------------
    if (showFlightRoutes) {
      final routePaint = Paint()
        ..color = flightRouteColor.withOpacity(0.65)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.9;

      final jetBodyPaint = Paint()
        ..color = compassGoldColor
        ..style = PaintingStyle.fill;

      final jetGlowPaint = Paint()
        ..color = compassLightGoldColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5;

      // Major Hub Coordinates
      final jfk = Offset(mx(0.26), my(0.24)); // New York JFK
      final lhr = Offset(mx(0.44), my(0.16)); // London Heathrow
      final dxb = Offset(mx(0.61), my(0.34)); // Dubai
      final hnd = Offset(mx(0.86), my(0.26)); // Tokyo Haneda
      final syd = Offset(mx(0.86), my(0.76)); // Sydney Kingsford
      final gru = Offset(mx(0.33), my(0.68)); // São Paulo Guarulhos

      // Helper to draw a sleek supersonic delta jet
      void drawDeltaJet(Offset pos, double angle) {
        canvas.save();
        canvas.translate(pos.dx, pos.dy);
        canvas.rotate(angle);

        final jetPath = Path()
          ..moveTo(5.5, 0.0) // Nose cone tip
          ..lineTo(-1.0, 1.5) // Fuselage body right
          ..lineTo(-3.2, 3.8) // Right swept wingtip
          ..lineTo(-1.8, 1.0) // Trailing notch right
          ..lineTo(-4.0, 0.7) // Tail right
          ..lineTo(-4.0, -0.7) // Tail left
          ..lineTo(-1.8, -1.0) // Trailing notch left
          ..lineTo(-3.2, -3.8) // Left swept wingtip
          ..lineTo(-1.0, -1.5) // Fuselage body left
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
      drawGeodesicRoute(jfk, lhr, 10.0, 0.55);

      // Route 2: LHR -> DXB (Euro-Gulf Corridor)
      drawGeodesicRoute(lhr, dxb, 8.0, 0.50);

      // Route 3: DXB -> HND (Asia Express Corridor)
      drawGeodesicRoute(dxb, hnd, 12.0, 0.52);

      // Route 4: HND -> SYD (West Pacific Corridor)
      drawGeodesicRoute(hnd, syd, -8.0, 0.48);

      // Route 5: JFK -> GRU (Pan-American Corridor)
      drawGeodesicRoute(jfk, gru, 8.0, 0.52);

      // Airport Hub Radar Beacons & IATA Labels
      final beaconOuterPaint = Paint()
        ..color = flightRouteColor.withOpacity(0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.7;

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

        canvas.drawCircle(pos, 5.0, beaconOuterPaint);
        canvas.drawCircle(pos, 2.8, beaconOuterPaint);
        canvas.drawCircle(pos, 1.4, beaconCorePaint);

        final textSpan = TextSpan(
          text: iata,
          style: TextStyle(
            color: flightRouteColor.withOpacity(0.85),
            fontSize: 5.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            fontFamily: 'monospace',
          ),
        );
        final tp =
            TextPainter(text: textSpan, textDirection: TextDirection.ltr);
        tp.layout();
        tp.paint(canvas, Offset(pos.dx + 3.5, pos.dy - 3.0));
      }
    }

    // -------------------------------------------------------------------------
    // 6. Navigation Instruments Band (Between Map and Card Number: h * 0.51 to h * 0.65)
    // -------------------------------------------------------------------------

    // 6A. Aviation Telemetry Flight HUD Block (Left side)
    if (showTelemetry) {
      final hudLines = [
        'LAT  34.0522° N',
        'LON 118.2437° W',
        'ALT 41,000 FT',
        'HDG 072° · M 0.85',
        'GS  560 KTS',
      ];

      double hudY = h * 0.53;
      const lineSpacing = 7.5;

      for (int i = 0; i < hudLines.length; i++) {
        final span = TextSpan(
          text: hudLines[i],
          style: TextStyle(
            color: flightRouteColor.withOpacity(i == 0 || i == 2 ? 0.75 : 0.45),
            fontSize: 5.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
            fontFamily: 'monospace',
          ),
        );
        final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
        tp.layout();
        tp.paint(canvas, Offset(w * 0.08, hudY));
        hudY += lineSpacing;
      }
    }

    // 6B. 16-Point 3D Faceted Gold Compass Rose (Right side, ABOVE card number)
    if (showCompass) {
      final compassCenter = Offset(w * 0.74, h * 0.57);
      const compassRadius = 22.0;

      // Outer degree bezel ring
      final bezelPaint = Paint()
        ..color = compassGoldColor.withOpacity(0.40)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.75;
      canvas.drawCircle(compassCenter, compassRadius, bezelPaint);
      canvas.drawCircle(compassCenter, compassRadius - 3.5, bezelPaint);

      // Degree tick marks (every 15°)
      final tickPaint = Paint()
        ..color = compassGoldColor.withOpacity(0.55)
        ..strokeWidth = 0.65;
      for (int i = 0; i < 24; i++) {
        final tickAngle = (i * 15.0) * (math.pi / 180.0);
        final isMajor = (i % 6 == 0); // 0, 90, 180, 270
        final innerR = isMajor ? compassRadius - 4.0 : compassRadius - 2.0;
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

      // Rhumb navigation rays radiating from compass
      final rhumbPaint = Paint()
        ..color = compassGoldColor.withOpacity(0.10)
        ..strokeWidth = 0.5;
      for (int r = 0; r < 8; r++) {
        final rhumbAngle = (r * 45.0) * (math.pi / 180.0);
        final rayEnd = Offset(
          compassCenter.dx + math.cos(rhumbAngle) * 55.0,
          compassCenter.dy + math.sin(rhumbAngle) * 55.0,
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
        final centerAngle = (p * angleStep) - (math.pi / 2); // North is up
        double pointLength;
        if (p % 4 == 0) {
          pointLength = compassRadius * 1.0; // Primary N, E, S, W
        } else if (p % 2 == 0) {
          pointLength = compassRadius * 0.70; // Secondary NE, SE, SW, NW
        } else {
          pointLength = compassRadius * 0.45; // Tertiary
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

        // Light facet (highlight)
        final lightPath = Path()
          ..moveTo(compassCenter.dx, compassCenter.dy)
          ..lineTo(tip.dx, tip.dy)
          ..lineTo(rightBase.dx, rightBase.dy)
          ..close();
        canvas.drawPath(lightPath, lightFacetPaint);

        // Dark facet (shadow)
        final darkPath = Path()
          ..moveTo(compassCenter.dx, compassCenter.dy)
          ..lineTo(tip.dx, tip.dy)
          ..lineTo(leftBase.dx, leftBase.dy)
          ..close();
        canvas.drawPath(darkPath, darkFacetPaint);
      }

      // Center Hub
      canvas.drawCircle(
          compassCenter, 3.2, Paint()..color = const Color(0xFF0A1422));
      canvas.drawCircle(compassCenter, 2.2, Paint()..color = compassGoldColor);
      canvas.drawCircle(compassCenter, 1.0, Paint()..color = flightRouteColor);

      // Cardinal N, S, E, W Labels
      void drawCardinal(String text, Offset pos) {
        final span = TextSpan(
          text: text,
          style: TextStyle(
            color: compassLightGoldColor,
            fontSize: 5.5,
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
          Offset(compassCenter.dx, compassCenter.dy - compassRadius - 4.5));
      drawCardinal('S',
          Offset(compassCenter.dx, compassCenter.dy + compassRadius + 4.5));
      drawCardinal('E',
          Offset(compassCenter.dx + compassRadius + 4.5, compassCenter.dy));
      drawCardinal('W',
          Offset(compassCenter.dx - compassRadius - 4.5, compassCenter.dy));
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
