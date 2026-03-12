import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  static final darkTheme = ThemeData(

    brightness: Brightness.dark,

    scaffoldBackgroundColor: const Color(0xFF0B0F19),

    primaryColor: const Color(0xFF00FF9C),

    cardColor: const Color(0xFF1A2332),

    useMaterial3: true,

    textTheme: GoogleFonts.sourceCodeProTextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0B0F19),
      elevation: 0,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00FF9C),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(

      filled: true,
      fillColor: const Color(0xFF1A2332),

      labelStyle: const TextStyle(
        color: Colors.white70,
      ),

      hintStyle: const TextStyle(
        color: Colors.white54,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.white24,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.white24,
        ),
      ),

      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF00FF9C),
          width: 2,
        ),
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF1A2332),
      labelStyle: const TextStyle(color: Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF00FF9C),
      secondary: Color(0xFF1A2332),
      surface: Color(0xFF1A2332),
      background: Color(0xFF0B0F19),
    ),

  );

}