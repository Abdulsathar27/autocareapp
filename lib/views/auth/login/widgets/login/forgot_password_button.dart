import 'package:autocare/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../constants/app_colors.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          AppStrings.forgotPasswordTitle,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: AppColors.primaryGreen,
          ),
        ),
      ),
    );
  }
}
