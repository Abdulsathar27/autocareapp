import 'package:autocare/constants/app_strings.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_textfield.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: AppStrings.password,
      hint: AppStrings.enterYourPassword,
      controller: controller,
      isPassword: true,
    );
  }
}
