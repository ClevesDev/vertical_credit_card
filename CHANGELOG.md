## 0.0.1

* **Native Vertical Orientation:** 100% focused on portrait cards following ISO/IEC 7810 ID-1 aspect ratio ($1 : 1.586$).
* **Interactive 3D Perspective Tilt:** Real-time gyroscopic/pointer deflection with realistic focal length and spring-back damping physics (`Curves.easeOutBack`).
* **Dynamic Specular Glare (`SpecularGlarePainter`):** Ambient lighting reflection that dynamically sweeps across the card surface according to the tilt angle.
* **180° 3D Flip Animation:** Hardware-accelerated perspective rotation revealing magnetic stripe, signature panel, and CVV on the back.
* **Tap-to-Reveal Privacy Mode:** Interactive number masking (`•••• •••• •••• 4321`) with eye toggle icon and tap gesture.
* **Special Financial States:**
  * `isFrozen`: Fractal ice crystal overlay with security padlock.
  * `isExpired`: Desaturated black & white styling with angled official `"EXPIRED"` stamp.
* **Extensible Background Architecture (`CardBackground`):**
  * Solid colors, linear/radial gradients, metallic brushed finishes, glassmorphism, custom painters, and arbitrary widget builders.
* **Curated Design Presets (`CardPresets`):**
  * **Family A (Neobank Modern):** `nubank`, `wise`.
  * **Family B (Luxury Heavy Metals):** `appleTitanium`, `amexCenturion`, `goldPrestige`.
  * **Family C (Cyberpunk & Web3):** `neonCyan`, `matrixGreen`.
  * **Family D (Abstract Art & Textures):** `painterlyGlobe` (Crédit Agricole orbital paint splatter), `topographicGold`, `carbonStealth`.
* **Holographic Rainbow Foil (`HoloSheenPainter`):** Iridescent shimmer reflecting dynamic spectrum light.
* **Apple Wallet Style Component (`VerticalCardStack`):** Vertical cascading multi-card stack with smooth spring expansion on selection.
* **Open-Closed Slot Injection:** Custom widgets for `bankLogo`, `chipWidget`, and `actionBadge`.
* **Zero External Dependencies:** Pure Flutter SDK with vector CustomPainters for EMV chips, contactless NFC waves, and brand badges (Visa, Mastercard, Amex, Discover).
