import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/contollers/booking_provider.dart';
import 'package:autocare/contollers/user_auth_provider.dart';
import 'package:autocare/core/utils/helpers.dart';
import 'package:autocare/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingSummaryConfirmButton extends StatelessWidget {
  const BookingSummaryConfirmButton({super.key});

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>();
    final isLoading = booking.isLoading;

    return CustomButton(
      text: "Confirm Booking",
      isLoading: isLoading,
      onPressed: isLoading
          ? null
          : () {
              _handleConfirm(context);
            },
    );
  }

  Future<void> _handleConfirm(BuildContext context) async {
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

    if (!booking.isBookingComplete) {
      Helpers.showSnackBar(
        context,
        "Please complete all booking fields.",
        backgroundColor: AppColors.redButton,
      );
      return;
    }

    final success = await booking.createBooking(userId);

    if (!success) {
      Helpers.showSnackBar(
        context,
        "Booking failed. Please try again.",
        backgroundColor: AppColors.redButton,
      );
      return;
    }

    booking.resetBooking();

    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/booking-success",
        (route) => false,
      );
    }
  }
}
