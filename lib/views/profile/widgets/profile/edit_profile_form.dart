import 'package:autocare/constants/app_sizes.dart';
import 'package:autocare/constants/app_strings.dart';
import 'package:autocare/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

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
          label: AppStrings.fullName,
          controller: nameCtrl,
          hint: AppStrings.enterYourName,
        ),
        const SizedBox(height: AppSizes.paddingMD),
        CustomTextField(
          label: AppStrings.email,
          controller: emailCtrl,
          hint: AppStrings.enterYourEmail,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: AppSizes.paddingMD),
        CustomTextField(
          label: AppStrings.phoneNumber,
          controller: phoneCtrl,
          hint: AppStrings.enterYourPhone,
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }
}
