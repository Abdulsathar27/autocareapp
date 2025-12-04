import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/contollers/booking_provider.dart';
import 'package:autocare/contollers/user_auth_provider.dart';
import 'package:autocare/core/utils/helpers.dart';
import 'package:autocare/core/widgets/custom_button.dart';
import 'package:autocare/services/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BookingSummaryConfirmButton extends StatelessWidget {
  const BookingSummaryConfirmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "Confirm Booking",
      onPressed: () async {
        final booking = context.read<BookingProvider>();
        final auth = context.read<UserAuthProvider>();

        final userId = auth.currentUserId;
        if (userId == null) {
          Helpers.showSnackBar(
            context,
            "User not logged in!",
            backgroundColor: AppColors.redButton,
          );
          return;
        }

        // Create map payload
        final payload = booking.bookingPayload(userId: userId);
        if (payload == null) {
          Helpers.showSnackBar(
            context,
            "Booking data incomplete!",
            backgroundColor: AppColors.redButton,
          );
          return;
        }

        // Save to Firestore
        await BookingController().createBooking(
          context: context,
          userId: payload['userId'],
          vehicleId: payload['vehicleId'],
          serviceId: payload['serviceId'],
          bookingDate: payload['bookingDate'],
          bookingTime: payload['bookingTime'],
          provider: booking,
        );

        booking.clearBooking(); // reset after booking

        // Go to success screen
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/booking-success",
          (route) => false,
        );
      },
    );
  }
}
