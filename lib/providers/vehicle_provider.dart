import 'package:flutter/material.dart';
import '../models/vehicle_model.dart';

class VehicleProvider extends ChangeNotifier {
  // ---------------------------------------------------------
  // INTERNAL STATE
  // ---------------------------------------------------------
  bool _isLoading = false;
  VehicleModel? _selectedVehicle;
  final List<VehicleModel> _vehicles = [];

  // ---------------------------------------------------------
  // GETTERS
  // ---------------------------------------------------------
  bool get isLoading => _isLoading;
  VehicleModel? get selectedVehicle => _selectedVehicle;
  List<VehicleModel> get vehicles => List.unmodifiable(_vehicles);

  bool get hasVehicles => _vehicles.isNotEmpty;

  // ---------------------------------------------------------
  // SET LOADING
  // ---------------------------------------------------------
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // ---------------------------------------------------------
  // SELECT VEHICLE
  // ---------------------------------------------------------
  void setSelectedVehicle(VehicleModel? vehicle) {
    _selectedVehicle = vehicle;
    notifyListeners();
  }

  // ---------------------------------------------------------
  // ADD VEHICLE (LOCAL)
  // ---------------------------------------------------------
  void addVehicle(VehicleModel vehicle) {
    _vehicles.add(vehicle);
    notifyListeners();
  }

  // ---------------------------------------------------------
  // UPDATE VEHICLE (LOCAL)
  // ---------------------------------------------------------
  void updateVehicleLocal(VehicleModel vehicle) {
    final index = _vehicles.indexWhere((v) => v.id == vehicle.id);
    if (index != -1) {
      _vehicles[index] = vehicle;
    }
    _selectedVehicle = vehicle;
    notifyListeners();
  }

  // ---------------------------------------------------------
  // DELETE VEHICLE (LOCAL)
  // ---------------------------------------------------------
  void deleteVehicle(String id) {
    _vehicles.removeWhere((v) => v.id == id);

    // If deleted vehicle is currently selected, clear it
    if (_selectedVehicle?.id == id) {
      _selectedVehicle = null;
    }

    notifyListeners();
  }

  // ---------------------------------------------------------
  // CLEAR ALL VEHICLE DATA
  // ---------------------------------------------------------
  void clear() {
    _selectedVehicle = null;
    _vehicles.clear();
    notifyListeners();
  }
}
