import 'package:autotureid/const/resource.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    String image = isDarkMode ? R.ASSETS_IMAGES_LOGO_WHITE_PNG : R.ASSETS_IMAGES_LOGO_BLACK_PNG;

    return Image.asset(
      image,
      width: 200,
    );
  }
}
