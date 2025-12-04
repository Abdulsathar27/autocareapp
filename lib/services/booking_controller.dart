
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/firebase_keys.dart';
import '../models/booking_model.dart';
import '../contollers/booking_provider.dart';
import '../core/utils/helpers.dart';

class BookingController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  
  // CREATE BOOKING 
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

    
      //  UNIQUE BOOKING ID  
      final bookingId =
          "${userId}_${vehicleId}_${bookingDate.toIso8601String()}";

      final docRef =
          firestore.collection(FirebaseKeys.bookings).doc(bookingId);

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
        SetOptions(merge: true), 
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

  
  // STREAM USER BOOKINGS
  Stream<List<BookingModel>> getUserBookings(String userId) {
    return firestore
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
  // ADMIN
  Stream<List<BookingModel>> getAllBookings() {
    return firestore
        .collection(FirebaseKeys.bookings)
        .orderBy(FirebaseKeys.createdAt, descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BookingModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }
  // UPDATE BOOKING STATUS
  Future<void> updateBookingStatus({
    required String bookingId,
    required String newStatus,
  }) async {
    await firestore.collection(FirebaseKeys.bookings).doc(bookingId).update({
      FirebaseKeys.bookingStatus: newStatus,
      FirebaseKeys.updatedAt: FieldValue.serverTimestamp(),
    });
  }
  // ADD ADMIN NOTE
  Future<void> addAdminNote({
    required String bookingId,
    required String note,
  }) async {
    await firestore.collection(FirebaseKeys.bookings).doc(bookingId).update({
      FirebaseKeys.adminNote: note,
      FirebaseKeys.updatedAt: FieldValue.serverTimestamp(),
    });
  }

  
  // CANCEL BOOKING
  Future<void> cancelBooking(String bookingId) async {
    await firestore.collection(FirebaseKeys.bookings).doc(bookingId).update({
      FirebaseKeys.bookingStatus: FirebaseKeys.statusCancelled,
      FirebaseKeys.updatedAt: FieldValue.serverTimestamp(),
    });
  }
}
