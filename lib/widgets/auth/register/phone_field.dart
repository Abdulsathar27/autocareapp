import 'package:flutter/material.dart';
import '../../../core/widgets/custom_textfield.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: "Phone Number",
      hint: "Enter your phone",
      controller: controller,
      keyboardType: TextInputType.phone,
    );
  }
}
