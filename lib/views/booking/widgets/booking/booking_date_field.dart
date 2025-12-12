import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/constants/app_sizes.dart';
import 'package:autocare/constants/app_strings.dart';
import 'package:autocare/controller/booking_provider.dart';
import 'package:autocare/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingDateField extends StatelessWidget {
  final TextEditingController controller;

  const BookingDateField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: AppStrings.selectDate,
      hint: AppStrings.pickADate,
      controller: controller,
      readOnly: true,
      suffixIcon: const Icon(
        Icons.calendar_month,
        size: AppSizes.iconMD1,
        color: AppColors.primaryGreen,
      ),

      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime(2050),
          initialDate: DateTime.now(),
        );

        if (picked != null) {
          controller.text = "${picked.day}/${picked.month}/${picked.year}";
          context.read<BookingProvider>().selectDate(picked);
        }
      },
    );
  }
}
