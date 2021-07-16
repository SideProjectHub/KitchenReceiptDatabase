import 'package:flutter/material.dart';

class CustomDefaultTheme {
  static ThemeData get defaultTheme {
    return ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.black,

      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      ),
    );
  }
}
