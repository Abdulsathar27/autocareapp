import 'package:flutter/material.dart';
import '../../../core/widgets/custom_button.dart';

class BookingSuccessButton extends StatelessWidget {
  const BookingSuccessButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "Go to Home",
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
