import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/constants/app_sizes.dart';
import 'package:autocare/controller/booking_provider.dart';
import 'package:autocare/models/booking_model.dart';
import 'package:autocare/views/booking/widgets/booking/my_bookings/booking_info_row.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'booking_status_chip.dart';

class BookingItemCard extends StatelessWidget {
  final BookingModel model;

  const BookingItemCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, _) {
        // You still use your model
        final service = model.serviceId;
        final rawDate = model.bookingDate;

        final date =
            "${rawDate.day.toString().padLeft(2, '0')}-${rawDate.month.toString().padLeft(2, '0')}-${rawDate.year}";

        final time = model.bookingTime;
        final status = model.status;

        return Container(
          margin: const EdgeInsets.only(bottom: 18),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppSizes.radiusLG),
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 18,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryGreen.withValues(alpha: 0.9),
                      AppColors.primaryGreen.withValues(alpha: 0.6),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.radiusLG),
                    topRight: Radius.circular(AppSizes.radiusLG),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.miscellaneous_services,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        service,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // DETAILS
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    BookingInfoRow(
                      icon: Icons.calendar_month,
                      label: "Date",
                      value: date,
                    ),
                    const SizedBox(height: 12),

                    BookingInfoRow(
                      icon: Icons.access_time,
                      label: "Time",
                      value: time,
                    ),
                    const SizedBox(height: 12),

                    BookingInfoRow(
                      icon: Icons.badge,
                      label: "Status",
                      trailing: BookingStatusChip(status: status),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
