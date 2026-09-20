import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vertical_credit_card/vertical_credit_card.dart';

/// Helper utility for generating and copying customized Dart code to the clipboard.
///
/// Enables developers to tweak visual parameters in the Studio and immediately
/// export a ready-to-run Dart snippet for their own Flutter projects.
class CodeExportHelper {
  /// Generates a clean Dart widget instantiation string based on active studio settings.
  static String generateSnippet({
    required double width,
    required bool enableTilt,
    required bool enableGlare,
    required bool enableHolo,
    required CardTextFinish textFinish,
    required bool enableEdgeGlow,
    required bool enableDiamondDust,
    required bool enablePaymentPulse,
    required MetalType metalType,
    required ChipColor chipColor,
    required double borderRadius,
  }) {
    return '''
// ---------------------------------------------------------------------------
// Vertical Credit Card - Generated Custom Widget Configuration
// ---------------------------------------------------------------------------
// Step 1: Add dependency to pubspec.yaml:
//   dependencies:
//     vertical_credit_card: ^0.0.4
//
// Step 2: Import the package in your Dart file:
//   import 'package:vertical_credit_card/vertical_credit_card.dart';
//
// Step 3: Embed the widget directly in your screen tree:
VerticalCard(
  cardNumber: '4000 1234 5678 9010',
  cardHolder: 'DIMAS CLEVES',
  expiryDate: '12/30',
  cvv: '888',
  width: $width,
  enable3DTilt: $enableTilt,
  enableSpecularGlare: $enableGlare,
  enableHolographicFoil: $enableHolo,
  textFinish: CardTextFinish.${textFinish.name},
  enableEdgeGlow: $enableEdgeGlow,
  enableDiamondDust: $enableDiamondDust,
  enablePaymentPulse: $enablePaymentPulse,
  cardTheme: VerticalCardTheme.metallic(
    metalType: MetalType.${metalType.name},
    chipColor: ChipColor.${chipColor.name},
    borderRadius: BorderRadius.circular($borderRadius),
  ),
)''';
  }

  /// Copies the generated Dart code to the system clipboard and notifies the user via SnackBar.
  static void copyToClipboard(
    BuildContext context, {
    required double width,
    required bool enableTilt,
    required bool enableGlare,
    required bool enableHolo,
    required CardTextFinish textFinish,
    required bool enableEdgeGlow,
    required bool enableDiamondDust,
    required bool enablePaymentPulse,
    required MetalType metalType,
    required ChipColor chipColor,
    required double borderRadius,
  }) {
    final code = generateSnippet(
      width: width,
      enableTilt: enableTilt,
      enableGlare: enableGlare,
      enableHolo: enableHolo,
      textFinish: textFinish,
      enableEdgeGlow: enableEdgeGlow,
      enableDiamondDust: enableDiamondDust,
      enablePaymentPulse: enablePaymentPulse,
      metalType: metalType,
      chipColor: chipColor,
      borderRadius: borderRadius,
    );

    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('✅ Dart code copied to clipboard!'),
        backgroundColor: Colors.teal[800],
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
