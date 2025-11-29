import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

// Custom widgets

import '../../widgets/booking/success/booking_success_text.dart';
import '../../widgets/booking/success/booking_success_button.dart';

class BookingSuccessView extends StatelessWidget {
  const BookingSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.paddingLG),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(height: 30),
                BookingSuccessText(),
                SizedBox(height: 40),
                BookingSuccessButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
