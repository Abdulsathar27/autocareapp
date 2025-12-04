import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_textfield.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: "Password",
      hint: "Enter your password",
      controller: controller,
      isPassword: true,
    );
  }
}
