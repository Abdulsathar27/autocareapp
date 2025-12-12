import 'package:autocare/constants/app_strings.dart';
import 'package:autocare/controller/booking_provider.dart';
import 'package:autocare/controller/user_auth_provider.dart';
import 'package:autocare/core/utils/helpers.dart';
import 'package:autocare/core/widgets/custom_button.dart';
import 'package:autocare/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingSummaryConfirmButton extends StatelessWidget {
  const BookingSummaryConfirmButton({super.key});

  @override
  Widget build(BuildContext context) {
    final booking = context.read<BookingProvider>();
    final isLoading = booking.isLoading;

    return Consumer<BookingProvider>(
      builder: (context, value, child) => CustomButton(
        text: AppStrings.confirmBooking,
        isLoading: isLoading,
        onPressed: isLoading
            ? null
            : () => booking
                  .createBooking(
                    context.read<UserAuthProvider>().currentUserId!,
                  )
                  .then((result) {
                    if (result) {
                      if (!context.mounted) return;
                      Navigator.pushNamed(context, AppRoutes.bookingSuccess);
                    } else {
                      if (!context.mounted) return;
                      Helpers.showSnackBar(
                        context,
                        "Booking failed",
                        backgroundColor: Colors.red,
                      );
                    }
                  }),
      ),
    );
  }
}
