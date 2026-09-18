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
* **Synchronized Checkout Form (`VerticalCardInputForm`):** Auto-formatting inputs (`4444 4444...`, `MM/YY`, `CVV`), real-time brand detection, and automatic 3D flip to back on CVV focus.
* **Security Hologram Sticker (`SecurityHologramPainter`):** Realistic metallic rainbow diffraction security foil with vector globe & wave patterns.
* **Live Card Customizer Studio:** Interactive sandbox in example app with live sliders for card parameters, material presets, and one-tap "Copy Dart Code".
* **Hot Foil 3D Stamping & Embossing (`CardTextFinish`):** Physical typography relief with realistic Gold Foil, Silver Foil, Rose Gold Foil, and Embossed letterpress with directional highlights.
* **Cyber Edge Glow (`CyberEdgeGlowPainter`):** Continuous animated neon perimeter beam tracing the card's rounded border in a smooth loop.
* **Contactless NFC Payment Pulse (`PaymentPulsePainter`):** Interactive expanding radar/sonar wave radiating outward across the card surface on tap or payment.
* **Diamond Dust / Micro-Glitter Sparkles (`DiamondDustPainter`):** Realistic micro-particles that twinkle with 4-point starburst flares based on the 3D tilt coordinates.
* **Chromatic Fluid Mesh Background (`CardBackground.fluid`):** Organic, morphing liquid mesh gradients with smooth harmonic motion (Revolut Metal & Apple Card style).
* **Defrost Melt Transition:** Smooth ice-melting animation when transitioning from `isFrozen: true` to `false`.
* **Open-Closed Slot Injection:** Custom widgets for `bankLogo`, `chipWidget`, and `actionBadge`.
* **Exotic Physical Materials & Textures:**
  * `skeletonNfc` (`NfcAntennaPainter`): Transparent skeleton card with concentric copper NFC antenna coils, traces, and micro solder pads (Nothing Phone & Revolut Ultra style).
  * `bambooEco` (`WoodGrainPainter`): Organic natural bamboo wood grain with warm golden tones and sustainable botanical accents.
  * `damascusSteel` (`DamascusSteelPainter`): Forged Damascus steel with distinctive wavy water-pattern metal folds and silver foil lettering.
  * `whiteCeramic`: Apple Watch Edition inspired immaculate pure polished white ceramic with silver foil typography.
* **Gamer & Esports / RGB Chroma:**
  * `razerChroma`: Stealth matte chassis with animated 360-degree dynamic RGB Chroma spectrum edge glow (`isRgbChroma: true`).
  * `cyberPcb` (`PcbCircuitPainter`): High-tech printed circuit board with 45°/90° routing lines, gold vias, and microchip footprints.
* **Expanded Global Fintech Presets:**
  * 🇵🇪 Perú: `CardPresets.yape` (vibrant purple with cyan neon accents).
  * 🇨🇱 Chile: `CardPresets.tenpo` (electric teal and dark petrol gradient).
  * 🇬🇧 United Kingdom: `CardPresets.monzoHotCoral` (fluorescent hot coral salmon with black chip).
  * 🇺🇸 United States: `CardPresets.robinhoodGold` (matte champagne gold with specular sheen) & `CardPresets.cashApp` (stealth obsidian with neon green accents).
* **Crypto Web3 Hardware:**
  * `ledgerObsidian`: Cold wallet hardware aesthetic with micro monospace details and silver foil stamping.
  * `solanaAurora`: Iridescent Web3 purple-to-emerald gradient with holographic foil finish.
* **Dynamic Rolling Digit Component (`RollingDigitText`):**
  * Smooth vertical odometer / slot-machine digit rolling animation with realistic physics and staggered character delays for dynamic CVV codes, virtual card regeneration, and live balances.
* **Interactive Studio Banking App Enhancements:**
  * Multi-country switcher with native currencies (`PEN S/.`, `CLP $`, `GBP £`, `USD $`) and local merchants.
  * Real-time "Rotate CVV" action triggering live `RollingDigitText` odometer spins.
* **3D Artist Patterns & Procedural Landscapes (Family I):**
  * `solarEclipse` (`SolarEclipsePainter`): Minimalist total solar eclipse with liquid gold corona and diamond ring lens flare on obsidian.
  * `desertDune` (`DesertDunePainter`): Warm architectural desert sand dunes at sunset with sharp metallic gold ridge highlights.
  * `alpineHorizon` (`AlpineHorizonPainter`): Minimalist layered mountain range silhouettes with sun/moon, twilight sky, and gold ridge highlights.
  * `worldNavigator` (`WorldMapPainter`): Stylized continents map with geodesic global flight path arcs and coordinates.
  * `greatWave` (`GreatWavePainter`): Japanese Ukiyo-e surging ocean wave pattern with foam crests.
  * `goldenKintsugi` (`KintsugiPainter`): Organic fractured veins filled with liquid molten gold over dark ceramic.
  * `cosmosConstellation` (`ConstellationPainter`): Star map with geometric constellations and celestial coordinate rings.
  * `artDecoGold` (`ArtDecoPainter`): 1920s symmetrical fan arches and stepped gold lines.
* **Zero External Dependencies:** Pure Flutter SDK with vector CustomPainters for EMV chips, contactless NFC waves, security hologram, and brand badges (Visa, Mastercard, Amex, Discover).

