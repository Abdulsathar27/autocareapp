import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_colors.dart';

class BookingSuccessText extends StatelessWidget {
  const BookingSuccessText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Booking Confirmed!",
          style: GoogleFonts.poppins(
            fontSize: AppSizes.fontXXL,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          "Your service booking has been successfully submitted.\nWe’ll notify you when it's scheduled.",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            height: 1.5,
            fontSize: AppSizes.fontMD,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
