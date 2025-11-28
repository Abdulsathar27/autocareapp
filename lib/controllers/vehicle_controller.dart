import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/firebase_keys.dart';
import '../models/vehicle_model.dart';
import '../providers/vehicle_provider.dart';
import '../core/utils/helpers.dart';

class VehicleController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // =====================================================================
  // ADD VEHICLE  (LOCAL + FIREBASE)
  // =====================================================================
  Future<void> addVehicle({
    required BuildContext context,
    required String userId,
    required String vehicleName,
    required String vehicleModel,
    required String vehicleNumber,
    required String vehicleType,
    String? imageUrl, // Firebase image URL
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
        FirebaseKeys.userId: newVehicle.userId,
        FirebaseKeys.vehicleName: newVehicle.vehicleName,
        FirebaseKeys.vehicleModel: newVehicle.vehicleModel,
        FirebaseKeys.vehicleNumber: newVehicle.vehicleNumber,
        FirebaseKeys.vehicleType: newVehicle.vehicleType,
        FirebaseKeys.image: newVehicle.image,
        FirebaseKeys.createdAt: FieldValue.serverTimestamp(),
        FirebaseKeys.updatedAt: FieldValue.serverTimestamp(),
      });

      // Optionally update local provider (if implemented)
      try {
        provider.addVehicle(newVehicle);
      } catch (_) {
        // provider may not implement addVehicle in every codebase — ignore safely
      }

      if (!context.mounted) return;
      Helpers.showSnackBar(context, "Vehicle added successfully!");
    } catch (e) {
      Helpers.showSnackBar(
        context,
        "Error: ${e.toString()}",
        backgroundColor: Colors.red,
      );
    } finally {
      provider.setLoading(false);
    }
  }

  // =====================================================================
  // UPDATE VEHICLE
  // =====================================================================
  Future<void> updateVehicle({
    required BuildContext context,
    required VehicleModel vehicle,
    required VehicleProvider provider,
  }) async {
    try {
      provider.setLoading(true);

      final updatedData = vehicle.toMap()
        ..[FirebaseKeys.updatedAt] = FieldValue.serverTimestamp();

      await _firestore
          .collection(FirebaseKeys.vehicles)
          .doc(vehicle.id)
          .update(updatedData);

      // Optionally update local provider (if implemented)
      try {
        provider.updateVehicleLocal(vehicle);
      } catch (_) {}

      if (!context.mounted) return;
      Helpers.showSnackBar(context, "Vehicle updated successfully!");
    } catch (e) {
      Helpers.showSnackBar(
        context,
        "Error: ${e.toString()}",
        backgroundColor: Colors.red,
      );
    } finally {
      provider.setLoading(false);
    }
  }

  // =====================================================================
  // DELETE VEHICLE (FIREBASE + optional LOCAL/provider + optional UI)
  //
  // Flexible signature:
  // - Call with just deleteVehicle('id') to keep controller pure.
  // - Or pass context/provider to show snackbars and update local provider.
  // =====================================================================
  Future<void> deleteVehicle(
    String vehicleId, {
    BuildContext? context,
    VehicleProvider? provider,
  }) async {
    try {
      await _firestore.collection(FirebaseKeys.vehicles).doc(vehicleId).delete();

      // Update provider if provided (some implementations include local list ops)
      if (provider != null) {
        try {
          provider.deleteVehicle(vehicleId);
        } catch (_) {
          // provider may not implement deleteVehicle; ignore if so
        }
      }

      if (context != null && context.mounted) {
        Helpers.showSnackBar(
          context,
          "Vehicle deleted!",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      if (context != null && context.mounted) {
        Helpers.showSnackBar(
          context,
          "Error: ${e.toString()}",
          backgroundColor: Colors.red,
        );
      } else {
        // If no context provided, rethrow so caller can handle
        rethrow;
      }
    }
  }

  // =====================================================================
  // FETCH USER VEHICLES (STREAM)
  // =====================================================================
  Stream<List<VehicleModel>> getUserVehicles(String userId) {
    return _firestore
        .collection(FirebaseKeys.vehicles)
        .where(FirebaseKeys.userId, isEqualTo: userId)
        .orderBy(FirebaseKeys.createdAt, descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                VehicleModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  // =====================================================================
  // GET SINGLE VEHICLE
  // =====================================================================
  Future<VehicleModel?> getVehicleById(String vehicleId) async {
    final doc =
        await _firestore.collection(FirebaseKeys.vehicles).doc(vehicleId).get();

    if (doc.exists) {
      return VehicleModel.fromMap(doc.data()! as Map<String, dynamic>, doc.id);
    }
    return null;
  }
}
