import 'package:flutter/material.dart';
import '../../../core/widgets/delete_vehicle_button.dart';

class VehicleDetailsDeleteButton extends StatelessWidget {
  final String? vehicleId;

  const VehicleDetailsDeleteButton({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context) {
    return DeleteVehicleButton(
      vehicleId: vehicleId,
      popAfterDelete: true,
    );
  }
}
