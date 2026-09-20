import 'package:flutter/material.dart';
import 'package:vertical_credit_card/vertical_credit_card.dart';
import '../data/mock_banking_data.dart';

/// Interactive mockup of a real-world mobile banking application feed.
///
/// Embeds the customized [VerticalCard] inside a full fintech dashboard
/// chassis with status bars, live account balances, rolling dynamic CVVs,
/// interactive freeze/privacy toggles, and localized merchant transaction feeds.
class BankingAppShell extends StatelessWidget {
  /// Active country code (e.g., 'GLOBAL', 'CO', 'MX', 'UK').
  final String countryCode;

  /// Callback when a new country/account is selected from the bottom sheet.
  final ValueChanged<String> onCountryChanged;

  /// Width constraint for the embedded vertical card inside the mockup.
  final double cardWidth;

  /// Border radius applied to the card chassis.
  final double cardBorderRadius;

  /// Dynamic rotating CVV value for display.
  final String dynamicCvv;

  /// Callback to regenerate the dynamic CVV value.
  final VoidCallback onRegenerateCvv;

  /// Whether the card is currently in a frozen state.
  final bool isFrozen;

  /// Callback to toggle the frozen state.
  final VoidCallback onToggleFrozen;

  /// Whether the card numbers are masked for privacy.
  final bool isPrivacyMode;

  /// Callback to toggle privacy mode.
  final VoidCallback onTogglePrivacy;

  /// Whether the balance is hidden.
  final bool hideBalance;

  /// Callback to toggle balance visibility.
  final VoidCallback onToggleHideBalance;

  /// 3D tilt physics toggle.
  final bool enableTilt;

  /// Specular glare reflection toggle.
  final bool enableGlare;

  /// Holographic rainbow foil toggle.
  final bool enableHolo;

  /// Maximum tilt angle in radians.
  final double maxTiltAngle;

  /// Active typography finish.
  final CardTextFinish textFinish;

  /// Perimeter beam edge glow toggle.
  final bool enableEdgeGlow;

  /// Diamond dust micro-glitter toggle.
  final bool enableDiamondDust;

  /// Contactless NFC pulse wave toggle.
  final bool enablePaymentPulse;

  /// Callback to toggle payment pulse.
  final VoidCallback onTogglePaymentPulse;

  /// Default constructor for the banking app mockup shell.
  const BankingAppShell({
    super.key,
    required this.countryCode,
    required this.onCountryChanged,
    required this.cardWidth,
    required this.cardBorderRadius,
    required this.dynamicCvv,
    required this.onRegenerateCvv,
    required this.isFrozen,
    required this.onToggleFrozen,
    required this.isPrivacyMode,
    required this.onTogglePrivacy,
    required this.hideBalance,
    required this.onToggleHideBalance,
    required this.enableTilt,
    required this.enableGlare,
    required this.enableHolo,
    required this.maxTiltAngle,
    required this.textFinish,
    required this.enableEdgeGlow,
    required this.enableDiamondDust,
    required this.enablePaymentPulse,
    required this.onTogglePaymentPulse,
  });

