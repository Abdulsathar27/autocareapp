import '../repositories/booking_repository.dart';
import '../models/booking_model.dart';
import '../constants/firebase_keys.dart';

class BookingController {
  final BookingRepository repo = BookingRepository();
  // CREATE booking 
  Future<bool> createBooking({
    required String userId,
    required String vehicleId,
    required String serviceId,
    required DateTime bookingDate,
    required String bookingTime,
  }) async {
    try {
      final bookingId =
          "${userId}_${vehicleId}_${bookingDate.toIso8601String()}";
      final data = {
        FirebaseKeys.userId: userId,
        FirebaseKeys.vehicleId: vehicleId,
        FirebaseKeys.serviceId: serviceId,
        FirebaseKeys.bookingDate: bookingDate,
        FirebaseKeys.bookingTime: bookingTime,
        FirebaseKeys.bookingStatus: FirebaseKeys.statusPending,
        FirebaseKeys.createdAt: DateTime.now(),
        FirebaseKeys.updatedAt: DateTime.now(),
      };
      await repo.createBooking(bookingId, data);
      return true;
    } catch (_) {
      return false;
    }
  }
  Stream<List<BookingModel>> getUserBookings(String userId) {
    return repo.getUserBookings(userId);
  }
  Future<void> cancelBooking(String id) => repo.cancelBooking(id);
  Future<void> updateStatus(String id, String status) =>
      repo.updateBookingStatus(id, status);
  Future<void> addAdminNote(String id, String note) =>
      repo.addAdminNote(id, note);
}
