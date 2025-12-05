import 'package:autocare/constants/app_sizes.dart';
import 'package:autocare/contollers/booking_provider.dart';
import 'package:autocare/contollers/vehicle_provider.dart';
import 'package:autocare/models/vehicle_model.dart';
import 'package:autocare/services/vehicle_controller.dart';
import 'package:autocare/views/vehicle/widgets/vehicle/vehicle_card.dart';
import 'package:autocare/views/vehicle/widgets/vehicle/vehicle_empty_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehicleStreamBuilder extends StatelessWidget {
  final String userId;

  const VehicleStreamBuilder({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final controller = VehicleController();

    return StreamBuilder<List<VehicleModel>>(
      stream: controller.getUserVehicles(userId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final vehicles = snapshot.data!;

        // Sync Firestore → Provider
        context.read<VehicleProvider>().setVehiclesFromStream(vehicles);

        if (vehicles.isEmpty) {
          return const VehicleEmptyView();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(AppSizes.paddingMD),
          itemCount: vehicles.length,
          itemBuilder: (_, index) {
            final vehicle = vehicles[index];

            return GestureDetector(
              onTap: () {
                // Save selected vehicle for Booking
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
