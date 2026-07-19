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

    scaffoldBackgroundColor: const Color.fromARGB(255, 159, 161, 169),

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

    cardColor: const Color.fromARGB(255, 208, 205, 205),

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color.fromARGB(255, 159, 161, 169),
      foregroundColor: Colors.black,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 219, 216, 216),
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
    surface: const Color(0xff173B63),
    onSurface: Colors.white,
  ),

  textTheme: GoogleFonts.cairoTextTheme(
    ThemeData.dark().textTheme,
  ).apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),

  cardColor: const Color(0xff173B63),

  cardTheme: const CardThemeData(
    color: Color(0xff173B63),
    elevation: 0,
  ),

  iconTheme: const IconThemeData(
    color: Colors.white,
  ),

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