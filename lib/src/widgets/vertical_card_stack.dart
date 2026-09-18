import 'package:flutter/material.dart';

/// An interactive vertical card stack widget inspired by Apple Wallet and Revolut.
///
/// Lays out cards in an overlapping vertical cascade. Tapping a card expands it
/// into primary focus with smooth spring physics, while other cards gracefully slide
/// down. Tapping again collapses back to the compact wallet view.
class VerticalCardStack extends StatefulWidget {
  /// The list of cards to display in the stack.
  final List<Widget> cards;

  /// Vertical spacing between collapsed cards in the stack.
  final double cardSpacing;

  /// Height allotted to each card container in the stack.
  final double cardHeight;

  /// Optional initial selected card index.
  final int? initialIndex;

  /// Callback notified whenever a card is tapped and selected/deselected.
  /// Passes `null` when collapsed back to the full stack.
  final ValueChanged<int?>? onCardSelected;

  /// Animation duration for expanding and collapsing cards.
  final Duration animationDuration;

  /// Animation curve for the spring transition.
  final Curve animationCurve;

  /// Creates a [VerticalCardStack].
  const VerticalCardStack({
    super.key,
    required this.cards,
    this.cardSpacing = 64.0,
    this.cardHeight = 380.0,
    this.initialIndex,
    this.onCardSelected,
    this.animationDuration = const Duration(milliseconds: 400),
    this.animationCurve = Curves.easeOutBack,
  });

  @override
  State<VerticalCardStack> createState() => _VerticalCardStackState();
}

class _VerticalCardStackState extends State<VerticalCardStack> {
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _handleCardTap(int index) {
    setState(() {
      if (_selectedIndex == index) {
        _selectedIndex = null;
      } else {
        _selectedIndex = index;
      }
    });
    widget.onCardSelected?.call(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cards.isEmpty) {
      return const SizedBox.shrink();
    }

    final totalCards = widget.cards.length;
    // Calculate total height when collapsed
    final collapsedHeight =
        (totalCards - 1) * widget.cardSpacing + widget.cardHeight;
    final totalHeight = _selectedIndex != null
        ? widget.cardHeight + (totalCards > 1 ? 90.0 : 0.0)
        : collapsedHeight;

    return AnimatedContainer(
      duration: widget.animationDuration,
      curve: Curves.easeOutCubic,
      height: totalHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(totalCards, (index) {
          final isSelected = _selectedIndex == index;
          final isAnySelected = _selectedIndex != null;

          double topPosition;
          double scale = 1.0;
          double opacity = 1.0;

          if (!isAnySelected) {
            // Normal stacked cascade
            topPosition = index * widget.cardSpacing;
          } else if (isSelected) {
            // Selected card moves to the very top in full view
            topPosition = 0.0;
            scale = 1.02;
          } else if (index < _selectedIndex!) {
            // Cards above the selected one tuck away slightly
            topPosition = -30.0 * (_selectedIndex! - index);
            opacity = 0.0;
          } else {
            // Cards below the selected one slide down into a mini deck
            topPosition = widget.cardHeight +
                20.0 +
                ((index - _selectedIndex! - 1) * 16.0);
            scale = 0.94 - ((index - _selectedIndex! - 1) * 0.02);
            opacity = 0.85;
          }

          return AnimatedPositioned(
            key: ValueKey(index),
            duration: widget.animationDuration,
            curve: widget.animationCurve,
            top: topPosition,
            left: 0,
            right: 0,
            child: AnimatedScale(
              duration: widget.animationDuration,
              curve: widget.animationCurve,
              scale: scale,
              child: AnimatedOpacity(
                duration: widget.animationDuration,
                curve: Curves.easeInOut,
                opacity: opacity,
                child: Center(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _handleCardTap(index),
                    child: widget.cards[index],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
