# 💳 Vertical Credit Card — Showcase & Studio App

This project demonstrates the complete capabilities of the [`vertical_credit_card`](https://pub.dev/packages/vertical_credit_card) Flutter package. It is an interactive design sandbox and production-grade fintech app demo engineered to run on **iOS, Android, Web, macOS, Windows, and Linux**.

---

## 🌟 App Features & Exploration Modes

The demo app includes three primary navigation modes accessible via the bottom navigation bar or header controls:

### 1. 🎨 Card Presets Showcase (`ShowcaseScreen`)
- **40+ Curated Presets:** Explore fine-art vector patterns, luxury metals, neobanks, gamer RGB, and regional fintech flagships.
- **Categorized Filters:** Easily filter cards by theme families:
  - *Neobank Modern* (Nubank, Wise, N26, Monzo Hot Coral)
  - *Luxury Heavy Metals* (Apple Titanium, Amex Centurion, Gold Prestige)
  - *3D Artist Landscapes* (Solar Eclipse, Desert Dune, Alpine Horizon, World Navigator, Great Wave, Golden Kintsugi, Cosmos Constellation, Art Deco Gold)
  - *Exotic Materials* (Skeleton NFC, Bamboo Eco, Damascus Steel, White Ceramic)
  - *Gamer & Esports RGB* (Razer Chroma 360° dynamic spectrum, Cyber PCB)
  - *Regional Flagships* (Nequi, Bancolombia, Mercado Pago, Hey Banco, Nubank Ultravioleta, Banco Inter, Lemon Cash, Ualá, Yape, Tenpo, Robinhood Gold, Cash App)
- **Interactive Gestures:** Drag or hover over any card to experience hardware-accelerated 3D perspective tilt and dynamic specular light sweep.
- **Hardware Flip:** Tap the card to smoothly flip 180° and inspect the magnetic stripe, security hologram sticker, and signature panel.

### 2. 🎛️ Live Customizer Studio & Fintech Banking Dashboard
- **Live Parameter Controls:** Real-time sliders and toggles for tilt sensitivity, specular glare sweep, holographic sheen, hot foil finishes, perimeter edge glow, diamond dust glitter, privacy masking, and frozen/expired states.
- **Fintech Banking App Mockup:**
  - Realistic neobank account balance with multi-currency country switcher:
    - 🇺🇸 **United States:** USD (`$`)
    - 🇬🇧 **United Kingdom:** GBP (`£`)
    - 🇨🇴 **Colombia:** COP (`$`)
    - 🇲🇽 **Mexico:** MXN (`$`)
    - 🇵🇪 **Peru:** PEN (`S/.`)
    - 🇨🇱 **Chile:** CLP (`$`)
  - **Dynamic Rolling CVV:** Tap "Rotate CVV" to watch odometer / slot-machine rolling digit animations (`RollingDigitText`).
  - **One-Tap Code Generator:** Generate and copy clean Dart code for your customized card configuration directly to your clipboard.

### 3. 👛 Apple Wallet Multi-Card Stack (`VerticalCardStack`)
- Overlapping vertical cascade stack inspired by Apple Wallet and Google Pay.
- Tap any card to smoothly expand it with spring physics (`Curves.easeOutBack`), bringing its balance and details into focus.

### 4. 💳 Synchronized Checkout Form (`VerticalCardInputForm`)
- Real-time auto-formatting input fields for card numbers (`1234 5678...`), expiry dates (`MM/YY`), cardholder names, and CVV.
- **CVV Focus Auto-Flip:** The 3D card preview automatically rotates 180° to the back face as soon as the user focuses the CVV field, and flips back to the front when moving to other fields.

---

## 🚀 Running the Example App

Ensure you have the Flutter SDK installed on your machine (`flutter --version >= 3.10.0`).

### On Desktop (Windows / macOS / Linux)

```bash
# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

### On Web (Chrome)

```bash
flutter run -d chrome
```

### On Mobile (Android / iOS)

```bash
# List available simulators/devices
flutter devices

# Run on selected device or simulator
flutter run
```

---

## 📂 Example Source Code Structure

```
example/
├── lib/
│   └── main.dart            # Complete demo implementation with Showcase, Studio, Wallet & Form
├── test/
│   └── widget_test.dart     # Comprehensive integration tests verifying all 3 demo views & interactions
└── pubspec.yaml             # Example app manifest referencing local package via path: ../
```

---

## 📄 License

This example is part of the `vertical_credit_card` project and is open-sourced under the [MIT License](../LICENSE).
