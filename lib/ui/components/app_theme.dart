import 'package:flutter/material.dart';

ThemeData makeAppTheme() {
  final kPrimaryColor = Color.fromRGBO(136, 14, 79, 1);
  final kPrimaryColorDark = Color.fromRGBO(96, 0, 39, 1);
  final kPrimaryColorLight = Color.fromRGBO(188, 71, 123, 1);
  final kSecondaryColorDark = Color.fromRGBO(0, 37, 26, 1);

  return ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: kPrimaryColor,
    primaryColorDark: kPrimaryColorDark,
    primaryColorLight: kPrimaryColorLight,
    secondaryHeaderColor: kSecondaryColorDark,
    accentColor: kPrimaryColor,
    backgroundColor: Colors.white,
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: kPrimaryColorDark,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColorLight),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColor),
      ),
      alignLabelWithHint: true,
    ),
    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.light(primary: kPrimaryColor),
      buttonColor: kPrimaryColor,
      splashColor: kPrimaryColorLight,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}
