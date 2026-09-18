# 💳 vertical_credit_card

<div align="center">

[![pub package](https://img.shields.io/badge/pub.dev-0.0.1-blue.svg)](https://pub.dev/packages/vertical_credit_card)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?logo=flutter&logoColor=white)](https://flutter.dev)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/ClevesDev/vertical_credit_card/pulls)

**A sleek, modern, vertical credit and debit card widget for Flutter fintech applications.**  
Engineered with interactive 3D tilt physics, dynamic specular lighting, tap-to-reveal privacy mode, frozen/expired card states, curated design presets, and **zero external dependencies**.

</div>

---

## ☕ Why does this exist?

This package was born on a painfully boring afternoon, fueled by pure caffeine and deep frustration after spending hours scouring `pub.dev` looking for a clean, modern **vertical** credit card widget.

Every existing package was either:
1. Stuck in 2019.
2. Strictly horizontal.
3. Completely abandoned (404).

Stressed out and tired of reinventing the wheel on every fintech project, I sighed and went: *"Fine, I'll build it myself."*

Built as a weekend hobby project so you don't have to suffer like I did. Enjoy!

---

## ✨ Features

- 📱 **100% Native Vertical Orientation:** Designed specifically for portrait mobile screens following the modern ID-1 portrait format (Nubank, Revolut, BBVA, Apple Card).
- 🕹️ **Interactive 3D Tilt & Specular Reflection:** Reacts to finger dragging and mouse hovering with perspective transformations and a specular light sweep that dynamically moves across the card, snapping back with spring physics.
- 🔄 **Fluid 3D Flip Animation:** Smooth 180° hardware-accelerated flip to inspect the magnetic stripe, signature strip, and CVV on the back.
- 🌟 **Hot Foil 3D Stamping & Embossing (`CardTextFinish`):** Physical typography relief with realistic **Gold Foil**, **Silver Foil**, **Rose Gold Foil**, and **Embossed Letterpress** reflecting directional light as the card rotates.
- ⚡ **Cyber Edge Glow (Perimeter Beam):** An animated neon cometary beam that runs continuously along the curved border of the card.
- 📡 **Contactless NFC Payment Pulse:** Interactive expanding radar/sonar wave radiating outward from the NFC symbol on tap or payment confirmation.
- ✨ **Diamond Dust / Micro-Glitter Sparkles:** Realistic micro-particles that twinkle with 4-point starburst flares based on the card's 3D tilt angle.
- 🌊 **Chromatic Fluid Mesh Background (`CardBackground.fluid`):** Organic, morphing liquid mesh gradients with smooth harmonic motion (Revolut Metal & Apple Card style).
- 🧊 **Dynamic Defrost Transition:** Smooth ice-melting animation when transitioning from `isFrozen: true` to `false`.
- 💳 **Synchronized Checkout Form (`VerticalCardInputForm`):** Real-time auto-formatting (`4444 4444...`, `MM/YY`, `CVV`), card brand detection, and **automatic 3D card flip to the back when the user focuses the CVV field**.
- 🪪 **Security Hologram Sticker:** Realistic metallic rainbow diffraction security sticker with embossed globe & security wave patterns on the card back.
- 🔒 **Privacy Mode (Tap-to-Reveal):** Automatically masks card numbers (`•••• •••• •••• 4321`) with an interactive eye icon or card tap to reveal sensitive details.
- 🧊 **"Frozen / Locked" State:** Instant visual feedback for blocked cards featuring crystalline frost textures, desaturation, and a glowing padlock.
- ⚠️ **"Expired" State:** Renders expired cards in stark black & white with an official red "EXPIRED" stamp.
- 🎨 **Curated Presets Across 4 Design Families (`CardPresets`):**
  - **Family A (Neobank Modern):** `nubank`, `wise`
  - **Family B (Luxury & Heavy Metals):** `appleTitanium`, `amexCenturion`, `goldPrestige`
  - **Family C (Cyberpunk & Web3):** `neonCyan`, `matrixGreen`, `revolutChromatic`
  - **Family D (Abstract Art & Textures):** `painterlyGlobe`, `topographicGold`, `carbonStealth`
- 🧩 **Slot Injection Architecture:** Fully customizable without touching core code. Inject your own widgets into `chipSlot`, `logoSlot`, `badgeSlot`, or `customOverlay`.
- 🛡️ **Zero External Dependencies:** Pure Flutter SDK. Vector EMV chip, NFC contactless waves, security hologram, and card network logos (Visa, Mastercard, Amex, Discover) are drawn with pure `CustomPainter`. No SVG loaders, no asset bundling issues.

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

Quickly spin up any industry-standard look with zero configuration:

```dart
VerticalCard.preset(
  preset: CardPresets.topographicGold,
  cardNumber: '4532 8910 2345 6789',
  cardHolder: 'ELENA ROJAS',
  expiryDate: '12/28',
  cvv: '942',
  enableTilt: true,
  enablePrivacyMode: true,
)
```

Available presets include:
- `CardPresets.nubank` (Vibrant purple neo-bank)
- `CardPresets.wise` (Forest green with lime accents)
- `CardPresets.appleTitanium` (Minimalist brushed titanium)
- `CardPresets.amexCenturion` (Brushed obsidian black)
- `CardPresets.goldPrestige` (Reflective brushed gold)
- `CardPresets.neonCyan` (Translucent glass with cyan cyber glow)
- `CardPresets.matrixGreen` (Dark glass with terminal green accents)
- `CardPresets.painterlyGlobe` (Artistic orbital paint splatter)
- `CardPresets.topographicGold` (Obsidian with gold contour elevation curves)
- `CardPresets.carbonStealth` (Realistic 45° twill-weave carbon fiber)

---

### 2. Interactive 3D Tilt & Specular Glare

Enable gyroscopic / drag-tilt effects with dynamic specular light reflection:

```dart
VerticalCard(
  cardNumber: '5412 8888 1024 4321',
  cardHolder: 'CARLOS SILVA',
  expiryDate: '08/29',
  cvv: '821',
  bankName: 'NEXUS BANK',
  background: CardBackground.metallic(MetalType.brushedTitanium),
  enableTilt: true,
  tiltSensitivity: 1.2,
)
```

---

### 3. Privacy Mode (Masked Numbers)

Protect sensitive information in public spaces:

```dart
VerticalCard(
  cardNumber: '4111 2222 3333 4444',
  cardHolder: 'SOFIA MENDOZA',
  expiryDate: '04/27',
  cvv: '123',
  enablePrivacyMode: true,
  isPrivacyActive: true, // starts masked as •••• •••• •••• 4444
  onPrivacyChanged: (isMasked) {
    print('Privacy state is now: $isMasked');
  },
)
```

---

### 4. Frozen & Expired Card States

Trigger instant visual feedback when a card is temporarily locked or expired:

```dart
// Frozen card with crystalline frost overlay and security lock
VerticalCard.preset(
  preset: CardPresets.neonCyan,
  cardNumber: '4123 4567 8901 2345',
  cardHolder: 'ALEXANDER WRIGHT',
  expiryDate: '05/28',
  cvv: '912',
  isFrozen: true,
)

// Expired card with B&W desaturation and red stamp
VerticalCard.preset(
  preset: CardPresets.amexCenturion,
  cardNumber: '3782 822468 005',
  cardHolder: 'JOHN DOE',
  expiryDate: '01/24',
  cvv: '342',
  isExpired: true,
)
```

---

### 5. Custom Background Strategy (`CardBackground`)

Use the Open-Closed architecture to define completely custom background renders:

```dart
// 1. Solid Color
CardBackground.solid(Color(0xFF820AD1))

// 2. Linear / Radial / Sweep Gradient
CardBackground.gradient(
  LinearGradient(
    colors: [Color(0xFF0F2027), Color(0xFF2C5364)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
)

// 3. Metallic Texture
CardBackground.metallic(MetalType.gold)

// 4. Glassmorphism
CardBackground.glass(
  tintColor: Colors.black.withOpacity(0.3),
  blurAmount: 16.0,
  borderGlowColor: Colors.cyanAccent.withOpacity(0.6),
)

// 5. Custom Vector Painter
CardBackground.painter(MyCustomVectorPainter())
```

---

### 6. Slot Injection

Inject your own logos, microchips, or custom widgets without modifying the package source:

```dart
VerticalCard(
  cardNumber: '4000 1234 5678 9010',
  cardHolder: 'VALERIA GOMEZ',
  expiryDate: '09/31',
  cvv: '777',
  background: CardBackground.solid(Colors.black),
  // Inject custom widgets into dedicated slots
  chipSlot: Image.asset('assets/custom_gold_chip.png', width: 38),
  logoSlot: Image.asset('assets/company_logo.png', height: 26),
  badgeSlot: Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.amber,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text('VIP MEMBER', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
  ),
)
```

---

### 7. Synchronized Checkout Form with Auto-Flip

Use `VerticalCardInputForm` to automatically format user input and trigger an auto-flip to the card back when the user taps on CVV:

```dart
bool _isFlipped = false;

Column(
  children: [
    VerticalCard.preset(
      cardNumber: _number,
      cardHolder: _holder,
      expiryDate: _expiry,
      cvv: _cvv,
      isFlipped: _isFlipped,
      preset: CardPresets.holoInfinite,
    ),
    const SizedBox(height: 24),
    VerticalCardInputForm(
      onCardNumberChanged: (val) => setState(() => _number = val),
      onCardHolderChanged: (val) => setState(() => _holder = val),
      onExpiryChanged: (val) => setState(() => _expiry = val),
      onCvvChanged: (val) => setState(() => _cvv = val),
      onCvvFocusChanged: (isFocused) {
        // Automatically flip card to back when focusing CVV
        setState(() => _isFlipped = isFocused);
      },
    ),
  ],
)
```


---

## 🛠️ Parameters Reference

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `cardNumber` | `String` | *required* | Card number string (formatted or unformatted). |
| `cardHolder` | `String` | *required* | Cardholder name printed on the card. |
| `expiryDate` | `String` | *required* | Expiration date in `MM/YY` format. |
| `cvv` | `String` | *required* | 3 or 4 digit CVV/CVC code displayed on the back. |
| `bankName` | `String?` | `null` | Optional bank or fintech brand name displayed at top. |
| `brand` | `CardBrand?` | `auto` | Card network brand (auto-detected if omitted). |
| `background` | `CardBackground` | `solid` | Background render strategy. |
| `theme` | `VerticalCardTheme` | `light` | Visual theme defining colors, fonts, and borders. |
| `width` | `double` | `240.0` | Card width. Height is calculated via ID-1 aspect ratio ($1 : 1.586$). |
| `enableFlip` | `bool` | `true` | Whether tapping the card flips between front and back. |
| `enableTilt` | `bool` | `true` | Enables 3D perspective tilt & specular glare on drag/hover. |
| `tiltSensitivity` | `double` | `1.0` | Multiplier for the 3D tilt deflection angle. |
| `enablePrivacyMode` | `bool` | `false` | Enables tap-to-reveal number masking. |
| `isPrivacyActive` | `bool` | `false` | Current state of privacy masking. |
| `isFrozen` | `bool` | `false` | Freezes the card with ice crystal overlay and lock icon. |
| `isExpired` | `bool` | `false` | Desaturates the card to B&W and stamps "EXPIRED". |
| `textFinish` | `CardTextFinish?` | `flat` | Typography finish (`flat`, `goldFoil`, `silverFoil`, `roseGoldFoil`, `embossed`). |
| `enableEdgeGlow` | `bool?` | `false` | Enables animated neon perimeter beam tracing the border. |
| `edgeGlowColor` | `Color?` | `null` | Color of the neon perimeter beam. |
| `enableDiamondDust` | `bool?` | `false` | Enables twinkling micro-glitter / diamond dust starbursts. |
| `enablePaymentPulse` | `bool?` | `false` | Emits an expanding radar sonar wave on tap or payment. |
| `chipSlot` | `Widget?` | `null` | Slot to override the default EMV microchip. |
| `logoSlot` | `Widget?` | `null` | Slot to override the top-right brand logo. |
| `badgeSlot` | `Widget?` | `null` | Slot to render a custom status badge or tier label. |
| `onTap` | `VoidCallback?` | `null` | Optional callback when card is clicked/tapped. |
| `onPrivacyChanged` | `ValueChanged<bool>?` | `null` | Callback triggered when privacy masking toggles. |

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!  
Feel free to check the [issues page](https://github.com/ClevesDev/vertical_credit_card/issues).

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

