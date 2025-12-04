import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/constants/app_sizes.dart';
import 'package:autocare/contollers/booking_provider.dart';
import 'package:autocare/models/vehicle_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VehicleCard extends StatelessWidget {
  final VehicleModel vehicle;
  const VehicleCard({super.key, required this.vehicle});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final booking = Provider.of<BookingProvider>(context, listen: false);
        booking.selectVehicle(
          vehicle.id, 
          "${vehicle.vehicleName} • ${vehicle.vehicleNumber}", 
        );
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppSizes.radiusLG),
          boxShadow: const [
            BoxShadow(
              color: AppColors.textPrimary,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: AppColors.iconBgGreen,
                borderRadius: BorderRadius.circular(AppSizes.radiusLG),
              ),
              child: Icon(
                vehicle.vehicleType == "Bike"
                    ? Icons.pedal_bike
                    : Icons.directions_car,
                color: AppColors.primaryGreen,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicle.vehicleName,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    vehicle.vehicleNumber,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
