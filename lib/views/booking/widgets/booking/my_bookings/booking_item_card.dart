// lib/widgets/my_bookings/booking_item_card.dart

import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/constants/app_sizes.dart';
import 'package:autocare/constants/firebase_keys.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'booking_status_chip.dart';

class BookingItemCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final String bookingId;

  const BookingItemCard({
    super.key,
    required this.data,
    required this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    // -------------------------
    // SERVICE NAME (safe)
    // -------------------------
    final service = data[FirebaseKeys.serviceId] ?? "Service";

    // -------------------------
    // DATE (timestamp or datetime)
    // -------------------------
    DateTime? rawDate;

    if (data['bookingDate'] is Timestamp) {
      rawDate = (data['bookingDate'] as Timestamp).toDate();
    } else if (data['bookingDate'] is DateTime) {
      rawDate = data['bookingDate'];
    }

    final date = rawDate != null
        ? "${rawDate.day.toString().padLeft(2, '0')}-${rawDate.month.toString().padLeft(2, '0')}-${rawDate.year}"
        : "-";

    // -------------------------
    // TIME
    // -------------------------
    final time = data['bookingTime'] ?? "-";

    // -------------------------
    // STATUS
    // -------------------------
    final status = data['bookingStatus'] ?? "pending";

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
          // -------------------------
          // TOP GRADIENT BAR
          // -------------------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
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
                Icon(
                  Icons.miscellaneous_services,
                  color: AppColors.background,
                  size: 24,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    service,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.background,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // -------------------------
          // DETAILS SECTION
          // -------------------------
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _infoRow(Icons.calendar_month, "Date", date),
                const SizedBox(height: 12),
                _infoRow(Icons.access_time, "Time", time),
                const SizedBox(height: 12),
                _infoRow(
                  Icons.badge,
                  "Status",
                  null,
                  trailing: BookingStatusChip(status: status),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------
  // REUSABLE ROW WIDGET
  // -------------------------------------------------------
  Widget _infoRow(
    IconData icon,
    String label,
    String? value, {
    Widget? trailing,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.iconBgGreen,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primaryGreen, size: AppSizes.iconMD1),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (value != null)
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
            ],
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }
}
