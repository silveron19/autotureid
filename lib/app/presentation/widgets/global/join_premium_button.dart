import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';

class JoinPremiumButton extends StatelessWidget {
  const JoinPremiumButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.black : color.primary;
    final backgroundColor = isDarkMode ? color.primary : color.onSurface;
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 8, 16, 8),
      margin: const EdgeInsets.only(bottom: kDefaultPadding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(100),
        ),
      ),
      child: Text(
        'Gabung Premium',
        style: TextStyle(
          fontSize: 24,
          color: textColor,
          fontWeight: kFontweightSemiBold,
        ),
      ),
    );
  }
}
