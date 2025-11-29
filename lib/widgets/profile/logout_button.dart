import 'package:autocare/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_sizes.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutButton({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: OutlinedButton(
        onPressed: onLogout,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.redButton, width: 1.4),
        ),
        child: Text(
          "Logout",
          style: GoogleFonts.poppins(
            fontSize: AppSizes.fontLG,
            fontWeight: FontWeight.w600,
            color: AppColors.redButton,
          ),
        ),
      ),
    );
  }
}
