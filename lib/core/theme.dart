import 'package:flutter/material.dart';

const _white = Color(0xffFFFFFF);
const _black = Color(0xff1E1E1E);
const _grey = Color(0xffA8A8A8);

const _primary = Color(0xffEBC58D);

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: "SegoeUI",
    colorScheme: const ColorScheme.light(
      primary: _primary,
      onPrimary: _white,
      background: _white,
      onBackground: _black,
      surface: _white,
      surfaceVariant: Colors.transparent,
      onSurface: _black,
      onSurfaceVariant: _grey,
      shadow: _grey,
    ),
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0.0,
      surfaceTintColor: _white,
      elevation: 5,
      shadowColor: Colors.black,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 22,
        color: _black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(_black),
        foregroundColor: MaterialStateProperty.all<Color>(_white),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return _white.withOpacity(0.2);
            }
            return _black;
          },
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(
            color: _black,
            width: 2.0,
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(_white),
        foregroundColor: MaterialStateProperty.all<Color>(_black),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return _black.withOpacity(0.2);
            }
            return _white;
          },
        ),
      ),
    ),
    checkboxTheme: const CheckboxThemeData(
      side: BorderSide(
        color: _grey,
        width: 2.0,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: _primary,
    ),
    datePickerTheme: DatePickerThemeData(
      cancelButtonStyle: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(_primary),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(_primary),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: "SegoeUI",
    colorScheme: const ColorScheme.dark(
      primary: _primary,
      onPrimary: _black,
      background: _black,
      onBackground: _white,
      surface: _black,
      surfaceVariant: Colors.transparent,
      onSurface: _white,
      onSurfaceVariant: _grey,
      shadow: _grey,
    ),
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0.0,
      surfaceTintColor: _black,
      elevation: 5,
      shadowColor: Colors.black,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 22,
        color: _white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(_white),
        foregroundColor: MaterialStateProperty.all<Color>(_black),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return _black.withOpacity(0.2);
            }
            return _white;
          },
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(
            color: _white,
            width: 2.0,
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(_black),
        foregroundColor: MaterialStateProperty.all<Color>(_white),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return _white.withOpacity(0.2);
            }
            return _black;
          },
        ),
      ),
    ),
    checkboxTheme: const CheckboxThemeData(
      side: BorderSide(
        color: _grey,
        width: 2.0,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: _primary,
    ),
    datePickerTheme: DatePickerThemeData(
      cancelButtonStyle: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(_primary),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(_primary),
      ),
    ),
  );
}
