import 'package:flutter/material.dart';

class MyTheme {
  // light theme
  static final lightTheme = ThemeData(
    fontFamily: 'shabnam',
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.grey.shade800,
        fontSize: 19.0,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 17.0,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: TextStyle(
        color: Colors.grey.shade800,
        fontSize: 14.0,
      ),
      labelMedium: TextStyle(
        color: Colors.grey.shade800,
        fontSize: 14.0,
      ),
      bodyMedium: TextStyle(
        color: Colors.grey.shade800,
        fontSize: 12.0,
      ),
    ),
    iconTheme: IconThemeData(color: Colors.grey.shade800),
    cardColor: Colors.white,
    primaryColor: const Color(0xFFFFBF00),
    secondaryHeaderColor: Colors.grey.shade700,
    hintColor: Colors.grey.shade800,
    shadowColor: Colors.grey.shade200,
  );

// dark theme
  static final darkTheme = ThemeData(
    fontFamily: 'shabnam',
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.grey.shade100,
        fontSize: 19.0,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Colors.grey.shade100,
        fontSize: 17.0,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: TextStyle(
        color: Colors.grey.shade100,
        fontSize: 14.0,
      ),
      labelMedium: TextStyle(
        color: Colors.grey.shade100,
        fontSize: 14.0,
      ),
      bodyMedium: TextStyle(
        color: Colors.grey.shade100,
        fontSize: 12.0,
      ),
    ),
    cardColor: const Color(0xFF222222),
    scaffoldBackgroundColor: const Color(0xFF191919),
    primaryColor: const Color(0xFFFFBF00),
    secondaryHeaderColor: Colors.grey.shade100,
    shadowColor: Colors.black12,
  );
}
