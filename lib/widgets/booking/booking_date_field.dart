import 'package:flutter/material.dart';
import '../../core/widgets/custom_textfield.dart';
import '../../constants/app_colors.dart';
import '../../providers/booking_provider.dart';
import 'package:provider/provider.dart';

class BookingDateField extends StatelessWidget {
  final TextEditingController controller;

  const BookingDateField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: "Select Date",
      hint: "Pick a date",
      controller: controller,
      readOnly: true,
      suffixIcon: const Icon(
        Icons.calendar_month,
        size: 22,
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
          // UI String
          controller.text = "${picked.day}/${picked.month}/${picked.year}";

          // Provider VALUE (DateTime)
          context.read<BookingProvider>().selectDate(picked);
        }
      },
    );
  }
}
