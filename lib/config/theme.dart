import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Avenir',
    textTheme: textTheme(),
  );
}

TextTheme textTheme() {
  return TextTheme(
    displayLarge: TextStyle(color: Colors.white,fontSize: 24, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.bold),
    displaySmall: TextStyle(color: Colors.white,fontSize: 14, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(color: Colors.white,fontSize: 12, fontWeight: FontWeight.normal),
    bodySmall: TextStyle(color: Colors.white,fontSize: 10, fontWeight: FontWeight.normal),
  );
}