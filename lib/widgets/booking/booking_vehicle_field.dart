import 'package:autocare/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/custom_textfield.dart';
import '../../constants/app_colors.dart';
import '../../providers/booking_provider.dart';

class BookingVehicleField extends StatelessWidget {
  final TextEditingController controller;

  const BookingVehicleField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: "Select Vehicle",
      hint: "Choose your vehicle",
      controller: controller,
      readOnly: true,
      suffixIcon: const Icon(
        Icons.arrow_forward_ios,
        size: AppSizes.iconSM,
        color: AppColors.textSecondary,
      ),
      onTap: () async {
        await Navigator.pushNamed(context, "/vehicle-list");

        // Update text when returning
        final booking = context.read<BookingProvider>();
        controller.text = booking.selectedVehicle ?? "";
      },
    );
  }
}
