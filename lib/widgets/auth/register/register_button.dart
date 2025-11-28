import 'package:flutter/material.dart';
import '../../../core/widgets/custom_button.dart';

class RegisterButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const RegisterButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "Register",
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}
