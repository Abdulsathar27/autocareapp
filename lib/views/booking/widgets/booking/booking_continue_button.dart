import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/constants/app_strings.dart';
import 'package:autocare/contollers/booking_provider.dart';
import 'package:autocare/core/utils/helpers.dart';
import 'package:autocare/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingContinueButton extends StatelessWidget {
  final bool isLoading;
  final TextEditingController vehicleCtrl;
  final TextEditingController serviceCtrl;
  final TextEditingController dateCtrl;
  final TextEditingController timeCtrl;

  const BookingContinueButton({
    super.key,
    required this.isLoading,
    required this.vehicleCtrl,
    required this.serviceCtrl,
    required this.dateCtrl,
    required this.timeCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: AppStrings.continueTexts,
      isLoading: isLoading,
      onPressed: () {
        // VALIDATION -----------------------------------------------------
        if (vehicleCtrl.text.isEmpty ||
            serviceCtrl.text.isEmpty ||
            dateCtrl.text.isEmpty ||
            timeCtrl.text.isEmpty) {
          Helpers.showSnackBar(
            context,
            AppStrings.errorFillAllFields,
            backgroundColor: AppColors.redButton,
          );
          return;
        }

        // SAVE SELECTION TO PROVIDER ------------------------------------
        final booking = context.read<BookingProvider>();

        booking.setVehicleName(vehicleCtrl.text);
        booking.setServiceName(serviceCtrl.text);

        // convert dd/mm/yyyy → DateTime
        try {
          final parts = dateCtrl.text.split("/");
          final d = DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );

          booking.selectDate(d);
        } catch (e) {
          Helpers.showSnackBar(
            context,
            AppStrings.errorInvalidDateFormat,
            backgroundColor: AppColors.redButton,
          );
          return;
        }

        booking.selectTime(timeCtrl.text);

        // GO TO SUMMARY SCREEN -----------------------------------------
        Navigator.pushNamed(context, "/booking-summary");
      },
    );
  }
}
