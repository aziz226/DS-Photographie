import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const bg = Color(0xFF0A0A0A);
  static const gold = Color(0xFFC9A84C);
  static const goldLight = Color(0xFFE0C96E);
  static const goldDark = Color(0xFFA88A3A);
  static const white = Color(0xFFF0ECE3);
  static const whiteDim = Color(0xFFB0ADA6);
  static const bordeaux = Color(0xFF3D0F1E);
  static const card = Color(0xFF111111);
  static const border = Color(0xFF1E1E1E);
  static const dark = Color(0xFF080808);
}

class AppTheme {
  static TextStyle cinzel({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w700,
    Color color = AppColors.white,
    double letterSpacing = 1.0,
    double height = 1.2,
  }) {
    return GoogleFonts.cinzel(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle cormorant({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.whiteDim,
    double letterSpacing = 1.0,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return GoogleFonts.cormorantGaramond(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      fontStyle: fontStyle,
    );
  }

  static TextStyle dmSans({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.whiteDim,
    double letterSpacing = 0.5,
    double height = 1.6,
  }) {
    return GoogleFonts.dmSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }
}
