import 'package:autocare/constants/app_strings.dart';
import 'package:autocare/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';


class RegisterPasswordField extends StatelessWidget {
  final TextEditingController controller;

  const RegisterPasswordField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: AppStrings.password,
      hint: AppStrings.createYourPassword,
      controller: controller,
      isPassword: true,
    );
  }
}
