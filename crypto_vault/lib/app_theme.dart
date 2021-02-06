import 'package:flutter/material.dart';

import 'package:crypto_vault/constants.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: primaryColor,
    accentColor: secondaryColor,
    canvasColor: backgroundColor,
    scaffoldBackgroundColor: backgroundColor,
    fontFamily: 'ProximaNova',
    splashColor: Colors.purpleAccent.withOpacity(0.2),
    brightness: Brightness.dark,
    textTheme: ThemeData.light().textTheme.copyWith(
      bodyText1: TextStyle(
        color: textLight,
      ),
      bodyText2: TextStyle(
        color: textDark,
      ),
      headline6: TextStyle(
        fontFamily: 'Nunito',
        color: textLight,
      ),
      headline5: TextStyle(
        fontFamily: 'Nunito',
        color: textLight,
      ),
      headline4: TextStyle(
        fontFamily: 'Nunito',
        color: textLight,
      ),
      button: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14,
        letterSpacing: 1,
        color: purple,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}