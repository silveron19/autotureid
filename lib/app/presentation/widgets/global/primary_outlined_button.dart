import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';

class PrimaryOutlinedButton extends StatelessWidget {
  const PrimaryOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.dense = false,
    this.disabled = false,
    this.transparent = false,
    this.style,
    this.rounded = true,
    this.borderRadius,
  });

  final String text;
  final VoidCallback onPressed;
  final double? width;
  final bool dense;
  final bool disabled;
  final bool transparent;
  final ButtonStyle? style;
  final bool rounded;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return OutlinedButton(
      onPressed: onPressed,
      style: style ??
          OutlinedButton.styleFrom(
            backgroundColor: disabled ? kDisableColor : Colors.transparent,
            shape: rounded
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 6),
                  )
                : null,
            minimumSize: width != null
                ? Size(width!, 56.0)
                : dense
                    ? null
                    : const Size(double.infinity, 56.0),
          ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: disabled ? color.onPrimary : color.onSurface,
        ),
      ),
    );
  }
}
