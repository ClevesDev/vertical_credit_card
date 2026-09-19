import 'package:flutter/material.dart';
import '../backgrounds/card_background.dart';
import '../models/card_theme.dart';
import '../painters/alpine_horizon_painter.dart';
import '../painters/art_deco_painter.dart';
import '../painters/carbon_fiber_painter.dart';
import '../painters/chromatic_ribbons_painter.dart';
import '../painters/constellation_painter.dart';
import '../painters/damascus_steel_painter.dart';
import '../painters/desert_dune_painter.dart';
import '../painters/great_wave_painter.dart';
import '../painters/impeller_tech_painter.dart';
import '../painters/kintsugi_painter.dart';
import '../painters/nfc_antenna_painter.dart';
import '../painters/painterly_globe_painter.dart';
import '../painters/pcb_circuit_painter.dart';
import '../painters/solar_eclipse_painter.dart';
import '../painters/topographic_painter.dart';
import '../painters/wood_grain_painter.dart';
import '../painters/world_map_painter.dart';

/// Curated library of ready-to-use, professional vertical credit card themes.
class CardPresets {
  const CardPresets._();

  // ---------------------------------------------------------------------------
  // FAMILIA A: NEOBANCOS Y FINTECHS REALES
  // ---------------------------------------------------------------------------

  /// Clean electric purple inspired by Nubank.
  static VerticalCardTheme get nubank => VerticalCardTheme.flat(
        backgroundColor: const Color(0xFF820AD1),
        textColor: Colors.white,
        secondaryTextColor: const Color(0xCCFFFFFF),
        chipColor: ChipColor.silver,
      );

