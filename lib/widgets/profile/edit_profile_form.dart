import 'package:flutter/material.dart';
import '../../core/widgets/custom_textfield.dart';
import '../../constants/app_sizes.dart';

class EditProfileForm extends StatelessWidget {
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController phoneCtrl;

  const EditProfileForm({
    super.key,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.phoneCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: "Full Name",
          controller: nameCtrl,
          hint: "Enter your name",
        ),
        const SizedBox(height: AppSizes.paddingMD),

        CustomTextField(
          label: "Email",
          controller: emailCtrl,
          hint: "Enter your email",
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: AppSizes.paddingMD),

        CustomTextField(
          label: "Phone Number",
          controller: phoneCtrl,
          hint: "Enter your phone number",
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }
}