  void _showAccountSelectorSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF0F1420),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 38,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Icon(Icons.account_balance_wallet_rounded,
                        size: 20, color: Colors.cyanAccent),
                    SizedBox(width: 8),
                    Text(
                      'Select Active Account & Region',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Switching accounts updates currency, live card and local merchant transactions.',
                  style: TextStyle(fontSize: 12, color: Colors.white54),
                ),
                const SizedBox(height: 14),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: MockBankingData.accounts.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 6),
                    itemBuilder: (context, index) {
                      final acc = MockBankingData.accounts[index];
                      final isSelected = countryCode == acc.code;
                      final color = acc.color;

                      return InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () {
                          onCountryChanged(acc.code);
                          Navigator.pop(sheetContext);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? color.withValues(alpha: 0.12)
                                : const Color(0xFF141926),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? color
                                  : Colors.white.withValues(alpha: 0.06),
                              width: isSelected ? 1.2 : 0.8,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                acc.flag,
                                style: const TextStyle(fontSize: 22),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      acc.country,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        color:
                                            isSelected ? color : Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${acc.account} · ${acc.card}',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.white54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  acc.currency,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: color,
                                  ),
                                ),
                              ),
                              if (isSelected) ...[
                                const SizedBox(width: 8),
                                Icon(Icons.check_circle_rounded,
                                    size: 18, color: color),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = MockBankingData.getProfile(countryCode, cardBorderRadius);
    final cardMockupWidth = cardWidth.clamp(190.0, 225.0);

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 360),
      decoration: BoxDecoration(
        color: const Color(0xFF0B0E14),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 24,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Bar Mockup
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '9:41',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.white70,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.signal_cellular_alt_rounded,
                      size: 13,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.wifi_rounded,
                      size: 13,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.battery_full_rounded,
                      size: 14,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // User Profile Header
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Colors.cyanAccent, Colors.blueAccent],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyanAccent.withValues(alpha: 0.3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'DC',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello, Dimas 👋',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      InkWell(
                        borderRadius: BorderRadius.circular(6),
                        onTap: () => _showAccountSelectorSheet(context),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 1.5,
                                ),
                                decoration: BoxDecoration(
                                  color: profile.accountTagColor
                                      .withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: profile.accountTagColor
                                        .withValues(alpha: 0.4),
                                    width: 0.6,
                                  ),
                                ),
                                child: Text(
                                  profile.accountTag,
                                  style: TextStyle(
                                    fontSize: 8.5,
                                    fontWeight: FontWeight.w800,
                                    color: profile.accountTagColor,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  profile.accountType,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 14,
                                color: profile.accountTagColor
                                    .withValues(alpha: 0.9),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_none_rounded, size: 20),
                  color: Colors.white70,
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Account Balance Card HUD
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF121620),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TOTAL AVAILABLE BALANCE',
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          color: Colors.white.withValues(alpha: 0.55),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: onToggleHideBalance,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            hideBalance
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            size: 16,
                            color: Colors.cyanAccent.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            hideBalance ? '••••••••' : profile.balance,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 6),
                          InkWell(
                            borderRadius: BorderRadius.circular(6),
                            onTap: () => _showAccountSelectorSheet(context),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 1),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    profile.currency,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.cyanAccent,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 14,
                                    color: Colors.cyanAccent
                                        .withValues(alpha: 0.8),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 3.5,
                        ),
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFF00FFC2).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color:
                                const Color(0xFF00FFC2).withValues(alpha: 0.35),
                            width: 0.8,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.trending_up_rounded,
                              size: 13,
                              color: Color(0xFF00FFC2),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              profile.trend,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF00FFC2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Live Customized Vertical Card Embedded
            Center(
              child: VerticalCard(
                cardNumber: profile.cardNumber,
                cardHolder: profile.cardHolder,
                expiryDate: '12/30',
                cvv: dynamicCvv,
                bankName: profile.bankName,
                width: cardMockupWidth,
                isFrozen: isFrozen,
                isPrivacyMode: isPrivacyMode,
                enable3DTilt: enableTilt,
                enableSpecularGlare: enableGlare,
                enableHolographicFoil: enableHolo,
                maxTiltAngle: maxTiltAngle,
                textFinish: textFinish,
                enableEdgeGlow: enableEdgeGlow,
                enableDiamondDust: enableDiamondDust,
                enablePaymentPulse: enablePaymentPulse,
                cardTheme: profile.activeCardTheme,
              ),
            ),

            const SizedBox(height: 10),

            // Dynamic Security CVV Odometer Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF141926),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.cyanAccent.withValues(alpha: 0.25),
                  width: 0.8,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.shield_outlined,
                    size: 14,
                    color: Colors.cyanAccent,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'CVV: ',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white70,
                    ),
                  ),
                  RollingDigitText(
                    text: dynamicCvv,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w900,
                      color: Colors.cyanAccent,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(6),
                    onTap: onRegenerateCvv,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.cyanAccent.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.cyanAccent.withValues(alpha: 0.4),
                          width: 0.8,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.refresh_rounded,
                            size: 12,
                            color: Colors.cyanAccent,
                          ),
                          SizedBox(width: 3),
                          Text(
                            'Rotate CVV',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: Colors.cyanAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Card Interactive Action Controls
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    icon: isFrozen
                        ? Icons.ac_unit_rounded
                        : Icons.lock_outline_rounded,
                    label: isFrozen ? 'Unfreeze' : 'Freeze',
                    isActive: isFrozen,
                    activeColor: Colors.cyanAccent,
                    onTap: onToggleFrozen,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _ActionButton(
                    icon: Icons.contactless_rounded,
                    label: enablePaymentPulse ? 'NFC Active' : 'Tap to Pay',
                    isActive: enablePaymentPulse,
                    activeColor: const Color(0xFF00FFC2),
                    onTap: () {
                      onTogglePaymentPulse();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            enablePaymentPulse
                                ? '📡 Contactless payment radar activated'
                                : '⏸️ Contactless payment paused',
                          ),
                          backgroundColor: Colors.teal[800],
                          duration: const Duration(milliseconds: 1200),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _ActionButton(
                    icon: isPrivacyMode
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    label: isPrivacyMode ? 'Show' : 'Hide',
                    isActive: isPrivacyMode,
                    activeColor: Colors.amberAccent,
                    onTap: onTogglePrivacy,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Recent Transactions Section
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.cyanAccent.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            ...profile.transactions.map(
              (tx) => Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: _TransactionTile(
                  title: tx['title'] as String,
                  subtitle: tx['subtitle'] as String,
                  amount: tx['amount'] as String,
                  time: tx['time'] as String,
                  isIncome: tx['isIncome'] as bool,
                  icon: tx['icon'] as IconData,
                  iconBg: tx['iconBg'] as Color,
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Home Bar Indicator
            Center(
              child: Container(
                width: 110,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final Color activeColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? activeColor.withValues(alpha: 0.18)
              : const Color(0xFF161A26),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive
                ? activeColor.withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 17,
              color: isActive ? activeColor : Colors.white70,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? activeColor : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final String time;
  final bool isIncome;
  final IconData icon;
  final Color iconBg;

  const _TransactionTile({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.time,
    required this.isIncome,
    required this.icon,
    required this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF121622),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 18,
              color: isIncome ? const Color(0xFF00FFC2) : Colors.white70,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withValues(alpha: 0.45),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: isIncome ? const Color(0xFF00FFC2) : Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                time,
                style: TextStyle(
                  fontSize: 9.5,
                  color: Colors.white.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
