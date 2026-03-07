import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF0B0F19),

    textTheme: GoogleFonts.sourceCodeProTextTheme(),

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF00FF9C),
      secondary: Color(0xFF1A2332),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0B0F19),
      elevation: 0,
    ),
  );
}