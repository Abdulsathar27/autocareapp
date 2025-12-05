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

class BookingView extends StatefulWidget {
  const BookingView({super.key});
  @override
  State<BookingView> createState() => _BookingViewState();
}
class _BookingViewState extends State<BookingView> {
  final vehicleCtrl = TextEditingController();
  final serviceCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  final timeCtrl = TextEditingController();
  bool isLoading = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final booking = context.watch<BookingProvider>();
   vehicleCtrl.text = booking.selectedVehicleName ?? "";
  serviceCtrl.text = booking.selectedServiceName ?? "";
  dateCtrl.text = booking.selectedDateFormatted;
  timeCtrl.text = booking.selectedTime ?? "";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text("Book Service",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            )),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSizes.paddingLG),
            BookingVehicleField(controller: vehicleCtrl),
            const SizedBox(height: AppSizes.paddingMD),
            BookingServiceField(controller: serviceCtrl),
            const SizedBox(height: AppSizes.paddingMD),
            BookingDateField(controller: dateCtrl),
            const SizedBox(height: AppSizes.paddingMD),
            BookingTimeField(controller: timeCtrl),
            const SizedBox(height: AppSizes.paddingXL),
            BookingContinueButton(
              isLoading: isLoading,
              vehicleCtrl: vehicleCtrl,
              serviceCtrl: serviceCtrl,
              dateCtrl: dateCtrl,
              timeCtrl: timeCtrl,
            ),
          ],
        ),
      ),
    );
  }
}
