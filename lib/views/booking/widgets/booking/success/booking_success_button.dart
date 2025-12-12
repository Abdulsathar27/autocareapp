import 'package:autocare/constants/app_strings.dart';
import 'package:autocare/controller/booking_form_provider.dart';
import 'package:autocare/controller/home_nav_provider.dart';
import 'package:autocare/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingSuccessButton extends StatelessWidget {
  const BookingSuccessButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeNavProvider, BookingFormProvider>(
      builder: (context, value, value2, child) => CustomButton(
        text: AppStrings.goToHome,
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/home",
            (route) => false,
          );
          value.setIndex(0);
          value2.clear();
        
        },

      ),
    );
  }
}
