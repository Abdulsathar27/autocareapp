import 'package:flutter/material.dart';
import '../../../core/widgets/custom_textfield.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;
  const NameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: "Full Name",
      hint: "Enter your name",
      controller: controller,
    );
  }
}
