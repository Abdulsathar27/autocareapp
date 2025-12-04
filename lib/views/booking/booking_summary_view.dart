import 'package:autocare/views/booking/widgets/booking/summary/booking_summary_card.dart';
import 'package:autocare/views/booking/widgets/booking/summary/booking_summary_confirm_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../../contollers/booking_provider.dart';


class BookingSummaryView extends StatelessWidget {
  const BookingSummaryView({super.key});
  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Booking Summary",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            BookingSummaryCard(
              service: booking.selectedService ?? "Not Selected",
              vehicle: booking.selectedVehicle ?? "Not Selected",
              date: booking.selectedDateFormatted,
              time: booking.selectedTime ?? "Not Selected",
            ),
            const SizedBox(height: 30),
            const BookingSummaryConfirmButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
