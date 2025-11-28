import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/firebase_keys.dart';
import '../models/booking_model.dart';
import '../providers/booking_provider.dart';
import '../core/utils/helpers.dart';

class BookingController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // -------------------------------------------------------------
  // CREATE BOOKING  ✅ FIXED
  // -------------------------------------------------------------
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

      final docRef = _firestore.collection(FirebaseKeys.bookings).doc();

      await docRef.set({
        FirebaseKeys.userId: userId,
        FirebaseKeys.vehicleId: vehicleId,
        FirebaseKeys.serviceId: serviceId,
        FirebaseKeys.bookingDate: bookingDate,
        FirebaseKeys.bookingTime: bookingTime,
        FirebaseKeys.bookingStatus: FirebaseKeys.statusPending,

        // ⚠️ FIX: serverTimestamp replaced with DateTime.now()
        FirebaseKeys.createdAt: DateTime.now(),
        FirebaseKeys.updatedAt: DateTime.now(),
      });

      if (context.mounted) {
        Helpers.showSnackBar(context, "Booking Successful!");
      }
    } catch (e) {
      if (context.mounted) {
        Helpers.showSnackBar(
          context,
          e.toString(),
          backgroundColor: Colors.red,
        );
      }
    } finally {
      provider.setLoading(false);
    }
  }

  // -------------------------------------------------------------
  // FETCH BOOKINGS FOR USER
  // -------------------------------------------------------------
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

  // -------------------------------------------------------------
  // FETCH ALL BOOKINGS (ADMIN)
  // -------------------------------------------------------------
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

  // UPDATE STATUS
  Future<void> updateBookingStatus({
    required String bookingId,
    required String newStatus,
  }) async {
    await _firestore.collection(FirebaseKeys.bookings).doc(bookingId).update({
      FirebaseKeys.bookingStatus: newStatus,
      FirebaseKeys.updatedAt: DateTime.now(),
    });
  }

  Future<void> addAdminNote({
    required String bookingId,
    required String note,
  }) async {
    await _firestore.collection(FirebaseKeys.bookings).doc(bookingId).update({
      FirebaseKeys.adminNote: note,
      FirebaseKeys.updatedAt: DateTime.now(),
    });
  }

  Future<void> cancelBooking(String bookingId) async {
    await _firestore.collection(FirebaseKeys.bookings).doc(bookingId).update({
      FirebaseKeys.bookingStatus: FirebaseKeys.statusCancelled,
      FirebaseKeys.updatedAt: DateTime.now(),
    });
  }
}
