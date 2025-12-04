
import 'package:flutter/material.dart';

class BookingProvider extends ChangeNotifier {
  // Loading
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  // Selected vehicle 
  String? _selectedVehicleId;
  String? get selectedVehicleId => _selectedVehicleId;

  String? _selectedVehicleName;
  String? get selectedVehicle => _selectedVehicleName; 

  /// Select vehicle by id + friendly name 
  void selectVehicle(String id, String name) {
    _selectedVehicleId = id;
    _selectedVehicleName = name;
    notifyListeners();
  }

  /// Legacy setter 
  void setVehicle(String name) {
    _selectedVehicleName = name;
    notifyListeners();
  }

  // Selected service (ID + name)
  String? _selectedServiceId;
  String? get selectedServiceId => _selectedServiceId;

  String? _selectedServiceName;
  String? get selectedService => _selectedServiceName; 

  void selectService(String id, String name) {
    _selectedServiceId = id;
    _selectedServiceName = name;
    notifyListeners();
  }

  void setService(String name) {
    _selectedServiceName = name;
    notifyListeners();
  }
  // Selected date/time
  // date stored as DateTime for Firestore compatibility
  
  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  String get selectedDateFormatted {
    if (_selectedDate == null) return '';
    final d = _selectedDate!;
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  
  void setDate(String formatted) {
    _selectedDate = _selectedDate; 
     notifyListeners();
  }

  String? _selectedTime; 
  String? get selectedTime => _selectedTime;

  void selectTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  void setTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }


  // Local booking history 
  final List<Map<String, dynamic>> _bookings = [];
  List<Map<String, dynamic>> get bookings => List.unmodifiable(_bookings);

  void addBookingToHistory(Map<String, dynamic> booking) {
    _bookings.insert(0, booking);
    notifyListeners();
  }

  void clearHistory() {
    _bookings.clear();
    notifyListeners();
  }

  
  // Helpers
  bool get isBookingComplete =>
      _selectedVehicleId != null &&
      _selectedServiceId != null &&
      _selectedDate != null &&
      _selectedTime != null;

  Map<String, dynamic>? bookingPayload({required String userId}) {
    if (!isBookingComplete) return null;

    return {
      'userId': userId,
      'vehicleId': _selectedVehicleId,
      'serviceId': _selectedServiceId,
      'bookingDate': _selectedDate,
      'bookingTime': _selectedTime,
      'createdAt': DateTime.now(),
    };
  }

  /// Clear 
  void clearBooking() {
    _selectedVehicleId = null;
    _selectedVehicleName = null;
    _selectedServiceId = null;
    _selectedServiceName = null;
    _selectedDate = null;
    _selectedTime = null;
    notifyListeners();
  }

  /// Clear everything
  void reset() {
    clearBooking();
    clearHistory();
    _isLoading = false;
    notifyListeners();
  }
}
