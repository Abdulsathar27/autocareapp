import 'package:autocare/constants/app_sizes.dart';
import 'package:autocare/constants/firebase_keys.dart';
import 'package:autocare/contollers/booking_provider.dart';
import 'package:autocare/models/vehicle_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'vehicle_empty_view.dart';
import 'vehicle_card.dart';

class VehicleStreamBuilder extends StatelessWidget {
  final String? userId;
  const VehicleStreamBuilder({super.key, required this.userId});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(FirebaseKeys.vehicles)
          .where(FirebaseKeys.userId, isEqualTo: userId)
          .orderBy(FirebaseKeys.createdAt, descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!.docs.isEmpty) {
          return const VehicleEmptyView();
        }
        final vehicles = snapshot.data!.docs
            .map((e) => VehicleModel.fromMap(e.data() as Map<String, dynamic>, e.id))
            .toList();
        return ListView.builder(
          padding: const EdgeInsets.all(AppSizes.paddingMD),
          itemCount: vehicles.length,
          itemBuilder: (_, index) {
            final vehicle = vehicles[index];
            return GestureDetector(
              onTap: () {
                 context.read<BookingProvider>().selectVehicle(
                      vehicle.id,          
                      vehicle.vehicleName, 
                    );
                Navigator.pop(context);
              },
              child: VehicleCard(vehicle: vehicle),
            );
          },
        );
      },
    );
  }
}
