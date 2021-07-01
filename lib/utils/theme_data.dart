import 'package:flutter/material.dart';

class MyThemeData {
  static ThemeData light = ThemeData(
    colorScheme: ColorScheme.light(),
    primaryColor: Colors.deepPurple,
    scaffoldBackgroundColor: ColorScheme.light().background,
    applyElevationOverlayColor: true,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: ColorScheme.light().secondaryVariant,
        fontWeight: FontWeight.w800,
      ),
      bodyText1: TextStyle(
        color: ColorScheme.light().primaryVariant,
      ),
      subtitle1: TextStyle(
        color: ColorScheme.light().onSurface,
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    colorScheme: ColorScheme.dark(),
    scaffoldBackgroundColor: ColorScheme.dark().background,
    applyElevationOverlayColor: true,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: ColorScheme.dark().secondary,
        fontWeight: FontWeight.w800,
      ),
      bodyText1: TextStyle(
        color: ColorScheme.dark().primary,
      ),
      subtitle1: TextStyle(
        color: ColorScheme.dark().onSurface,
      ),
    ),
  );
}
