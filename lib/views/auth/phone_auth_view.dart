import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

import '../../core/widgets/custom_textfield.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/utils/helpers.dart';

class PhoneAuthView extends StatefulWidget {
  const PhoneAuthView({super.key});

  @override
  State<PhoneAuthView> createState() => _PhoneAuthViewState();
}

class _PhoneAuthViewState extends State<PhoneAuthView> {
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController otpCtrl = TextEditingController();

  bool isOtpSent = false;
  bool isLoading = false;

  String verificationId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Phone Verification",
          style: GoogleFonts.poppins(
            color: AppColors.textPrimary,
            fontSize: AppSizes.fontXL,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ---------------------------------------------------------
      // BODY
      // ---------------------------------------------------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            Text(
              isOtpSent
                  ? "Enter the 6-digit OTP sent to your phone"
                  : "Enter your phone number to receive OTP",
              style: GoogleFonts.poppins(
                color: AppColors.textSecondary,
                fontSize: AppSizes.fontMD,
              ),
            ),

            const SizedBox(height: 28),

            // ---------------------------------------------------------
            // PHONE INPUT
            // ---------------------------------------------------------
            if (!isOtpSent) ...[
              CustomTextField(
                label: "Phone Number",
                hint: "Enter your phone number",
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 26),

              // SEND OTP BUTTON
              CustomButton(
                text: "Send OTP",
                isLoading: isLoading,
                onPressed: () {
                  Helpers.showSnackBar(context, "OTP sending logic goes here");
                  setState(() {
                    isOtpSent = true;
                  });
                },
              ),
            ],

            // ---------------------------------------------------------
            // OTP INPUT
            // ---------------------------------------------------------
            if (isOtpSent) ...[
              CustomTextField(
                label: "OTP",
                hint: "Enter OTP",
                controller: otpCtrl,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 26),

              // VERIFY OTP BUTTON
              CustomButton(
                text: "Verify OTP",
                isLoading: isLoading,
                onPressed: () {
                  Helpers.showSnackBar(context, "Verify OTP Logic");
                },
              ),

              const SizedBox(height: 16),

              // RESEND OTP
              Center(
                child: TextButton(
                  onPressed: () {
                    Helpers.showSnackBar(context, "Resend OTP Logic");
                  },
                  child: Text(
                    "Resend OTP",
                    style: GoogleFonts.poppins(
                      fontSize: AppSizes.fontMD,
                      color: AppColors.primaryGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
