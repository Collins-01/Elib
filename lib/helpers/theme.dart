import 'package:flutter/material.dart';
import 'package:elib/helpers/colors.dart';

class elibTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    // bluePrimaryColor: bluePrimaryColor,
    primaryColor: bluePrimaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Color(0xffF5FFFB),
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xffF5F3F3),
      elevation: 0,
    ),
    fontFamily: 'CabinetGrotesk',
    colorScheme: const ColorScheme(
      primary: bluePrimaryColor,
      // primaryContainer: bluePrimaryColor,
      primaryContainer: bluePrimaryColor,
      secondary: bluePrimaryColor,
      secondaryContainer: Color(0x54000000),
      surface: bluePrimaryColor,
      background: Color(0xffF5F3F3),
      error: dangerColor,
      onPrimary: Colors.white,
      onSecondary: secondaryColor,
      onSurface: bluePrimaryColor,
      onBackground: bluePrimaryColor,
      onError: dangerColor,
      brightness: Brightness.light,
    ).copyWith(background: Colors.white),

    // bottomAppBarTheme: const BottomAppBarTheme(
    //   color: Color(0xffF5FFFB),
    // ),
    // textTheme: const TextTheme(
    //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    // ),
  );
  static ThemeData darkTheme = ThemeData.dark();
}
