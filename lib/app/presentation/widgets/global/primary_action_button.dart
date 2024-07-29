import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';

class PrimaryActionButton extends StatelessWidget {
  const PrimaryActionButton({
    super.key,
    required this.text,
    this.padding,
    this.radiusOnlyRight = true,
    this.fontSize = 24,
    this.onTap,
  });

  final String text;
  final EdgeInsetsGeometry? padding;
  final bool radiusOnlyRight;
  final double fontSize;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.black : color.primary;
    final backgroundColor = isDarkMode ? color.primary : color.onSurface;
    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.horizontal(
          right: radiusOnlyRight ? const Radius.circular(100) : Radius.zero,
          left: radiusOnlyRight ? Radius.zero : const Radius.circular(100),
        ),
        child: InkWell(
          borderRadius: BorderRadius.horizontal(
            right: radiusOnlyRight ? const Radius.circular(100) : Radius.zero,
            left: radiusOnlyRight ? Radius.zero : const Radius.circular(100),
          ),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(32, 8, 16, 8),
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
                fontWeight: kFontweightSemiBold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
