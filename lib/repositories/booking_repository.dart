import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/firebase_keys.dart';
import '../models/booking_model.dart';

class BookingRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // CREATE booking
  Future<void> createBooking(String id, Map<String, dynamic> data) async {
    await firestore
        .collection(FirebaseKeys.bookings)
        .doc(id)
        .set(data, SetOptions(merge: true));
  }

  // STREAM user bookings
  Stream<List<BookingModel>> getUserBookings(String userId) {
    return firestore
        .collection(FirebaseKeys.bookings)
        .where(FirebaseKeys.userId, isEqualTo: userId)
        .orderBy(FirebaseKeys.createdAt, descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((e) => BookingModel.fromMap(e.data(), e.id)).toList());
  }

  // UPDATE status
  Future<void> updateBookingStatus(String bookingId, String newStatus) async {
    await firestore.collection(FirebaseKeys.bookings).doc(bookingId).update({
      FirebaseKeys.bookingStatus: newStatus,
      FirebaseKeys.updatedAt: FieldValue.serverTimestamp(),
    });
  }

  // ADD NOTE
  Future<void> addAdminNote(String bookingId, String note) async {
    await firestore.collection(FirebaseKeys.bookings).doc(bookingId).update({
      FirebaseKeys.adminNote: note,
      FirebaseKeys.updatedAt: FieldValue.serverTimestamp(),
    });
  }

  // CANCEL booking
  Future<void> cancelBooking(String bookingId) async {
    await updateBookingStatus(bookingId, FirebaseKeys.statusCancelled);
  }
}
