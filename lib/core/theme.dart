import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CyberpunkTheme {
  static const Color background = Color(0xFF0D0208); // Near black
  static const Color neonCyan = Color(0xFF00FFFF);
  static const Color neonPink = Color(0xFFFA00FF);
  static const Color neonYellow = Color(0xFFF7EB00);
  static const Color gridGrey = Color(0xFF1E1E1E);
  static const Color textBody = Color(0xFFE0E0E0);

  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        primary: neonCyan,
        secondary: neonPink,
        surface: gridGrey,
        onSurface: textBody,
      ),
      textTheme: GoogleFonts.orbitronTextTheme().apply(
        bodyColor: textBody,
        displayColor: neonCyan,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: neonCyan,
          side: const BorderSide(color: neonCyan, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: const BeveledRectangleBorder(),
          textStyle: GoogleFonts.orbitron(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }

  static BoxDecoration neonBox({Color color = neonCyan}) {
    return BoxDecoration(
      border: Border.all(color: color, width: 2),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.5),
          blurRadius: 10,
          spreadRadius: 2,
        ),
      ],
    );
  }
}
