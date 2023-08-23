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
    secondaryHeaderColor: Colors.grey.shade600,
    hintColor: Colors.grey.shade800,
  );

// dark theme
  static final darkTheme = ThemeData(
    fontFamily: 'yekan',
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.grey.shade100,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Colors.grey.shade100,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        color: Colors.grey.shade100,
        fontSize: 14.0,
      ),
      bodyMedium: const TextStyle(
        color: Colors.white,
        fontSize: 12.0,
      ),
    ),
    cardColor: Colors.grey.shade800,
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: const Color(0xFF4991e5),
  );
}
