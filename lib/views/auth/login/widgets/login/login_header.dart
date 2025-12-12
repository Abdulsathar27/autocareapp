import 'package:autocare/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_assets.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 120,
          child: Image.network(
            AppAssets.loginScreen,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => const Icon(
              Icons.car_crash,
              size: 60,
              color: AppColors.primaryGreen,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          AppStrings.loginTitle,
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          AppStrings.loginSubtitle,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
