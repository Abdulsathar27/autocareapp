// lib/controllers/booking_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/firebase_keys.dart';
import '../models/booking_model.dart';
import '../providers/booking_provider.dart';
import '../core/utils/helpers.dart';

class BookingController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ----------------------------------------------------------------
  // CREATE BOOKING (NOW WITH UNIQUE BOOKING ID → NO DUPLICATES)
  // ----------------------------------------------------------------
  Future<void> createBooking({
    required BuildContext context,
    required String userId,
    required String vehicleId,
    required String serviceId,
    required DateTime bookingDate,
    required String bookingTime,
    required BookingProvider provider,
  }) async {
    try {
      provider.setLoading(true);

      // -----------------------------------------------------------
      // 🔥 UNIQUE BOOKING ID — FIXES DUPLICATE BOOKINGS
      // Format: user_vehicle_date
      // Example: "uid123_veh88_2025-01-01T10:00:00"
      // -----------------------------------------------------------
      final bookingId =
          "${userId}_${vehicleId}_${bookingDate.toIso8601String()}";

      final docRef =
          _firestore.collection(FirebaseKeys.bookings).doc(bookingId);

      await docRef.set(
        {
          FirebaseKeys.userId: userId,
          FirebaseKeys.vehicleId: vehicleId,
          FirebaseKeys.serviceId: serviceId,
          FirebaseKeys.bookingDate: bookingDate,
          FirebaseKeys.bookingTime: bookingTime,
          FirebaseKeys.bookingStatus: FirebaseKeys.statusPending,
          FirebaseKeys.createdAt: FieldValue.serverTimestamp(),
          FirebaseKeys.updatedAt: FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true), // 🔥 Prevents duplicate documents
      );

      if (context.mounted) {
        Helpers.showSnackBar(context, "Booking Successful!");
      }
    } catch (e) {
      if (context.mounted) {
        Helpers.showSnackBar(
          context,
          "Error: $e",
          backgroundColor: Colors.red,
        );
      }
    } finally {
      provider.setLoading(false);
    }
  }

  // ----------------------------------------------------------------
  // STREAM USER BOOKINGS
  // ----------------------------------------------------------------
  Stream<List<BookingModel>> getUserBookings(String userId) {
    return _firestore
        .collection(FirebaseKeys.bookings)
        .where(FirebaseKeys.userId, isEqualTo: userId)
        .orderBy(FirebaseKeys.createdAt, descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BookingModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  // ----------------------------------------------------------------
  // ADMIN: FETCH ALL BOOKINGS
  // ----------------------------------------------------------------
  Stream<List<BookingModel>> getAllBookings() {
    return _firestore
        .collection(FirebaseKeys.bookings)
        .orderBy(FirebaseKeys.createdAt, descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BookingModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  // ----------------------------------------------------------------
  // UPDATE BOOKING STATUS
  // ----------------------------------------------------------------
  Future<void> updateBookingStatus({
    required String bookingId,
    required String newStatus,
  }) async {
    await _firestore.collection(FirebaseKeys.bookings).doc(bookingId).update({
      FirebaseKeys.bookingStatus: newStatus,
      FirebaseKeys.updatedAt: FieldValue.serverTimestamp(),
    });
  }

  // ----------------------------------------------------------------
  // ADD ADMIN NOTE
  // ----------------------------------------------------------------
  Future<void> addAdminNote({
    required String bookingId,
    required String note,
  }) async {
    await _firestore.collection(FirebaseKeys.bookings).doc(bookingId).update({
      FirebaseKeys.adminNote: note,
      FirebaseKeys.updatedAt: FieldValue.serverTimestamp(),
    });
  }

  // ----------------------------------------------------------------
  // CANCEL BOOKING
  // ----------------------------------------------------------------
  Future<void> cancelBooking(String bookingId) async {
    await _firestore.collection(FirebaseKeys.bookings).doc(bookingId).update({
      FirebaseKeys.bookingStatus: FirebaseKeys.statusCancelled,
      FirebaseKeys.updatedAt: FieldValue.serverTimestamp(),
    });
  }
}
