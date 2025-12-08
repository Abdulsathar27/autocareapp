import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/constants/app_sizes.dart';
import 'package:autocare/constants/app_strings.dart';
import 'package:autocare/contollers/booking_provider.dart';
import 'package:autocare/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BookingServiceField extends StatelessWidget {
  final TextEditingController controller;

  const BookingServiceField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: AppStrings.selectService,
      hint: AppStrings.chooseYourService,
      controller: controller,
      readOnly: true,
      suffixIcon: const Icon(
        Icons.arrow_forward_ios,
        size: AppSizes.iconSM,
        color: AppColors.textSecondary,
      ),
      onTap: () async {
        await Navigator.pushNamed(context, "/booking-services");

        // update UI after selecting service
        final booking = context.read<BookingProvider>();
        controller.text = booking.selectedServiceName ?? "";
      },
    );
  }
}
