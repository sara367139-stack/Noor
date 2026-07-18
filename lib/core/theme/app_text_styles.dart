import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Splash
  static final TextStyle splashTitle = GoogleFonts.cairo(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static final TextStyle splashSubtitle = GoogleFonts.cairo(
    fontSize: 16,
    color: AppColors.white70,
  );

  // Display
  static final TextStyle displayLarge = GoogleFonts.cairo(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static final TextStyle displaySmall = GoogleFonts.cairo(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Headings
  static final TextStyle heading1 = GoogleFonts.cairo(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static final TextStyle heading2 = GoogleFonts.cairo(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static final TextStyle heading3 = GoogleFonts.cairo(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Body
  static final TextStyle bodyMedium = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static final TextStyle bodySmall = GoogleFonts.cairo(
    fontSize: 14,
    color: AppColors.textSecondary,
  );
}