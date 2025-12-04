import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'booking_summary_row.dart';

class BookingSummaryCard extends StatelessWidget {
  final String service;
  final String vehicle;
  final String date;
  final String time;

  const BookingSummaryCard({
    super.key,
    required this.service,
    required this.vehicle,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color:AppColors.background,
        borderRadius: BorderRadius.circular(AppSizes.radiusXL),
        boxShadow: const [
          BoxShadow(
            blurRadius: 14,
            offset: Offset(0, 4),
            color: AppColors.textPrimary,
          ),
        ],
      ),
      child: Column(
        children: [
          BookingSummaryRow(
            label: "Service",
            value: service,
            icon: Icons.miscellaneous_services,
          ),
          const SizedBox(height: 18),

          BookingSummaryRow(
            label: "Vehicle",
            value: vehicle,
            icon: Icons.directions_car,
          ),
          const SizedBox(height: 18),

          BookingSummaryRow(
            label: "Date",
            value: date,
            icon: Icons.calendar_month,
          ),
          const SizedBox(height: 18),

          BookingSummaryRow(
            label: "Time",
            value: time,
            icon: Icons.access_time,
          ),
        ],
      ),
    );
  }
}
