# Contributing to vertical_credit_card

Thank you for your interest in contributing to `vertical_credit_card`! We welcome contributions from developers and designers worldwide.

## Code of Conduct
Please review and adhere to our [Code of Conduct](CODE_OF_CONDUCT.md) in all project spaces.

---

## Development Setup

1. **Fork and clone the repository:**
   ```bash
   git clone https://github.com/<your-username>/vertical_credit_card.git
   cd vertical_credit_card
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   cd example && flutter pub get && cd ..
   ```

3. **Run the test suite:**
   ```bash
   # Core package tests
   flutter test

   # Example app widget tests
   cd example && flutter test && cd ..
   ```

4. **Verify static analysis and formatting:**
   ```bash
   dart format --set-exit-if-changed .
   flutter analyze
   ```

---

## Proposing Changes & Pull Requests

1. **Create a topic branch:**
   ```bash
   git checkout -b feat/my-awesome-preset
   ```

2. **Design Guidelines for New Presets:**
   - **Pure Flutter SDK:** All vector patterns, textures, and finishes MUST be implemented via pure `CustomPainter` or standard Flutter widgets. Do NOT introduce heavy asset bundles, raster images, or third-party dependencies.
   - **Performance:** Ensure CustomPainters avoid allocating expensive objects (e.g. `Paint` instantiation) repeatedly inside `paint()`.
   - **ID-1 Aspect Ratio:** Remember that cards use the vertical ID-1 standard ($1 : 1.586$). Ensure any background art leaves the chip and card number zones uncluttered.

3. **Format & Test:**
   ```bash
   dart format .
   flutter test
   flutter analyze
   ```

4. **Submit a Pull Request:**
   - Use our PR template.
   - Reference any related open issues (`Fixes #...` or `Closes #...`).
   - Include visual screenshots or screen recordings for any UI changes.

---

## Questions or Ideas?
Feel free to open an issue or start a discussion on GitHub!
