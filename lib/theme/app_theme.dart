import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFFBFFF00);
  static const Color darkGrey = Color(0xFF2C2C2C);

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: darkGrey,
    primaryColor: primaryGreen,
    colorScheme: ColorScheme.dark(primary: primaryGreen, surface: darkGrey),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: Colors.white,
        fontSize: 20.h,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: Colors.white,
        fontSize: 14.h,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
      labelLarge: TextStyle(color: Colors.white60, fontSize: 16),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white10,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      hintStyle: TextStyle(color: Colors.white54),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white60,
    primaryColor: primaryGreen,
    colorScheme: ColorScheme.light(primary: primaryGreen),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: Colors.black,
        fontSize: 26.h,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: Colors.black,
        fontSize: 14.h,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black54),
      labelLarge: TextStyle(color: Colors.black45, fontSize: 16),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white60,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      hintStyle: TextStyle(color: Colors.black54),
    ),
  );
}
