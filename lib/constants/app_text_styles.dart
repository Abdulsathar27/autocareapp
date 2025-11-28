import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_sizes.dart';

class AppTextStyles {
  // ----------------------------------------------------------
  // HEADINGS
  // ----------------------------------------------------------
  static TextStyle headingXL = GoogleFonts.poppins(
    fontSize: AppSizes.fontXXL,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle headingLG = GoogleFonts.poppins(
    fontSize: AppSizes.fontXL,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle headingMD = GoogleFonts.poppins(
    fontSize: AppSizes.fontLG,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // ----------------------------------------------------------
  // SUBTITLES
  // ----------------------------------------------------------
  static TextStyle subtitle = GoogleFonts.poppins(
    fontSize: AppSizes.fontMD,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  // ----------------------------------------------------------
  // BODY TEXT
  // ----------------------------------------------------------
  static TextStyle body = GoogleFonts.poppins(
    fontSize: AppSizes.fontMD,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static TextStyle bodySmall = GoogleFonts.poppins(
    fontSize: AppSizes.fontSM,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // ----------------------------------------------------------
  // LABELS & FORM TEXT
  // ----------------------------------------------------------
  static TextStyle label = GoogleFonts.poppins(
    fontSize: AppSizes.fontSM,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle hint = GoogleFonts.poppins(
    fontSize: AppSizes.fontMD,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // ----------------------------------------------------------
  // BUTTON TEXT
  // ----------------------------------------------------------
  static TextStyle button = GoogleFonts.poppins(
    fontSize: AppSizes.fontLG,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
