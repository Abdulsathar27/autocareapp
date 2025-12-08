import 'package:autocare/constants/app_strings.dart';
import 'package:autocare/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';


class RegisterEmailField extends StatelessWidget {
  final TextEditingController controller;

  const RegisterEmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: AppStrings.email,
      hint: AppStrings.enterYourEmail,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
    );
  }
}
