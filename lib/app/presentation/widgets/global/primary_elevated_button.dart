import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';

class PrimaryElevatedButton extends StatelessWidget {
  const PrimaryElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.dense = false,
    this.disabled = false,
    this.style,
    this.borderRadius = 6,
    this.white = false,
    this.primaryColor = false,
  });

  final String text;
  final VoidCallback onPressed;
  final double? width;
  final bool dense;
  final bool disabled;
  final ButtonStyle? style;
  final double borderRadius;
  final bool white;
  final bool primaryColor;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final backgroundColor = primaryColor
        ? color.primary
        : white
            ? Colors.white
            : color.onSurface;
    final textColor = primaryColor
        ? Colors.black
        : white
            ? Colors.black
            : color.surface;

    return ElevatedButton(
      onPressed: onPressed,
      style: style ??
          ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            minimumSize: width != null
                ? Size(width!, 56.0)
                : dense
                    ? null
                    : const Size(double.infinity, 56.0),
          ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: kFontweightBold,
          color: textColor,
        ),
      ),
    );
  }
}
