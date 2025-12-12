import 'package:flutter/material.dart';
import '../models/vehicle_model.dart';

class VehicleProvider extends ChangeNotifier {
  // INTERNAL STATE
  bool _isLoading = false;
  VehicleModel? _selectedVehicle;
  final List<VehicleModel> _vehicles = [];
  // GETTERS
  bool get isLoading => _isLoading;
  VehicleModel? get selectedVehicle => _selectedVehicle;
  List<VehicleModel> get vehicles => List.unmodifiable(_vehicles);
  bool get hasVehicles => _vehicles.isNotEmpty;
  // LOADING STATE
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  // SELECT VEHICLE
  void setSelectedVehicle(VehicleModel? vehicle) {
    _selectedVehicle = vehicle;
    notifyListeners();
  }
  // SYNC FROM FIRESTORE STREAM
  void setVehiclesFromStream(List<VehicleModel> list) {
    _vehicles
      ..clear()
      ..addAll(list);
    notifyListeners();
    
  }
  // ADD VEHICLE (LOCAL UPDATE)
  void addVehicle(VehicleModel vehicle) {
    _vehicles.insert(0, vehicle); // newest on top
    notifyListeners();
  }

  // UPDATE VEHICLE (LOCAL UPDATE)
  void updateVehicleLocal(VehicleModel vehicle) {
    final index = _vehicles.indexWhere((v) => v.id == vehicle.id);
    if (index != -1) {
      _vehicles[index] = vehicle;
    }
    if (_selectedVehicle?.id == vehicle.id) {
      _selectedVehicle = vehicle;
    }
    notifyListeners();
  }

  // DELETE VEHICLE (LOCAL UPDATE)
  void deleteVehicle(String id) {
    _vehicles.removeWhere((v) => v.id == id);

    if (_selectedVehicle?.id == id) {
      _selectedVehicle = null;
    }

    notifyListeners();
  }
 
}
