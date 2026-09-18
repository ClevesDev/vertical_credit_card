import 'package:flutter/material.dart';

/// An animated rolling digit / odometer text widget.
///
/// Ideal for dynamic rotating CVV security codes, virtual card regeneration,
/// and live updating balances. Each numeric digit rolls vertically with
/// realistic slot-machine / odometer physics, while non-digit characters
/// (spaces, hyphens, symbols) remain static.
class RollingDigitText extends StatefulWidget {
  /// The string value to display and animate.
  final String text;

  /// The text style applied to all characters.
  final TextStyle? style;

  /// Base duration for each digit roll animation.
  final Duration duration;

  /// Staggered delay offset between successive digits.
  final Duration staggerDelay;

  /// Animation curve for the rolling transition.
  final Curve curve;

  const RollingDigitText({
    super.key,
    required this.text,
    this.style,
    this.duration = const Duration(milliseconds: 650),
    this.staggerDelay = const Duration(milliseconds: 45),
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<RollingDigitText> createState() => _RollingDigitTextState();
}

class _RollingDigitTextState extends State<RollingDigitText> {
  @override
  Widget build(BuildContext context) {
    final defaultStyle = DefaultTextStyle.of(context).style;
    final effectiveStyle = (widget.style ?? defaultStyle).copyWith(
      fontFeatures: const [FontFeature.tabularFigures()],
    );

    // Measure character dimensions using TextPainter
    final textPainter = TextPainter(
      text: TextSpan(text: '8', style: effectiveStyle),
      textDirection: TextDirection.ltr,
    )..layout();

    final digitHeight = textPainter.height;
    final digitWidth = textPainter.width;

    final chars = widget.text.split('');

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(chars.length, (index) {
        final char = chars[index];
        final digit = int.tryParse(char);

        if (digit == null) {
          // Static non-digit character (space, dot, dash, etc.)
          return Text(char, style: effectiveStyle);
        }

        return _SingleRollingDigit(
          key: ValueKey('rolling_digit_${index}_$char'),
          digit: digit,
          style: effectiveStyle,
          digitHeight: digitHeight,
          digitWidth: digitWidth,
          duration: widget.duration + (widget.staggerDelay * index),
          curve: widget.curve,
        );
      }),
    );
  }
}

class _SingleRollingDigit extends StatefulWidget {
  final int digit;
  final TextStyle style;
  final double digitHeight;
  final double digitWidth;
  final Duration duration;
  final Curve curve;

  const _SingleRollingDigit({
    super.key,
    required this.digit,
    required this.style,
    required this.digitHeight,
    required this.digitWidth,
    required this.duration,
    required this.curve,
  });

  @override
  State<_SingleRollingDigit> createState() => _SingleRollingDigitState();
}

class _SingleRollingDigitState extends State<_SingleRollingDigit>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentDigit = 0;
  int _targetDigit = 0;

  @override
  void initState() {
    super.initState();
    _currentDigit = widget.digit;
    _targetDigit = widget.digit;
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(
            begin: _targetDigit.toDouble(), end: _targetDigit.toDouble())
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve));
  }

  @override
  void didUpdateWidget(covariant _SingleRollingDigit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.digit != widget.digit) {
      _currentDigit = oldWidget.digit;
      _targetDigit = widget.digit;

      // Always roll forward (e.g. 8 -> 2 spins 8 -> 9 -> 0 -> 1 -> 2)
      double start = _currentDigit.toDouble();
      double end = _targetDigit.toDouble();
      if (end < start) {
        end += 10.0;
      }

      _controller.duration = widget.duration;
      _animation = Tween<double>(begin: start, end: end).animate(
        CurvedAnimation(parent: _controller, curve: widget.curve),
      );
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.digitWidth,
      height: widget.digitHeight,
      child: ClipRect(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            // Modulo 10 keeps the reel within 0..9 repeat window
            final val = _animation.value % 10.0;
            return Stack(
              children: List.generate(11, (i) {
                // Digits 0 to 9, plus a duplicate 0 at index 10 for smooth wrapping
                final displayChar = (i % 10).toString();
                final topOffset = (i - val) * widget.digitHeight;

                // Only render visible or near-visible digits
                if (topOffset < -widget.digitHeight ||
                    topOffset > widget.digitHeight) {
                  return const SizedBox.shrink();
                }

                return Positioned(
                  top: topOffset,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      displayChar,
                      style: widget.style,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
