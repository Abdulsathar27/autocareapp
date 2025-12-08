import 'package:autocare/constants/app_strings.dart';
import 'package:autocare/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
      

class NameField extends StatelessWidget {
  final TextEditingController controller;
  const NameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: AppStrings.fullName,
      hint: AppStrings.enterYourName,
      controller: controller,
    );
  }
}
