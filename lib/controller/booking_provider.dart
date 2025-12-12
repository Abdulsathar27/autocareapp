import 'package:flutter/material.dart';
import '../models/booking_model.dart';
import '../services/booking_services.dart';

class BookingProvider extends ChangeNotifier {
  final BookingController controller = BookingController();

  // LOADING STATE
  bool _loading = false;
  bool get isLoading => _loading;
  void setLoading(bool v) {
    _loading = v;
    notifyListeners();
  }

  // VEHICLE SELECTION
  String? _selectedVehicleId;
  String? get selectedVehicleId => _selectedVehicleId;

  String? _selectedVehicleName;
  String? get selectedVehicleName => _selectedVehicleName;

  void selectVehicle(String id, String name) {
    _selectedVehicleId = id;
    _selectedVehicleName = name;
    notifyListeners();
  }
  void setVehicleName(String name) {
    _selectedVehicleName = name;
    notifyListeners();
  }

  // SERVICE SELECTION
  String? _selectedServiceId;
  String? get selectedServiceId => _selectedServiceId;

  String? _selectedServiceName;
  String? get selectedServiceName => _selectedServiceName;

  void selectService(String id, String name) {
    _selectedServiceId = id;
    _selectedServiceName = name;
    notifyListeners();
  }
  
   void setServiceName(String name) {
    _selectedServiceName = name;
    notifyListeners();
  }

  // DATE SELECTION
  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  String get selectedDateFormatted {
    if (_selectedDate == null) return "";
    final d = _selectedDate!;
    return "${d.day.toString().padLeft(2, '0')}/"
           "${d.month.toString().padLeft(2, '0')}/"
           "${d.year}";
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  // TIME SELECTION
  String? _selectedTime;
  String? get selectedTime => _selectedTime;

  void selectTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  // BOOKING COMPLETION CHECK
  bool get isBookingComplete =>
      _selectedVehicleId != null &&
      _selectedServiceId != null &&
      _selectedDate != null &&
      _selectedTime != null;

  // CREATE BOOKING
  Future<bool> createBooking(String userId) async {
    if (!isBookingComplete) return false;

    setLoading(true);

    final result = await controller.createBooking(
      vehicleId: _selectedVehicleId!,
      serviceId: _selectedServiceId!,
      bookingDate: _selectedDate!,
      bookingTime: _selectedTime!,
      userId: userId,
    );

    setLoading(false);
    return result;
  }

  // STREAM USER BOOKINGS
  Stream<List<BookingModel>> userBookingStream(String userId) {
    return controller.getUserBookings(userId);
  }

  // RESET BOOKING
  void resetBooking() {
    _selectedVehicleId = null;
    _selectedVehicleName = null;
    _selectedServiceId = null;
    _selectedServiceName = null;
    _selectedDate = null;
    _selectedTime = null;
    notifyListeners();
  }
}
