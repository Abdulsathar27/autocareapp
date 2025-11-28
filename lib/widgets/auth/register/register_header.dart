import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';

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
            errorBuilder: (_, __, ___) => const Icon(
              Icons.app_registration,
              size: 60,
              color: AppColors.primaryGreen,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Create Account",
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Start your vehicle care experience",
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
