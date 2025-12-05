import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/contollers/booking_provider.dart';
import 'package:autocare/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingTimeField extends StatelessWidget {
  final TextEditingController controller;

  const BookingTimeField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: "Select Time",
      hint: "Pick a time",
      controller: controller,
      readOnly: true,
      suffixIcon: const Icon(Icons.access_time_filled,
          size: 22, color: AppColors.primaryGreen),
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (picked != null) {
          controller.text = picked.format(context);
          context.read<BookingProvider>().selectTime(controller.text);
        }
      },
    );
  }
}
