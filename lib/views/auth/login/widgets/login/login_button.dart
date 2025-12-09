import 'package:autocare/constants/app_strings.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_button.dart';

class LoginButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const LoginButton({
    super.key,
    required this.isLoading,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: AppStrings.login,
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}
