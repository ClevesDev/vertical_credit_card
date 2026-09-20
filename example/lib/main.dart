import 'package:flutter/material.dart';
import 'src/screens/checkout_screen.dart';
import 'src/screens/showcase_screen.dart';
import 'src/screens/studio_screen.dart';
import 'src/screens/wallet_screen.dart';

/// Entry point for the Vertical Credit Card interactive demonstration application.
///
/// This application showcases the full capabilities of `vertical_credit_card`:
/// - **Showcase**: Interactive 3D gallery featuring 44 curated design presets.
/// - **Wallet**: Apple Wallet style cascading stack with spring physics.
/// - **Checkout**: Payment form with real-time card synchronization and auto-flip.
/// - **Studio**: Live parameter sandbox with real-time sliders and code generator.
void main() {
  runApp(const VerticalCardDemoApp());
}

/// Root application widget configuring dark fintech theme aesthetics.
class VerticalCardDemoApp extends StatelessWidget {
  /// Creates the demo root application.
  const VerticalCardDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vertical Credit Card Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0C10),
        colorScheme: const ColorScheme.dark(
          primary: Colors.cyanAccent,
          secondary: Colors.amberAccent,
          surface: Color(0xFF141722),
        ),
        useMaterial3: true,
      ),
      home: const CardShowcaseScreen(),
    );
  }
}

/// Primary container screen hosting the navigation bar and indexed screen stack.
class CardShowcaseScreen extends StatefulWidget {
  /// Creates the primary showcase container.
  const CardShowcaseScreen({super.key});

  @override
  State<CardShowcaseScreen> createState() => _CardShowcaseScreenState();
}

class _CardShowcaseScreenState extends State<CardShowcaseScreen> {
  int _selectedNavIndex = 0;
  bool _isPrivacyMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vertical Credit Card',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          if (_selectedNavIndex == 0)
            IconButton(
              tooltip: _isPrivacyMode
                  ? 'Disable Privacy Mode'
                  : 'Enable Privacy Mode',
              icon: Icon(
                _isPrivacyMode
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                color: _isPrivacyMode ? Colors.amberAccent : Colors.white70,
              ),
              onPressed: () {
                setState(() {
                  _isPrivacyMode = !_isPrivacyMode;
                });
              },
            ),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedNavIndex,
          children: [
            ShowcaseScreen(
              isPrivacyMode: _isPrivacyMode,
              onPrivacyModeChanged: (val) =>
                  setState(() => _isPrivacyMode = val),
            ),
            const WalletScreen(),
            const CheckoutScreen(),
            const StudioScreen(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedNavIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedNavIndex = index),
        backgroundColor: const Color(0xFF0F1118),
        indicatorColor: Colors.cyanAccent.withValues(alpha: 0.18),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.threed_rotation_rounded),
            label: 'Showcase',
          ),
          NavigationDestination(
            icon: Icon(Icons.wallet_rounded),
            label: 'Wallet',
          ),
          NavigationDestination(
            icon: Icon(Icons.payment_rounded),
            label: 'Checkout',
          ),
          NavigationDestination(
            icon: Icon(Icons.tune_rounded),
            label: 'Studio',
          ),
        ],
      ),
    );
  }
}
