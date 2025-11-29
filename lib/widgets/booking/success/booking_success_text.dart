import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_colors.dart';

class BookingSuccessText extends StatefulWidget {
  const BookingSuccessText({super.key});

  @override
  State<BookingSuccessText> createState() => _BookingSuccessTextState();
}

class _BookingSuccessTextState extends State<BookingSuccessText>
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _scale = Tween(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(
        scale: _scale,
        child: Column(
          children: [
            // Success Emoji / Icon
            Text(
              "🎉",
              style: TextStyle(
                fontSize: AppSizes.fontXXXL * 1.5,
              ),
            ),

            const SizedBox(height: 10),

            // MAIN TITLE
            Text(
              "Booking Confirmed!",
              style: GoogleFonts.poppins(
                fontSize: AppSizes.fontXXL,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 14),

            // DESCRIPTION
            Text(
              "Your service booking has been successfully submitted.\nWe’ll notify you when it's scheduled.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                height: 1.6,
                fontSize: AppSizes.fontMD,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
