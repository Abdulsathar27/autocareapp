import 'package:flutter/material.dart';
import '../../../core/widgets/custom_textfield.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: "Email",
      hint: "Enter your email",
      controller: controller,
      keyboardType: TextInputType.emailAddress,
    );
  }
}
