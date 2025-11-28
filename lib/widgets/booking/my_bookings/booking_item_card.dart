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
    // DATE (safe for Timestamp OR DateTime OR null)
    // -------------------------
    DateTime? rawDate;

    if (data['bookingDate'] is Timestamp) {
      rawDate = (data['bookingDate'] as Timestamp).toDate();
    } else if (data['bookingDate'] is DateTime) {
      rawDate = data['bookingDate'];
    }

    final date = rawDate != null
        ? "${rawDate.year}-${rawDate.month.toString().padLeft(2, '0')}-${rawDate.day.toString().padLeft(2, '0')}"
        : "-";

    // -------------------------
    // TIME (safe)
    // -------------------------
    final time = data['bookingTime'] ?? "-";

    // -------------------------
    // STATUS (safe)
    // -------------------------
    final status = data['bookingStatus'] ?? "pending";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SERVICE TITLE
          Text(
            service,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),

          // DATE & TIME
          Text(
            "$date • $time",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),

          // STATUS CHIP
          BookingStatusChip(status: status),
        ],
      ),
    );
  }
}
