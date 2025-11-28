import 'package:flutter/material.dart';
import '../../../core/widgets/custom_button.dart';

class VehicleDetailsEditButton extends StatelessWidget {
  final String? vehicleId;
  final String name;
  final String number;
  final String model;
  final String type;
  final String? image;

  const VehicleDetailsEditButton({
    super.key,
    required this.vehicleId,
    required this.name,
    required this.number,
    required this.model,
    required this.type,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "Edit Vehicle",
      onPressed: () {
        Navigator.pushNamed(context, "/edit-vehicle", arguments: {
          "vehicleId": vehicleId,
          "vehicleName": name,
          "vehicleNumber": number,
          "vehicleModel": model,
          "vehicleType": type,
          "vehicleImage": image,
        });
      },
    );
  }
}
