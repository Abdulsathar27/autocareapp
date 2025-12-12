import 'package:autocare/constants/app_sizes.dart';
import 'package:autocare/controller/booking_provider.dart';
import 'package:autocare/controller/vehicle_provider.dart';
import 'package:autocare/models/vehicle_model.dart';
import 'package:autocare/services/vehicle_services.dart';
import 'package:autocare/views/vehicle/widgets/vehicle/vehicle_card.dart';
import 'package:autocare/views/vehicle/widgets/vehicle/vehicle_empty_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehicleStreamBuilder extends StatelessWidget {
  final String userId;
  final VehicleController controller = VehicleController(); 

  VehicleStreamBuilder({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<VehicleModel>>(
      stream: controller.getUserVehicles(userId),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text(
              "Something went wrong.\nPlease try again later.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final vehicles = snapshot.data!;

    
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<VehicleProvider>().setVehiclesFromStream(vehicles);
        });

        if (vehicles.isEmpty) {
          return const VehicleEmptyView();
        }

        return ListView.separated(
          padding: const EdgeInsets.all(AppSizes.paddingMD),
          itemCount: vehicles.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
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

