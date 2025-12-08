import 'package:autocare/constants/app_assets.dart';
import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Image.network(
            AppAssets.registerScreen,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => const Icon(
              Icons.app_registration,
              size: 60,
              color: AppColors.primaryGreen,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          AppStrings.registerTitle,
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          AppStrings.registerSubtitle,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
