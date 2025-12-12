import 'package:autocare/constants/app_strings.dart';
import 'package:autocare/controller/booking_form_provider.dart';
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

class BookingView extends StatelessWidget {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
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

      // 👇 Everything reacts to BookingFormProvider
      body: Consumer<BookingFormProvider>(
        builder: (context, form, _) {
          return SingleChildScrollView(
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
          );
        },
      ),
    );
  }
}
