import 'package:autocare/constants/app_sizes.dart';
import 'package:autocare/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class AddVehicleFormFields extends StatelessWidget {
  final TextEditingController nameCtrl;
  final TextEditingController modelCtrl;
  final TextEditingController numberCtrl;
  const AddVehicleFormFields({
    super.key,
    required this.nameCtrl,
    required this.modelCtrl,
    required this.numberCtrl,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: "Vehicle Name",
          hint: "e.g. Honda City",
          controller: nameCtrl,
        ),
        const SizedBox(height: AppSizes.paddingMD),
        CustomTextField(
          label: "Vehicle Model",
          hint: "e.g. 2020 Model",
          controller: modelCtrl,
        ),
        const SizedBox(height: AppSizes.paddingMD),
        CustomTextField(
          label: "Vehicle Number",
          hint: "e.g. KL 14 B 4455",
          controller: numberCtrl,
        ),
      ],
    );
  }
}
