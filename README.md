# 💳 vertical_credit_card

<div align="center">

[![pub package](https://img.shields.io/badge/pub.dev-0.0.1-blue.svg)](https://pub.dev/packages/vertical_credit_card)
[![Flutter CI](https://github.com/ClevesDev/vertical_credit_card/actions/workflows/ci.yml/badge.svg)](https://github.com/ClevesDev/vertical_credit_card/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?logo=flutter&logoColor=white)](https://flutter.dev)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/ClevesDev/vertical_credit_card/pulls)

**A sleek, modern, vertical credit and debit card widget for Flutter fintech applications.**  
Engineered with interactive 3D perspective physics, gyroscopic specular reflection, hot foil stamping, Apple Wallet multi-card stack, tap-to-reveal privacy mode, frozen/expired card states, synchronized checkout form, dynamic rolling odometer digits, and **zero external dependencies**.

</div>

---

## 🎬 Visual Showcase

<div align="center">

| 👛 Apple Wallet Multi-Card Stack | 🌊 Revolut Chromatic Fluid Mesh 3D |
| :---: | :---: |
| <img src="https://raw.githubusercontent.com/ClevesDev/vertical_credit_card/main/doc/demos/04_apple_wallet_stack.gif" width="360" alt="Apple Wallet Cascading Multi-Card Stack" /> | <img src="https://raw.githubusercontent.com/ClevesDev/vertical_credit_card/main/doc/demos/01_fluid_mesh_3d.gif" width="360" alt="Chromatic Fluid Mesh 3D Tilt" /> |
| **🌈 Holo Infinite Rainbow Sheen** | **✨ Rose Gold & Diamond Dust Sparkles** |
| <img src="https://raw.githubusercontent.com/ClevesDev/vertical_credit_card/main/doc/demos/02_holo_rainbow_sheen.gif" width="360" alt="Holo Infinite Rainbow Sheen" /> | <img src="https://raw.githubusercontent.com/ClevesDev/vertical_credit_card/main/doc/demos/06_rosegold_diamond_dust.gif" width="360" alt="Rose Gold Diamond Dust Sparkles" /> |
| **🎨 World Navigator Fine Art** | **📱 Fintech Mobile Banking App** |
| <img src="https://raw.githubusercontent.com/ClevesDev/vertical_credit_card/main/doc/demos/03_painterly_globe_art.gif" width="360" alt="World Navigator Fine Art" /> | <img src="https://raw.githubusercontent.com/ClevesDev/vertical_credit_card/main/doc/demos/07_banking_app_dashboard.gif" width="360" alt="Mobile Banking Dashboard" /> |

</div>

---

## 💡 Why Vertical Cards?

In recent years, the global banking and fintech landscape has experienced an aesthetic and functional evolution. Pioneer financial institutions and modern neobanks—such as **Apple Card, Nubank, Revolut, BBVA, and N26**—have phased out traditional horizontal plastic layouts in favor of the modern **portrait (vertical) ID-1 format**.

The reason is simple:
- 📱 **Smartphones are held vertically:** Mobile banking apps are vertical experiences; a portrait card naturally complements the viewport.
- 💳 **POS terminals insert and tap vertically:** Modern contactless terminals and chip readers orient cards top-first.
- 👛 **Digital wallets slide vertically:** Cascading mobile wallets (Apple Wallet, Google Pay) present cards in vertical stacks.

`vertical_credit_card` was engineered to give Flutter developers a first-class, production-ready vertical card component: realistic 3D perspective physics, gyroscopic light reflection, physical materials (brushed titanium, carbon fiber, Damascus steel, transparent skeleton NFC), and 40+ curated presets—crafted with **100% pure Flutter vector CustomPainters** and zero external dependencies.

---

## ✨ Features

- 📱 **100% Native Vertical Orientation:** Designed specifically for portrait mobile screens following the modern ID-1 portrait format.
- 🕹️ **Interactive 3D Perspective Tilt:** Reacts fluidly to finger dragging and mouse hovering with 3D matrix deflection and spring physics.
- 💡 **Dynamic Specular Light Reflection:** Dynamic specular glare sweep moves realistically across the surface as the card deflects.
- 🔄 **Fluid 3D Hardware Flip Animation:** Smooth 180° flip to inspect the magnetic stripe, security hologram, signature strip, and CVV on the back.
- 🌟 **Hot Foil 3D Stamping & Embossing (`CardTextFinish`):** Physical typography relief with realistic **Gold Foil**, **Silver Foil**, **Rose Gold Foil**, and **Embossed Letterpress** reflecting directional light as the card rotates.
- ⚡ **Cyber Edge Glow (Perimeter Beam):** An animated neon cometary beam that runs continuously along the curved border of the card, with optional full 360° RGB Chroma spectrum cycling.
- 📡 **Contactless NFC Payment Pulse:** Interactive expanding radar/sonar wave radiating outward from the NFC symbol on tap or payment confirmation.
- ✨ **Diamond Dust / Micro-Glitter Sparkles:** Realistic micro-particles that twinkle with 4-point starburst flares based on the card's 3D tilt angle.
- 🌊 **Chromatic Fluid Mesh Background (`CardBackground.fluid`):** Organic, morphing liquid mesh gradients with smooth harmonic motion (Revolut Metal & Apple Card style).
- 🧊 **"Frozen / Locked" State with Defrost Transition:** Instant visual feedback for temporarily locked cards featuring crystalline frost textures, desaturation, and a glowing padlock. Smoothly melts away when defrosted.
- ⚠️ **"Expired" State:** Renders expired cards in stark black & white with an official red "EXPIRED" stamp.
- 🔒 **Privacy Mode (Tap-to-Reveal):** Automatically masks sensitive numbers (`•••• •••• •••• 4321`) with an interactive eye icon or tap gesture to reveal.
- 👛 **Apple Wallet Multi-Card Stack (`VerticalCardStack`):** Cascading vertical card wallet stack with smooth spring expansion and collapse transitions.
- 🔢 **Dynamic Rolling Digit Odometer (`RollingDigitText`):** Slot-machine / odometer rolling digits for live CVV security rotation, balance updates, and account numbers.
- 💳 **Synchronized Checkout Form (`VerticalCardInputForm`):** Real-time auto-formatting (`4444 4444...`, `MM/YY`, `CVV`), brand auto-detection, and **automatic 3D card flip to the back when the user focuses the CVV field**.
- 🪪 **Security Hologram Sticker:** Realistic metallic rainbow diffraction security sticker with embossed globe & security wave patterns on the card back.
- 🧩 **Slot Injection Architecture:** Fully customizable without touching core code. Inject your own widgets into `bankLogo`, `chipWidget`, or `actionBadge`.
- 🛡️ **Zero External Dependencies:** Built with pure Flutter SDK. Vector EMV chip, NFC contactless waves, security hologram, and card network logos (Visa, Mastercard, Amex, Discover) are drawn with pure `CustomPainter`.

---

## 🚀 Getting Started

Add `vertical_credit_card` to your `pubspec.yaml`:

```yaml
dependencies:
  vertical_credit_card: ^0.0.1
```

Import it in your Dart code:

```dart
import 'package:vertical_credit_card/vertical_credit_card.dart';
```

---

## 📖 Usage Examples

### 1. Using Instant Presets (`CardPresets`)

Quickly spin up any industry-standard look with zero configuration using `VerticalCard.preset(...)`:

```dart
import 'package:flutter/material.dart';
import 'package:vertical_credit_card/vertical_credit_card.dart';

class MyCardWidget extends StatelessWidget {
  const MyCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return VerticalCard.preset(
      preset: CardPresets.topographicGold,
      cardNumber: '4532 8910 2345 6789',
      cardHolder: 'ELENA ROJAS',
      expiryDate: '12/28',
      cvv: '942',
      bankName: 'ATLAS PRIVATE BANK',
      enable3DTilt: true,
      enableSpecularGlare: true,
      isPrivacyMode: false,
      enablePrivacyToggle: true,
    );
  }
}
```

---

### 2. Interactive 3D Perspective Tilt & Specular Lighting

The card responds to touch drag gestures and pointer hover events with smooth 3D perspective deflection and a specular light sweep. You can toggle tilt, glare, and configure the maximum tilt deflection angle:

<div align="center">
  <img src="https://raw.githubusercontent.com/ClevesDev/vertical_credit_card/main/doc/demos/01_fluid_mesh_3d.gif" width="420" alt="Interactive 3D Perspective Tilt & Specular Light Sweep" />
</div>

```dart
VerticalCard(
  cardNumber: '5412 8888 1024 4321',
  cardHolder: 'CARLOS SILVA',
  expiryDate: '08/29',
  cvv: '821',
  bankName: 'NEXUS BANK',
  cardTheme: CardPresets.appleTitanium,
  enable3DTilt: true,
  enableSpecularGlare: true,
  maxTiltAngle: 0.28, // Max tilt deflection in radians (~16 degrees)
)
```

---

### 3. Privacy Mode (Tap-to-Reveal Masking)

Protect sensitive financial numbers in public spaces. When privacy mode is active, card numbers are masked as `•••• •••• •••• 4444`. Tapping the eye icon or card number toggles visibility:

```dart
VerticalCard.preset(
  preset: CardPresets.neonCyan,
  cardNumber: '4111 2222 3333 4444',
  cardHolder: 'SOFIA MENDOZA',
  expiryDate: '04/27',
  cvv: '123',
  isPrivacyMode: true, // Starts masked with security bullets
  enablePrivacyToggle: true, // Allows tapping the number or eye icon to unmask
  onPrivacyChange: (isMasked) {
    debugPrint('Card privacy state: ${isMasked ? "Masked" : "Revealed"}');
  },
)
```

---

### 4. Financial States: Frozen & Expired Cards

Trigger instant visual feedback when a card is temporarily locked or expired:

```dart
// 1. Frozen card with crystalline frost overlay, lock icon, and defrost animation
VerticalCard.preset(
  preset: CardPresets.neonCyan,
  cardNumber: '4123 4567 8901 2345',
  cardHolder: 'ALEXANDER WRIGHT',
  expiryDate: '05/28',
  cvv: '912',
  isFrozen: true, // Freezes card with crystalline frost texture & security padlock
)

// 2. Expired card with B&W desaturation and official red stamp
VerticalCard.preset(
  preset: CardPresets.amexCenturion,
  cardNumber: '3782 822468 005',
  cardHolder: 'JOHN DOE',
  expiryDate: '01/24',
  cvv: '342',
  isExpired: true, // Desaturates and stamps "EXPIRED"
)
```

---

### 5. Tactile Finishes & Sensory Visual Effects

Elevate cards into luxury physical objects using hot foil stamping, neon edge glows, diamond dust micro-glitter, and contactless payment pulses:

<div align="center">
  <img src="https://raw.githubusercontent.com/ClevesDev/vertical_credit_card/main/doc/demos/06_rosegold_diamond_dust.gif" width="420" alt="Rose Gold Luxury Finish & Diamond Dust Twinkles" />
</div>

```dart
VerticalCard.preset(
  preset: CardPresets.goldPrestige,
  cardNumber: '4111 2222 3333 4444',
  cardHolder: 'ELENA ROJAS',
  expiryDate: '12/28',
  cvv: '888',
  // 1. Hot foil physical typography relief (goldFoil, silverFoil, roseGoldFoil, embossed, flat)
  textFinish: CardTextFinish.goldFoil,
  // 2. Cyber perimeter beam tracing card border
  enableEdgeGlow: true,
  edgeGlowColor: const Color(0xFFFFD700),
  // 3. Full 360° dynamic RGB Chroma spectrum cycling (Razer Chroma style)
  isRgbChroma: false,
  // 4. Realistic twinkling diamond dust micro-glitter sparkles
  enableDiamondDust: true,
  // 5. Contactless radar sonar wave radiating on tap or payment
  enablePaymentPulse: true,
)
```

---

### 6. Custom Background Strategy (`CardBackground`)

Use the Open-Closed architecture to define any background style without touching the core widget:

<div align="center">
  <img src="https://raw.githubusercontent.com/ClevesDev/vertical_credit_card/main/doc/demos/03_painterly_globe_art.gif" width="420" alt="Custom Vector Painter Background - World Navigator" />
</div>

```dart
// 1. Solid Color
CardBackground.solid(const Color(0xFF820AD1))

// 2. Linear, Radial, or Sweep Gradient
CardBackground.gradient(
  const LinearGradient(
    colors: [Color(0xFF0F2027), Color(0xFF2C5364)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
)

// 3. Realistic Brushed Metallic Finish
CardBackground.metallic(MetalType.brushedTitanium) // gold, platinum, copper, brushedTitanium, obsidian

// 4. Frosted Glassmorphism
CardBackground.glass(
  neonColor: Colors.cyanAccent.withOpacity(0.6),
  blur: 16.0,
  backgroundColor: Colors.black.withOpacity(0.3),
)

// 5. Chromatic Fluid Mesh Gradient (Revolut Metal & Apple Card style)
CardBackground.fluid(
  colors: const [
    Color(0xFFFF007F),
    Color(0xFF7928CA),
    Color(0xFF00DFD8),
  ],
  backgroundColor: const Color(0xFF0A0A14),
  speed: 1.0,
)

// 6. Custom Vector Painter (Topographic, Art Deco, Damascus steel, etc.)
CardBackground.painter(
  const TopographicPainter(
    lineColor: Color(0x33D4AF37),
    lineSpacing: 18.0,
  ),
  backgroundColor: const Color(0xFF101014),
)

// 7. Custom Widget Builder
CardBackground.custom((context, child) {
  return Stack(
    children: [
      Image.asset('assets/card_art.png', fit: BoxFit.cover),
      child,
    ],
  );
})
```

---

### 7. Apple Wallet Multi-Card Stack (`VerticalCardStack`)

Present multiple credit, debit, or loyalty cards in an overlapping vertical cascade inspired by Apple Wallet. Tapping any card smoothly expands it into focus with spring physics:

<div align="center">
  <img src="https://raw.githubusercontent.com/ClevesDev/vertical_credit_card/main/doc/demos/04_apple_wallet_stack.gif" width="420" alt="Apple Wallet Multi-Card Cascading Stack" />
</div>

```dart
class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  int? _selectedCardIndex;

  @override
  Widget build(BuildContext context) {
    return VerticalCardStack(
      cardSpacing: 64.0,   // Vertical offset between collapsed cards
      cardHeight: 380.0,   // Display height of each card
      onCardSelected: (index) {
        setState(() => _selectedCardIndex = index);
        debugPrint('Selected card index: $index');
      },
      cards: [
        VerticalCard.preset(
          preset: CardPresets.appleTitanium,
          cardNumber: '4532 8910 2345 6789',
          cardHolder: 'CARLOS SILVA',
          expiryDate: '12/28',
          cvv: '942',
        ),
        VerticalCard.preset(
          preset: CardPresets.revolutChromatic,
          cardNumber: '5100 2233 4455 6677',
          cardHolder: 'CARLOS SILVA',
          expiryDate: '09/27',
          cvv: '123',
        ),
        VerticalCard.preset(
          preset: CardPresets.topographicGold,
          cardNumber: '3782 822468 005',
          cardHolder: 'CARLOS SILVA',
          expiryDate: '04/29',
          cvv: '777',
        ),
      ],
    );
  }
}
```

---

### 8. Dynamic Rolling Digits (`RollingDigitText`)

Add vertical odometer/slot-machine rolling animations for live rotating CVV security codes, virtual card regeneration, or real-time balance updates:

```dart
// Dynamic rotating CVV or balance counter
RollingDigitText(
  text: '842',
  style: const TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    letterSpacing: 2.0,
  ),
  duration: const Duration(milliseconds: 650),
  staggerDelay: const Duration(milliseconds: 50),
  curve: Curves.easeOutCubic,
)
```

---

### 9. Synchronized Checkout Form with CVV Auto-Flip (`VerticalCardInputForm`)

Synchronize card previews with a real-time input form that automatically formats card numbers (`1234 5678...`), expiry dates (`MM/YY`), and auto-flips the card to the back when the user taps into the CVV field:

```dart
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _cardNumber = '';
  String _cardHolder = '';
  String _expiry = '';
  String _cvv = '';
  bool _isFlipped = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Live synchronized 3D card preview
          VerticalCard.preset(
            preset: CardPresets.holoInfinite,
            cardNumber: _cardNumber.isEmpty ? '•••• •••• •••• ••••' : _cardNumber,
            cardHolder: _cardHolder.isEmpty ? 'CARDHOLDER NAME' : _cardHolder,
            expiryDate: _expiry.isEmpty ? 'MM/YY' : _expiry,
            cvv: _cvv.isEmpty ? '•••' : _cvv,
            isFlipped: _isFlipped,
          ),
          const SizedBox(height: 24),
          // Form with auto-formatting and CVV auto-flip
          VerticalCardInputForm(
            onCardNumberChanged: (val) => setState(() => _cardNumber = val),
            onCardHolderChanged: (val) => setState(() => _cardHolder = val),
            onExpiryChanged: (val) => setState(() => _expiry = val),
            onCvvChanged: (val) => setState(() => _cvv = val),
            onCvvFocusChanged: (isFocused) {
              // Automatically flip card to show CVV on back when focused
              setState(() => _isFlipped = isFocused);
            },
          ),
        ],
      ),
    );
  }
}
```

---

### 10. Slot Injection (Custom Branding & EMV Chips)

Inject custom logos, microchips, or membership badges into dedicated slots without modifying the package source:

```dart
VerticalCard(
  cardNumber: '4000 1234 5678 9010',
  cardHolder: 'VALERIA GOMEZ',
  expiryDate: '09/31',
  cvv: '777',
  cardTheme: CardPresets.carbonStealth,
  // Custom bank logo or icon
  bankLogo: Image.asset('assets/my_bank_logo.png', height: 26),
  // Custom EMV microchip widget
  chipWidget: Image.asset('assets/custom_gold_chip.png', width: 38),
  // Status badge (e.g. VIP, DEBIT, PLATINUM)
  actionBadge: Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: Colors.amber,
      borderRadius: BorderRadius.circular(4),
    ),
    child: const Text(
      'BLACK TIER',
      style: TextStyle(color: Colors.black, fontSize: 9, fontWeight: FontWeight.bold),
    ),
  ),
)
```

---

## 🛠️ Parameters Reference

### `VerticalCard` & `VerticalCard.preset`

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `cardNumber` | `String` | *required* | Card number string (formatted or unformatted). |
| `cardHolder` | `String` | *required* | Cardholder name printed on the card. |
| `expiryDate` | `String` | *required* | Expiration date typically formatted as `MM/YY`. |
| `cvv` | `String` | *required* | 3 or 4 digit CVV/CVC code displayed on the back panel. |
| `preset` *(preset factory only)* | `VerticalCardTheme` | *required* | Predefined theme from `CardPresets`. |
| `cardTheme` *(default constructor)*| `VerticalCardTheme` | *required* | Custom or preset visual theme. |
| `bankName` | `String?` | `null` | Optional bank or fintech institution name displayed at the top. |
| `brand` | `CardBrand?` | `auto` | Card network brand (Visa, Mastercard, Amex, Discover). Auto-detected if omitted. |
| `width` | `double` | `240.0` | Card width. Height is automatically computed via the standard ID-1 aspect ratio ($1 : 1.586$). |
| `enableFlip` | `bool` | `true` | Whether tapping the card flips between front and back. |
| `isFlipped` | `bool?` | `null` | Programmatically governs card flip state. If `null`, flip is controlled by user taps. |
| `enable3DTilt` | `bool` | `true` | Enables gyroscopic/pointer 3D perspective tilt with spring physics. |
| `enableSpecularGlare` | `bool` | `true` | Enables dynamic specular light reflection sweeping across the surface on tilt. |
| `enableHolographicFoil` | `bool?` | `null` | Renders rainbow holographic foil sheen. Falls back to theme configuration if `null`. |
| `maxTiltAngle` | `double` | `0.24` | Maximum deflection angle in radians for 3D tilt (~14°). |
| `isPrivacyMode` | `bool` | `false` | Whether card numbers start masked (`•••• •••• •••• 4444`). |
| `enablePrivacyToggle` | `bool` | `true` | Allows tapping the card number or privacy eye icon to toggle masking. |
| `isFrozen` | `bool` | `false` | Freezes card with crystalline ice texture overlay and security padlock. Melts smoothly when set to `false`. |
| `isExpired` | `bool` | `false` | Desaturates card to black & white and stamps red "EXPIRED". |
| `textFinish` | `CardTextFinish?` | `null` | Physical typography relief (`flat`, `goldFoil`, `silverFoil`, `roseGoldFoil`, `embossed`). |
| `enableEdgeGlow` | `bool?` | `null` | Animated neon perimeter beam tracing the card border. |
| `edgeGlowColor` | `Color?` | `null` | Color of the neon perimeter beam. |
| `isRgbChroma` | `bool?` | `null` | Cycles perimeter beam through 360° dynamic RGB Chroma spectrum. |
| `enableDiamondDust` | `bool?` | `null` | Twinkling micro-glitter diamond dust starbursts. |
| `enablePaymentPulse` | `bool?` | `null` | Contactless radar sonar wave expanding from the NFC icon on tap. |
| `bankLogo` | `Widget?` | `null` | Custom widget slot replacing the institution name/logo. |
| `chipWidget` | `Widget?` | `null` | Custom widget slot replacing the default EMV microchip. |
| `actionBadge` | `Widget?` | `null` | Custom widget slot for status/tier badge (e.g. VIP, DEBIT). |
| `onTap` | `VoidCallback?` | `null` | Callback invoked when the card is tapped. |
| `onFlipChange` | `ValueChanged<bool>?`| `null` | Callback notified when the card flips between front (`false`) and back (`true`). |
| `onPrivacyChange` | `ValueChanged<bool>?`| `null` | Callback notified when privacy masking is toggled. |

---

### `VerticalCardStack`

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `cards` | `List<Widget>` | *required* | List of card widgets to display in the overlapping cascade. |
| `cardSpacing` | `double` | `64.0` | Vertical offset in logical pixels between collapsed cards. |
| `cardHeight` | `double` | `380.0` | Display height allotted to each card container. |
| `initialIndex` | `int?` | `null` | Optional card index expanded upon initial build. |
| `onCardSelected`| `ValueChanged<int?>?`| `null` | Notified when a card is selected (`int`) or collapsed back (`null`). |
| `animationDuration` | `Duration` | `400ms` | Duration for expanding and collapsing transitions. |
| `animationCurve` | `Curve` | `Curves.easeOutBack` | Animation curve with spring physics for card transitions. |

---

### `VerticalCardInputForm`

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `onCardNumberChanged` | `ValueChanged<String>?` | `null` | Invoked with formatted 16-digit card number. |
| `onCardHolderChanged` | `ValueChanged<String>?` | `null` | Invoked with cardholder name. |
| `onExpiryChanged` | `ValueChanged<String>?` | `null` | Invoked with formatted `MM/YY` expiration string. |
| `onCvvChanged` | `ValueChanged<String>?` | `null` | Invoked with 3 or 4 digit CVV string. |
| `onCvvFocusChanged` | `ValueChanged<bool>?` | `null` | Invoked when CVV field receives or loses focus (ideal for auto-flipping the card). |
| `decoration` | `InputDecoration?` | `null` | Custom input decoration template for form text fields. |

---

### `RollingDigitText`

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `text` | `String` | *required* | String containing numeric digits and characters to animate. |
| `style` | `TextStyle?` | `null` | Text style applied to all characters (`tabularFigures` automatically enabled). |
| `duration` | `Duration` | `650ms` | Base animation duration for each digit roll. |
| `staggerDelay` | `Duration` | `45ms` | Staggered offset delay between consecutive digits. |
| `curve` | `Curve` | `Curves.easeOutCubic`| Animation curve governing digit rolling momentum. |

---

## 🎨 Curated Presets Directory (`CardPresets`)

`vertical_credit_card` includes 40+ production-ready card presets crafted with pure vector painters:

| Category | Presets | Description |
| :--- | :--- | :--- |
| **3D Artist Patterns & Landscapes** | `solarEclipse`, `desertDune`, `alpineHorizon`, `worldNavigator`, `greatWave`, `goldenKintsugi`, `cosmosConstellation`, `artDecoGold` | Fine-art vector themes: eclipse corona flare, architectural dunes, mountain ranges, geodesic flight paths, Japanese ocean waves, molten gold ceramic fissures, star constellation maps, and Gatsby 1920s gold arches. |
| **Luxury & Heavy Metals** | `appleTitanium`, `amexCenturion`, `goldPrestige` | Brushed titanium grain, matte obsidian black, and reflective gold finishes. |
| **Neobank & Digital Minimalist** | `nubank`, `wise`, `n26`, `monzoHotCoral` | Signature neobank aesthetics: Nubank purple, Wise forest & lime, N26 frosted glass, and Monzo fluorescent hot coral. |
| **Regional Fintech Flagships** | `nequi` (CO), `bancolombia` (CO), `mercadoPago` (MX/LatAm), `heyBanco` (MX), `nubankUltravioleta` (BR), `bancoInter` (BR), `lemonCash` (AR), `uala` (AR), `yape` (PE), `tenpo` (CL), `robinhoodGold` (US), `cashApp` (US) | Iconic regional fintech palettes with custom brand colors, edge glows, and gold foil typography. |
| **Exotic Physical Materials** | `skeletonNfc`, `bambooEco`, `damascusSteel`, `whiteCeramic` | Transparent Nothing-Phone style copper antenna, organic wood grain, folded Damascus steel waves, and lustrous pearl ceramic. |
| **Gamer & Esports RGB** | `razerChroma`, `cyberPcb` | Full 360° rainbow chroma edge cycling and printed circuit board traces & vias. |
| **Web3 & Hardware Wallets** | `ledgerObsidian`, `solanaAurora` | Cold storage crypto aesthetic and Solana purple-to-emerald gradient. |
| **Cyberpunk & Translucent Glass** | `neonCyan`, `matrixGreen`, `revolutChromatic` | Translucent glassmorphism with neon glow and organic chromatic fluid mesh gradients. |

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!  
Feel free to read our [Contributing Guide](CONTRIBUTING.md) and check the [issues page](https://github.com/ClevesDev/vertical_credit_card/issues).

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
