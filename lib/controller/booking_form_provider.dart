import 'package:flutter/material.dart';

class BookingFormProvider extends ChangeNotifier {
  final vehicleCtrl = TextEditingController();
  final serviceCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  final timeCtrl = TextEditingController();

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    vehicleCtrl.dispose();
    serviceCtrl.dispose();
    dateCtrl.dispose();
    timeCtrl.dispose();
    super.dispose();
  }

void clear() {
    vehicleCtrl.clear();
    serviceCtrl.clear();
    dateCtrl.clear();
    timeCtrl.clear();
    notifyListeners();
  }
  
}
