import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class AppTheme {
  // Light Theme 
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primaryGreen,
    fontFamily: GoogleFonts.poppins().fontFamily,
    // APP BAR THEME
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
    ),
    // TEXT SELECTION / CURSOR COLOR
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primaryGreen,
      selectionColor: AppColors.primaryGreen,
      selectionHandleColor: AppColors.primaryGreen,
    ),
    // INPUT DECORATION (TextFields)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      hintStyle: GoogleFonts.poppins(
        fontSize: AppSizes.fontMD,
        color: AppColors.textSecondary,
      ),
      labelStyle: GoogleFonts.poppins(
        fontSize: AppSizes.fontMD,
        color: AppColors.textPrimary,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.divider),
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: AppColors.primaryGreen, width: 1.4),
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
      ),
    ),

    // BUTTON THEMES
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        ),
        textStyle: GoogleFonts.poppins(
          fontSize: AppSizes.fontLG,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
        side: const BorderSide(color: AppColors.divider),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        ),
        textStyle: GoogleFonts.poppins(
          fontSize: AppSizes.fontLG,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // BOTTOM NAVIGATION BAR
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primaryGreen,
      unselectedItemColor: AppColors.textSecondary,
      selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      unselectedLabelStyle: GoogleFonts.poppins(),
      elevation: 10,
      type: BottomNavigationBarType.fixed,
    ),

    // TEXT COLOR & STYLING
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        color: AppColors.textPrimary,
        fontSize: AppSizes.fontLG,
      ),
      bodyMedium: GoogleFonts.poppins(
        color: AppColors.textPrimary,
        fontSize: AppSizes.fontMD,
      ),
      bodySmall: GoogleFonts.poppins(
        color: AppColors.textSecondary,
        fontSize: AppSizes.fontSM,
      ),
    ),
  );
}
