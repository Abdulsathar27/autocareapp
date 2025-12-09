import 'package:autocare/constants/app_strings.dart';
import 'package:autocare/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';


class RegisterButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const RegisterButton({
    super.key,
    required this.isLoading,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: AppStrings.register,
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}
