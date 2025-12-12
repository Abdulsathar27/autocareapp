import 'package:autocare/controller/vehicle_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants/firebase_keys.dart';
import '../models/vehicle_model.dart';
import '../core/utils/helpers.dart';

class VehicleController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // ADD VEHICLE
  Future<bool> addVehicle({
    required BuildContext context,
    required String userId,
    required String vehicleName,
    required String vehicleModel,
    required String vehicleNumber,
    required String vehicleType,
    String? imageUrl,
    required VehicleProvider provider,
  }) async {
    try {
      provider.setLoading(true);
      final docRef = _firestore.collection(FirebaseKeys.vehicles).doc();
      final newVehicle = VehicleModel(
        id: docRef.id,
        userId: userId,
        vehicleName: vehicleName,
        vehicleModel: vehicleModel,
        vehicleNumber: vehicleNumber,
        vehicleType: vehicleType,
        image: imageUrl,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await docRef.set({
        FirebaseKeys.userId: userId,
        FirebaseKeys.vehicleName: vehicleName,
        FirebaseKeys.vehicleModel: vehicleModel,
        FirebaseKeys.vehicleNumber: vehicleNumber,
        FirebaseKeys.vehicleType: vehicleType,
        FirebaseKeys.image: imageUrl,
        FirebaseKeys.createdAt: FieldValue.serverTimestamp(),
        FirebaseKeys.updatedAt: FieldValue.serverTimestamp(),
      });
      // Update provider locally (safe)
      provider.addVehicle(newVehicle);
      if (context.mounted) {
        Helpers.showSnackBar(context, "Vehicle added successfully!");
      }
      return true;
    } catch (e) {
      if (context.mounted) {
        Helpers.showSnackBar(
          context,
          "Error adding vehicle: $e",
          backgroundColor: Colors.red,
        );
      }
      return false;
    } finally {
      provider.setLoading(false);
    }
  }
  // UPDATE VEHICLE
  Future<bool> updateVehicle({
    required BuildContext context,
    required VehicleModel vehicle,
    required VehicleProvider provider,
  }) async {
    try {
      provider.setLoading(true);
      final data = vehicle.toMap()
        ..[FirebaseKeys.updatedAt] = FieldValue.serverTimestamp();
      await _firestore
          .collection(FirebaseKeys.vehicles)
          .doc(vehicle.id)
          .update(data);
      provider.updateVehicleLocal(vehicle);
      if (context.mounted) {
        Helpers.showSnackBar(context, "Vehicle updated successfully!");
      }
      return true;
    } catch (e) {
      if (context.mounted) {
        Helpers.showSnackBar(
          context,
          "Update failed: $e",
          backgroundColor: Colors.red,
        );
      }
      return false;
    } finally {
      provider.setLoading(false);
    }
  }

  // DELETE VEHICLE
  Future<bool> deleteVehicle(
    String vehicleId, {
    BuildContext? context,
    VehicleProvider? provider,
  }) async {
    try {
      await _firestore.collection(FirebaseKeys.vehicles).doc(vehicleId).delete();
      // Update provider safely
      provider?.deleteVehicle(vehicleId);
      if (context?.mounted ?? false) {  
        Helpers.showSnackBar(
          context!,
          "Vehicle deleted!",
          backgroundColor: Colors.red,
        );
      }
      return true;
    } catch (e) {
      if (context?.mounted ?? false) {
        Helpers.showSnackBar(
          context!,
          "Error deleting vehicle: $e",
          backgroundColor: Colors.red,
        );
      }
      return false;
    }
  }
  // STREAM: FETCH ALL USER VEHICLES
  Stream<List<VehicleModel>> getUserVehicles(String userId) {
    return _firestore
        .collection(FirebaseKeys.vehicles)
        .where(FirebaseKeys.userId, isEqualTo: userId)
        .orderBy(FirebaseKeys.createdAt, descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => VehicleModel.fromMap(
                  doc.data() as Map<String, dynamic>,
                  doc.id,
                ),
              )
              .toList(),
        );
  }
  // GET SINGLE VEHICLE BY ID
  Future<VehicleModel?> getVehicleById(String vehicleId) async {
    final doc = await _firestore
        .collection(FirebaseKeys.vehicles)
        .doc(vehicleId)
        .get();
    if (!doc.exists) return null;
    return VehicleModel.fromMap(
      doc.data()! as Map<String, dynamic>,
      doc.id,
    );
  }
}
