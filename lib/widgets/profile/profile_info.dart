import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class ProfileInfo extends StatelessWidget {
  final String name;
  final String email;
  final String phone;

  const ProfileInfo({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: GoogleFonts.poppins(
            fontSize: AppSizes.fontXL,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          email,
          style: GoogleFonts.poppins(
            fontSize: AppSizes.fontMD,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          phone,
          style: GoogleFonts.poppins(
            fontSize: AppSizes.fontMD,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
