import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/custom_textfield.dart';
import '../../constants/app_colors.dart';
import '../../providers/booking_provider.dart';

class BookingServiceField extends StatelessWidget {
  final TextEditingController controller;

  const BookingServiceField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: "Select Service",
      hint: "Choose your service",
      controller: controller,
      readOnly: true,
      suffixIcon: const Icon(
        Icons.arrow_forward_ios,
        size: 18,
        color: AppColors.textSecondary,
      ),
      onTap: () async {
        await Navigator.pushNamed(context, "/booking-services");

        // update UI after selecting service
        final booking = context.read<BookingProvider>();
        controller.text = booking.selectedService ?? "";
      },
    );
  }
}
