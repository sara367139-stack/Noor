import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  //======================
  // Light Theme
  //======================

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,

    scaffoldBackgroundColor: Colors.white,

    colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
).copyWith(
  onSurface: Colors.black,
),
   textTheme: GoogleFonts.cairoTextTheme().apply(
  bodyColor: Colors.black,
  displayColor: Colors.black,
),

    cardColor: Colors.white,

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    ),
  );

  //======================
  // Dark Theme
  //======================

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,

    scaffoldBackgroundColor: const Color(0xff102E4B),

    colorScheme: ColorScheme.fromSeed(
  seedColor: AppColors.primary,
  brightness: Brightness.dark,
).copyWith(
  onSurface: Colors.white,
),

   textTheme: GoogleFonts.cairoTextTheme(
  ThemeData.dark().textTheme,
).apply(
  bodyColor: Colors.white,
  displayColor: Colors.white,
),

    cardColor: const Color(0xff173B63),

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color(0xff102E4B),
      foregroundColor: Colors.white,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xff102E4B),
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.white70,
      type: BottomNavigationBarType.fixed,
    ),
  );
}