  /// Deep forest green with vibrant lime accents inspired by Wise.
  static VerticalCardTheme get wise => VerticalCardTheme.flat(
        backgroundColor: const Color(0xFF163300),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF163300),
            Color(0xFF224E00),
            Color(0xFF163300),
          ],
        ),
        textColor: const Color(0xFF9FE870), // Wise signature lime
        secondaryTextColor: const Color(0xAA9FE870),
        chipColor: ChipColor.gold,
      );

  // ---------------------------------------------------------------------------
  // FAMILIA B: LUXURY & METALES PESADOS
  // ---------------------------------------------------------------------------

  /// Sleek minimalist brushed titanium inspired by Apple Card.
  static VerticalCardTheme get appleTitanium => VerticalCardTheme.metallic(
        metalType: MetalType.brushedTitanium,
        textColor: const Color(0xFFF0F0F2),
        chipColor: ChipColor.silver,
      ).copyWith(
        textFinish: CardTextFinish.embossed,
      );

  /// Stealth matte obsidian black inspired by Amex Centurion.
  static VerticalCardTheme get amexCenturion => VerticalCardTheme.metallic(
        metalType: MetalType.obsidian,
        textColor: Colors.white,
        chipColor: ChipColor.black,
      ).copyWith(
        textFinish: CardTextFinish.silverFoil,
      );

  /// 24k brushed gold prestige card with gold foil text and subtle diamond dust.
  static VerticalCardTheme get goldPrestige => VerticalCardTheme.metallic(
        metalType: MetalType.gold,
        textColor: const Color(0xFF241C0A),
        chipColor: ChipColor.gold,
      ).copyWith(
        textFinish: CardTextFinish.goldFoil,
        enableDiamondDust: true,
      );

  // ---------------------------------------------------------------------------
  // FAMILIA C: CYBERPUNK & WEB3
  // ---------------------------------------------------------------------------

  /// Translucent frosted glass with electric cyan neon border and animated perimeter glow.
  static VerticalCardTheme get neonCyan => VerticalCardTheme.glass(
        neonColor: const Color(0xFF00F0FF),
        blur: 14.0,
        chipColor: ChipColor.silver,
      ).copyWith(
        enableEdgeGlow: true,
        edgeGlowColor: const Color(0xFF00F0FF),
        enablePaymentPulse: true,
      );

  /// Deep terminal black with matrix phosphor-green glow and animated edge beam.
  static VerticalCardTheme get matrixGreen => VerticalCardTheme.glass(
        neonColor: const Color(0xFF00FF66),
        blur: 12.0,
        textColor: const Color(0xFF00FF66),
        secondaryTextColor: const Color(0xAA00FF66),
        chipColor: ChipColor.silver,
      ).copyWith(
        enableEdgeGlow: true,
        edgeGlowColor: const Color(0xFF00FF66),
        enablePaymentPulse: true,
      );

  /// Flagship Flutter Impeller GPU Edition in midnight titanium with circuit traces and IMPELLER watermark.
  static VerticalCardTheme get flutterImpeller => const VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: CardBackground.painter(ImpellerTechPainter()),
        textColor: Color(0xFFE0F2FE),
        secondaryTextColor: Color(0xAA7DD3FC),
        chipColor: ChipColor.silver,
        textFinish: CardTextFinish.silverFoil,
        enableEdgeGlow: true,
        edgeGlowColor: Color(0xFF00E5FF),
        enablePaymentPulse: true,
      );

  /// Vibrant flowing chromatic neon silk ribbons (magenta, cyan, and violet) with glossy specular crests.
  static VerticalCardTheme get chromaticFluid => const VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: CardBackground.painter(ChromaticRibbonsPainter()),
        textColor: Colors.white,
        secondaryTextColor: Color(0xCCFFFFFF),
        chipColor: ChipColor.silver,
        textFinish: CardTextFinish.silverFoil,
        enableEdgeGlow: true,
        edgeGlowColor: Color(0xFFFF007A),
        enablePaymentPulse: true,
      );

  /// Translucent frosted glass with continuous 360-degree electroluminescent neon tube edge glow.
  static VerticalCardTheme get neoDigital => VerticalCardTheme.glass(
        neonColor: const Color(0xFF00F0FF),
        blur: 16.0,
        chipColor: ChipColor.silver,
      ).copyWith(
        enableEdgeGlow: true,
        continuousEdgeTube: true,
        edgeGlowColor: const Color(0xFF00F0FF),
        textFinish: CardTextFinish.silverFoil,
        enablePaymentPulse: true,
      );

  /// Alias for [neoDigital] frosted glass card.
  static VerticalCardTheme get frostedGlass => neoDigital;

  /// Chromatic fluid liquid mesh gradient with vibrant shifting orbs (Revolut Metal & Apple Card style).
  static VerticalCardTheme get revolutChromatic => chromaticFluid;

  // ---------------------------------------------------------------------------
  // FAMILIA D: ARTE ABSTRACTO & TEXTURAS
  // ---------------------------------------------------------------------------

  /// Dynamic orbital painterly globe with warm solar brushstrokes
  /// on a deep navy background (Crédit Agricole Mastercard artistic edition).
  static VerticalCardTheme get painterlyGlobe => const VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: CardBackground.painter(PainterlyGlobePainter()),
        textColor: Colors.white,
        secondaryTextColor: Color(0xCCFFFFFF),
        chipColor: ChipColor.gold,
      );

  /// Elegant golden contour elevation lines over obsidian black.
  static VerticalCardTheme get topographicGold => const VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: CardBackground.painter(TopographicPainter()),
        textColor: Color(0xFFF7E7B4),
        secondaryTextColor: Color(0xAAD4AF37),
        chipColor: ChipColor.gold,
      );

  /// Stealth dark twill-weave carbon fiber with metallic accents.
  static VerticalCardTheme get carbonStealth => const VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: CardBackground.painter(CarbonFiberPainter()),
        textColor: Colors.white,
        secondaryTextColor: Color(0xAAFFFFFF),
        chipColor: ChipColor.silver,
      );

  /// Deep obsidian black with dynamic iridescent rainbow holographic foil sheen.
  static VerticalCardTheme get holoInfinite => const VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: CardBackground.gradient(
          LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF191B26),
              Color(0xFF0C0D14),
              Color(0xFF161824),
            ],
          ),
        ),
        textColor: Colors.white,
        secondaryTextColor: Color(0xCCFFFFFF),
        chipColor: ChipColor.silver,
        isHolographic: true,
      );

  // ---------------------------------------------------------------------------
  // FAMILIA E: REGIONAL & GLOBAL FINTECHS (CO, MX, BR, AR, ES)
  // ---------------------------------------------------------------------------

  /// Deep plum magenta with vibrant fuchsia neon accents inspired by Nequi (Colombia).
  static VerticalCardTheme get nequi => VerticalCardTheme.flat(
        backgroundColor: const Color(0xFF20002E),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2A003D),
            Color(0xFF190024),
            Color(0xFF3B0054),
          ],
        ),
        textColor: Colors.white,
        secondaryTextColor: const Color(0xFFFF007A),
        chipColor: ChipColor.silver,
      ).copyWith(
        enableEdgeGlow: true,
        edgeGlowColor: const Color(0xFFFF007A),
        enablePaymentPulse: true,
      );

  /// Matte carbon obsidian with gold foil lettering and subtle yellow accents inspired by Bancolombia.
  static VerticalCardTheme get bancolombia => VerticalCardTheme.metallic(
        metalType: MetalType.obsidian,
        textColor: const Color(0xFFFDD835),
        chipColor: ChipColor.gold,
      ).copyWith(
        secondaryTextColor: const Color(0xFFFFF9C4),
        textFinish: CardTextFinish.goldFoil,
        enablePaymentPulse: true,
      );

  /// Vibrant electric fintech blue with clean white typography inspired by Mercado Pago (Mexico & LatAm).
  static VerticalCardTheme get mercadoPago => VerticalCardTheme.flat(
        backgroundColor: const Color(0xFF009EE3),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF00A6EB),
            Color(0xFF007EBE),
          ],
        ),
        textColor: Colors.white,
        secondaryTextColor: const Color(0xCCFFFFFF),
        chipColor: ChipColor.silver,
      ).copyWith(
        enablePaymentPulse: true,
      );

  /// Stealth matte black with signature neon yellow border accents inspired by Hey Banco (Mexico).
  static VerticalCardTheme get heyBanco => VerticalCardTheme.metallic(
        metalType: MetalType.obsidian,
        textColor: const Color(0xFFFFE600),
        chipColor: ChipColor.black,
      ).copyWith(
        secondaryTextColor: const Color(0xCCFFE600),
        textFinish: CardTextFinish.silverFoil,
        enableEdgeGlow: true,
        edgeGlowColor: const Color(0xFFFFE600),
        enablePaymentPulse: true,
      );

  /// Iridescent ultra-deep purple heavy titanium with diamond dust and holographic sheen
  /// inspired by Nubank Ultravioleta (Brazil).
  static VerticalCardTheme get nubankUltravioleta => VerticalCardTheme.metallic(
        metalType: MetalType.brushedTitanium,
        chipColor: ChipColor.silver,
      ).copyWith(
        background: const CardBackground.gradient(
          LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF320B57),
              Color(0xFF1B0330),
              Color(0xFF420D75),
            ],
          ),
        ),
        textColor: const Color(0xFFF3E8FF),
        secondaryTextColor: const Color(0xFFC084FC),
        textFinish: CardTextFinish.silverFoil,
        isHolographic: true,
        enableDiamondDust: true,
        enablePaymentPulse: true,
      );

  /// Vibrant energetic electric orange with crisp white accents inspired by Banco Inter (Brazil).
  static VerticalCardTheme get bancoInter => VerticalCardTheme.flat(
        backgroundColor: const Color(0xFFFF7A00),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFF8B1F),
            Color(0xFFFF5400),
          ],
        ),
        textColor: Colors.white,
        secondaryTextColor: const Color(0xE6FFFFFF),
        chipColor: ChipColor.silver,
      ).copyWith(
        enablePaymentPulse: true,
      );

  /// Web3 neon-lime over deep cyber midnight black with cyber perimeter beam
  /// inspired by Lemon Cash (Argentina).
  static VerticalCardTheme get lemonCash => VerticalCardTheme.flat(
        backgroundColor: const Color(0xFF0D0F14),
        textColor: const Color(0xFF00FF7F),
        secondaryTextColor: const Color(0xFFD4FF00),
        chipColor: ChipColor.black,
      ).copyWith(
        textFinish: CardTextFinish.flat,
        enableEdgeGlow: true,
        edgeGlowColor: const Color(0xFF00FF7F),
        enablePaymentPulse: true,
      );

  /// Modern clean two-tone vivid crimson and white layout inspired by Ualá (Argentina).
  static VerticalCardTheme get uala => VerticalCardTheme.flat(
        backgroundColor: const Color(0xFFE51A2C),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF02436),
            Color(0xFFB80D1D),
          ],
        ),
        textColor: Colors.white,
        secondaryTextColor: const Color(0xDDFFFFFF),
        chipColor: ChipColor.silver,
      ).copyWith(
        enablePaymentPulse: true,
      );

  /// Minimalist transparent frosted glass with acrylic aesthetic inspired by N26 (Europe).
  static VerticalCardTheme get n26 => VerticalCardTheme.glass(
        neonColor: const Color(0xFF00D4B2),
        blur: 16.0,
        chipColor: ChipColor.silver,
      ).copyWith(
        textColor: Colors.white,
        secondaryTextColor: const Color(0xAA00D4B2),
        textFinish: CardTextFinish.silverFoil,
        enablePaymentPulse: true,
      );

  /// Vibrant royal purple with bright cyan accents inspired by Yape (Peru).
  static VerticalCardTheme get yape => VerticalCardTheme.flat(
        backgroundColor: const Color(0xFF742284),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF862799),
            Color(0xFF631872),
          ],
        ),
        textColor: Colors.white,
        secondaryTextColor: const Color(0xFF00D1C4),
        chipColor: ChipColor.silver,
      ).copyWith(
        enablePaymentPulse: true,
      );

  /// Electric teal and dark petrol gradient inspired by Tenpo (Chile).
  static VerticalCardTheme get tenpo => VerticalCardTheme.flat(
        backgroundColor: const Color(0xFF003840),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF00C9A7),
            Color(0xFF005952),
            Color(0xFF002930),
          ],
        ),
        textColor: Colors.white,
        secondaryTextColor: const Color(0xFF88FFD8),
        chipColor: ChipColor.silver,
      ).copyWith(
        enablePaymentPulse: true,
      );

  /// Iconic vibrant hot coral neon salmon inspired by Monzo (UK).
  static VerticalCardTheme get monzoHotCoral => VerticalCardTheme.flat(
        backgroundColor: const Color(0xFFFF483B),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFF594C),
            Color(0xFFFF3024),
          ],
        ),
        textColor: Colors.white,
        secondaryTextColor: const Color(0xFFFFF0ED),
        chipColor: ChipColor.black,
      ).copyWith(
        enableEdgeGlow: true,
        edgeGlowColor: const Color(0xFFFF7A70),
        enablePaymentPulse: true,
      );

  /// Ultra-luxurious champagne gold with specular sheen inspired by Robinhood Gold (USA).
  static VerticalCardTheme get robinhoodGold => VerticalCardTheme.metallic(
        metalType: MetalType.gold,
        textColor: const Color(0xFF1B1811),
        chipColor: ChipColor.gold,
      ).copyWith(
        secondaryTextColor: const Color(0xFF5E4E28),
        textFinish: CardTextFinish.goldFoil,
        enablePaymentPulse: true,
      );

  /// Minimalist stealth matte black with signature emerald green accents inspired by Cash App (USA).
  static VerticalCardTheme get cashApp => VerticalCardTheme.metallic(
        metalType: MetalType.obsidian,
        textColor: Colors.white,
        chipColor: ChipColor.black,
      ).copyWith(
        secondaryTextColor: const Color(0xFF00D632),
        textFinish: CardTextFinish.silverFoil,
        enablePaymentPulse: true,
      );

  // ---------------------------------------------------------------------------
  // FAMILIA F: EXOTIC MATERIALS & LUXURY ATELIERS
  // ---------------------------------------------------------------------------

  /// Translucent skeleton card revealing concentric copper NFC antenna coils and solder pads.
  static VerticalCardTheme get skeletonNfc => const VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: CardBackground.painter(NfcAntennaPainter()),
        textColor: Colors.white,
        secondaryTextColor: Color(0xFFFFB070),
        chipColor: ChipColor.silver,
        textFinish: CardTextFinish.silverFoil,
        enablePaymentPulse: true,
      );

  /// Natural organic bamboo wood grain with warm golden tan and toasted fibers.
  static VerticalCardTheme get bambooEco => const VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: CardBackground.painter(WoodGrainPainter()),
        textColor: Color(0xFF382310),
        secondaryTextColor: Color(0xFF6B4724),
        chipColor: ChipColor.gold,
        textFinish: CardTextFinish.embossed,
        enablePaymentPulse: true,
      );

  /// Forged Damascus steel with distinctive wavy water-pattern metal folds and silver foil lettering.
  static VerticalCardTheme get damascusSteel => const VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: CardBackground.painter(DamascusSteelPainter()),
        textColor: Color(0xFFF0F3F8),
        secondaryTextColor: Color(0xFFA5B0C2),
        chipColor: ChipColor.black,
        textFinish: CardTextFinish.silverFoil,
        enablePaymentPulse: true,
      );

  /// Immaculate pure polished white ceramic with silver foil typography and subtle specular sheen.
  static VerticalCardTheme get whiteCeramic => VerticalCardTheme.flat(
        backgroundColor: const Color(0xFFF9FAFB),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFF2F4F8),
            Color(0xFFE5E9F0),
          ],
        ),
        textColor: const Color(0xFF1E293B),
        secondaryTextColor: const Color(0xFF64748B),
        chipColor: ChipColor.silver,
      ).copyWith(
        textFinish: CardTextFinish.silverFoil,
        enablePaymentPulse: true,
      );

  // ---------------------------------------------------------------------------
  // FAMILIA G: GAMER, ESPORTS & RGB CHROMA
  // ---------------------------------------------------------------------------

  /// High-tech cyber printed circuit board with 45-degree traces, solder pads, and microchips.
  static VerticalCardTheme get cyberPcb => const VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: CardBackground.painter(PcbCircuitPainter()),
        textColor: Color(0xFF00E5FF),
        secondaryTextColor: Color(0xFF00FF88),
        chipColor: ChipColor.gold,
        textFinish: CardTextFinish.flat,
        enableEdgeGlow: true,
        edgeGlowColor: Color(0xFF00E5FF),
        enablePaymentPulse: true,
      );

  /// Stealth esports matte black chassis with animated 360-degree dynamic RGB Chroma edge glow.
  static VerticalCardTheme get razerChroma => VerticalCardTheme.metallic(
        metalType: MetalType.obsidian,
        textColor: Colors.white,
        chipColor: ChipColor.black,
      ).copyWith(
        secondaryTextColor: const Color(0xFF00FF00),
        enableEdgeGlow: true,
        edgeGlowColor: const Color(0xFF00FF00),
        isRgbChroma: true,
        enablePaymentPulse: true,
      );

  // ---------------------------------------------------------------------------
  // FAMILIA H: CRYPTO & WEB3 HARDWARE
  // ---------------------------------------------------------------------------

  /// Cryptographic hardware cold storage aesthetic in brushed matte obsidian with monospace accents.
  static VerticalCardTheme get ledgerObsidian => VerticalCardTheme.metallic(
        metalType: MetalType.obsidian,
        textColor: const Color(0xFFE2E8F0),
        chipColor: ChipColor.silver,
      ).copyWith(
        secondaryTextColor: const Color(0xFF94A3B8),
        textFinish: CardTextFinish.silverFoil,
        enablePaymentPulse: true,
      );

  /// Web3 gradient inspired by Solana purple-to-emerald aurora with iridescent holographic sheen.
  static VerticalCardTheme get solanaAurora => const VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: CardBackground.gradient(
          LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF9945FF),
              Color(0xFF14F195),
              Color(0xFF00C2FF),
            ],
          ),
        ),
        textColor: Colors.white,
        secondaryTextColor: Color(0xFFE0FFFA),
        chipColor: ChipColor.silver,
        textFinish: CardTextFinish.silverFoil,
        isHolographic: true,
        enablePaymentPulse: true,
      );

  // ---------------------------------------------------------------------------
  // FAMILIA I: 3D ARTIST & PATRONES GEOMÉTRICOS
  // ---------------------------------------------------------------------------

  /// Layered minimalist mountain horizon with dusk twilight and gold ridge highlights.
  static VerticalCardTheme get alpineHorizon => const VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: CardBackground.painter(AlpineHorizonPainter()),
        textColor: Colors.white,
        secondaryTextColor: Color(0xFFF9A825),
        chipColor: ChipColor.gold,
        textFinish: CardTextFinish.goldFoil,
        enablePaymentPulse: true,
      );

  /// Luxury global traveler world map with geodesic flight routes, supersonic delta jets, and 3D gold compass rose.
  static VerticalCardTheme get worldNavigator => const VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: CardBackground.painter(WorldMapPainter()),
        textColor: Colors.white,
        secondaryTextColor: Color(0xFF00E5FF),
        chipColor: ChipColor.gold,
        textFinish: CardTextFinish.goldFoil,
        enableEdgeGlow: true,
        edgeGlowColor: Color(0xFF00E5FF),
        enablePaymentPulse: true,
      );

  /// Dynamic Japanese Ukiyo-e surging ocean wave pattern with crest foam and gold accents.
  static VerticalCardTheme get greatWave => const VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: CardBackground.painter(GreatWavePainter()),
        textColor: Colors.white,
        secondaryTextColor: Color(0xFFF1F5F9),
        chipColor: ChipColor.gold,
        textFinish: CardTextFinish.goldFoil,
        enablePaymentPulse: true,
      );

  /// Japanese Golden Kintsugi fractured ceramic with liquid molten gold seams.
  static VerticalCardTheme get goldenKintsugi => const VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: CardBackground.painter(KintsugiPainter()),
        textColor: Color(0xFFFDF6E2),
        secondaryTextColor: Color(0xFFFFD700),
        chipColor: ChipColor.gold,
        textFinish: CardTextFinish.goldFoil,
        enablePaymentPulse: true,
      );

  /// Deep space celestial star map with constellations and astrolabe orbital rings.
  static VerticalCardTheme get cosmosConstellation => const VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: CardBackground.painter(ConstellationPainter()),
        textColor: Colors.white,
        secondaryTextColor: Color(0xFF93C5FD),
        chipColor: ChipColor.silver,
        textFinish: CardTextFinish.silverFoil,
        enableDiamondDust: true,
        enablePaymentPulse: true,
      );

  /// Symmetrical 1920s Great Gatsby architectural Art Déco fan arches and gold chevrons.
  static VerticalCardTheme get artDecoGold => const VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: CardBackground.painter(ArtDecoPainter()),
        textColor: Color(0xFFFBF4D9),
        secondaryTextColor: Color(0xFFD4AF37),
        chipColor: ChipColor.gold,
        textFinish: CardTextFinish.goldFoil,
        enablePaymentPulse: true,
      );

  /// Minimalist total solar eclipse with liquid gold corona and diamond ring lens flare on obsidian.
  static VerticalCardTheme get solarEclipse => const VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: CardBackground.painter(SolarEclipsePainter()),
        textColor: Colors.white,
        secondaryTextColor: Color(0xFFFFD54F),
        chipColor: ChipColor.gold,
        textFinish: CardTextFinish.goldFoil,
        enableEdgeGlow: true,
        edgeGlowColor: Color(0xFFFFB300),
        enablePaymentPulse: true,
      );

  /// Warm architectural desert sand dunes at sunset with sharp metallic gold ridge highlights.
  static VerticalCardTheme get desertDune => const VerticalCardTheme(
        type: VerticalCardThemeType.artistic,
        background: CardBackground.painter(DesertDunePainter()),
        textColor: Color(0xFFFFF3E0),
        secondaryTextColor: Color(0xFFFFD54F),
        chipColor: ChipColor.gold,
        textFinish: CardTextFinish.goldFoil,
        enablePaymentPulse: true,
      );
}
