import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../core/utils/helpers.dart';
import '../../core/widgets/custom_button.dart';
import '../../providers/booking_provider.dart';

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
      text: "Continue",
      isLoading: isLoading,
      onPressed: () {
        // VALIDATION -----------------------------------------------------
        if (vehicleCtrl.text.isEmpty ||
            serviceCtrl.text.isEmpty ||
            dateCtrl.text.isEmpty ||
            timeCtrl.text.isEmpty) {
          Helpers.showSnackBar(
            context,
            "Please fill all fields",
            backgroundColor: AppColors.redButton,
          );
          return;
        }

        // SAVE SELECTION TO PROVIDER ------------------------------------
        final booking = context.read<BookingProvider>();

        booking.setVehicle(vehicleCtrl.text);
        booking.setService(serviceCtrl.text);

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
            "Invalid date format",
            backgroundColor: Colors.red,
          );
          return;
        }

        booking.setTime(timeCtrl.text);

        // GO TO SUMMARY SCREEN -----------------------------------------
        Navigator.pushNamed(context, "/booking-summary");
      },
    );
  }
}
