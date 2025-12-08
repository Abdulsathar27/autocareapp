import 'package:autocare/constants/app_strings.dart';
import 'package:autocare/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';


class BookingSuccessButton extends StatelessWidget {
  const BookingSuccessButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: AppStrings.goToHome,
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/home",
          (route) => false,
        );
      },
    );
  }
}
