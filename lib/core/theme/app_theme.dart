import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  static final darkTheme = ThemeData(

    brightness: Brightness.dark,

    scaffoldBackgroundColor: const Color(0xFF0B0F19),

    primaryColor: const Color(0xFF00FF9C),

    textTheme: GoogleFonts.sourceCodeProTextTheme(),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0B0F19),
      elevation: 0,
    ),

    cardColor: const Color(0xFF1A2332),

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF00FF9C),
      secondary: Color(0xFF1A2332),
    ),

  );

}