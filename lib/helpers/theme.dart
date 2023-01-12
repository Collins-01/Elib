import 'package:flutter/material.dart';
import 'package:elib/helpers/colors.dart';

class elibTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme(
      primary: primaryColor,
      primaryContainer: primaryColor,
      secondary: primaryColor,
      secondaryContainer: Color(0x54000000),
      surface: primaryColor,
      background: Color(0xffF5F3F3),
      error: dangerColor,
      onPrimary: Colors.white,
      onSecondary: secondaryColor,
      onSurface: primaryColor,
      onBackground: primaryColor,
      onError: dangerColor,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    primaryColor: primaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    bottomAppBarColor: const Color(0xffF5FFFB),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Color(0xffF5FFFB),
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xffF5F3F3),
      elevation: 0,
    ),
    fontFamily: 'CabinetGrotesk',
    // textTheme: const TextTheme(
    //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    // ),
  );
  static ThemeData darkTheme = ThemeData.dark();
}
