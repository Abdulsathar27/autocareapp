import 'package:autocare/constants/app_strings.dart';
import 'package:autocare/views/booking/widgets/booking/booking_continue_button.dart';
import 'package:autocare/views/booking/widgets/booking/booking_date_field.dart';
import 'package:autocare/views/booking/widgets/booking/booking_service_field.dart';
import 'package:autocare/views/booking/widgets/booking/booking_time_field.dart';
import 'package:autocare/views/booking/widgets/booking/booking_vehicle_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

import '../../contollers/booking_provider.dart';
import '../../contollers/booking_form_provider.dart';

class BookingView extends StatelessWidget {
  const BookingView({super.key});

  void _syncFormWithProvider(BuildContext context) {
    final booking = context.read<BookingProvider>();
    final form = context.read<BookingFormProvider>();

    form.vehicleCtrl.text = booking.selectedVehicleName ?? "";
    form.serviceCtrl.text = booking.selectedServiceName ?? "";
    form.dateCtrl.text = booking.selectedDateFormatted;
    form.timeCtrl.text = booking.selectedTime ?? "";
  }

  @override
  Widget build(BuildContext context) {
    // Sync form data with booking provider whenever the view builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncFormWithProvider(context);
    });

    final form = context.watch<BookingFormProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.bookService,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSizes.paddingLG),

            BookingVehicleField(controller: form.vehicleCtrl),
            const SizedBox(height: AppSizes.paddingMD),

            BookingServiceField(controller: form.serviceCtrl),
            const SizedBox(height: AppSizes.paddingMD),

            BookingDateField(controller: form.dateCtrl),
            const SizedBox(height: AppSizes.paddingMD),

            BookingTimeField(controller: form.timeCtrl),
            const SizedBox(height: AppSizes.paddingXL),

            BookingContinueButton(
              isLoading: form.isLoading,
              vehicleCtrl: form.vehicleCtrl,
              serviceCtrl: form.serviceCtrl,
              dateCtrl: form.dateCtrl,
              timeCtrl: form.timeCtrl,
            ),
          ],
        ),
      ),
    );
  }
}
