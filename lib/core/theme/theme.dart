import 'package:flutter/material.dart';

class AppTheme {
  // Primary Colors
  static const Color primaryColor = Color(0xFF5B6DEF);
  static const Color secondaryColor = Color(0xFF3A3F55);
  static const Color backgroundColor = Color(0xFF1E1E28);
  static const Color cardColor = Color(0xFF2A2C3A);
  static const Color textColor = Colors.white;

  // Typography
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 14,
    color: textColor,
  );

  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      cardColor: cardColor,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: secondaryColor,
        titleTextStyle: headingStyle,
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      textTheme: const TextTheme(
        displayLarge: headingStyle,       // replaces headline1
        titleLarge: subheadingStyle,      // replaces headline6
        bodyLarge: bodyStyle,             // replaces bodyText1
        bodyMedium: bodyStyle,            // replaces bodyText2
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        hintStyle: bodyStyle.copyWith(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: bodyStyle.copyWith(color: textColor),
        ),
      ),
    );
  }
}
