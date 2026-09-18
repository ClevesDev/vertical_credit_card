# 💳 vertical_credit_card

<div align="center">

[![pub package](https://img.shields.io/badge/pub.dev-0.0.1-blue.svg)](https://pub.dev/packages/vertical_credit_card)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?logo=flutter&logoColor=white)](https://flutter.dev)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/ClevesDev/vertical_credit_card/pulls)

**A sleek, modern, vertical credit and debit card widget for Flutter fintech applications.**  
Supports 3D flip animations, metallic textures, glassmorphism, and frozen card states with **zero external dependencies**.

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

- 📱 **100% Native Vertical Orientation:** Designed specifically for portrait mobile screens following the modern ID-1 portrait format (Nubank, Revolut, BBVA).
- 🔄 **3D Flip Animation:** Smooth, hardware-accelerated 3D perspective rotation when tapping the card to inspect the CVV, signature line, and magnetic stripe on the back.
- 🎨 **3 Built-in Design Templates:**
  - **Flat / Solid:** Clean neo-bank aesthetics with rich solid colors or smooth gradients.
  - **Metallic Luxury:** Realistic brushed titanium, gold, silver, obsidian, and rose gold with specular highlights.
  - **Glassmorphic Cyber:** Translucent frosted glass with `BackdropFilter` blur and glowing neon edges.
- 🧊 **"Frozen / Locked" State:** Instant visual feedback for frozen cards with a crystalline ice frost overlay, desaturation, and a glowing security lock.
- 🛡️ **Zero Dependencies:** Pure Flutter SDK. The EMV chip, contactless NFC waves, and brand badges are all rendered natively with vector custom painters—zero asset loading hassle, zero version conflicts.
- 🔍 **Card Brand Auto-detection:** Automatically recognizes Visa, Mastercard, American Express, Discover, and more from the card number.

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

### 1. Flat Neo-Bank Card (Nubank / BBVA Style)

```dart
VerticalCard.flat(
  cardNumber: '5412 8888 1024 4321',
  cardHolder: 'JUAN PÉREZ',
  expiryDate: '08/29',
  cvv: '821',
  bankName: 'NU',
  backgroundColor: const Color(0xFF820AD1), // Nubank signature purple
  onTap: () => print('Card tapped!'),
)
```

### 2. Metallic Luxury Card (Apple Card / Amex Centurion Style)

```dart
VerticalCard.metallic(
  cardNumber: '3782 822468 005',
  cardHolder: 'ELENA ROJAS',
  expiryDate: '11/30',
  cvv: '342',
  bankName: 'PLATINUM',
  metalType: MetalType.brushedTitanium, // .gold, .silver, .obsidian, .roseGold
)
```

### 3. Glassmorphic Cyber Card (Web3 / Crypto Wallet Style)

```dart
VerticalCard.glass(
  cardNumber: '4123 4567 8901 2345',
  cardHolder: 'ALEXANDER WRIGHT',
  expiryDate: '05/28',
  cvv: '912',
  bankName: 'AURORA',
  neonColor: Colors.cyanAccent,
  isFrozen: isCardBlocked, // Freezes the card with ice texture and lock icon!
)
```

---

## 🛠️ Parameters

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `cardNumber` | `String` | Card number string (formatted or unformatted). |
| `cardHolder` | `String` | Cardholder name. |
| `expiryDate` | `String` | Expiration date in `MM/YY` format. |
| `cvv` | `String` | 3 or 4 digit CVV/CVC code displayed on the back. |
| `bankName` | `String?` | Optional bank or fintech brand name displayed at the top. |
| `brand` | `CardBrand?` | Card network brand (auto-detected if omitted). |
| `isFrozen` | `bool` | When `true`, freezes the card with an icy overlay and lock icon. |
| `enableFlip` | `bool` | Whether tapping the card flips it between front and back (default: `true`). |
| `width` | `double` | Card width (default: `240.0`). Height is automatically calculated at $1 : 1.586$. |
| `onTap` | `VoidCallback?` | Callback triggered when the card is pressed. |

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!  
Feel free to check the [issues page](https://github.com/ClevesDev/vertical_credit_card/issues).

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
