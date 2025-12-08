import 'package:autocare/constants/app_strings.dart';
import 'package:autocare/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';


class PhoneField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: AppStrings.phoneNumber,
      hint: AppStrings.enterYourPhone,
      controller: controller,
      keyboardType: TextInputType.phone,
    );
  }
}
