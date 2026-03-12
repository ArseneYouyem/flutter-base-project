import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFEC5B13);
  static const Color secondaryColor = Color(0xFFFDECE5);
  static const Color backgroundColor = Colors.white;
  static const Color textDark = Color(0xFF1E1E1E);
  static const Color textLight = Color(0xFF757575);

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        surface: backgroundColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.inter(
          color: textDark,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: GoogleFonts.inter(color: textDark),
        bodyMedium: GoogleFonts.inter(color: textLight),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textDark),
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        unselectedItemColor: textLight,
        showUnselectedLabels: true,
      ),
    );
  }
}
