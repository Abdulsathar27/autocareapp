import 'package:autocare/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';


class RegisterPasswordField extends StatelessWidget {
  final TextEditingController controller;

  const RegisterPasswordField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: "Password",
      hint: "Create a password",
      controller: controller,
      isPassword: true,
    );
  }
}
