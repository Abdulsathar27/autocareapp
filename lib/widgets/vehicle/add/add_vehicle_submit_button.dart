import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../controllers/vehicle_controller.dart';
import '../../../providers/vehicle_provider.dart';
import '../../../providers/user_auth_provider.dart';
import '../../../core/utils/helpers.dart';

class AddVehicleSubmitButton extends StatelessWidget {
  final bool isLoading;
  final String? selectedType;
  final String name;
  final String model;
  final String number;
  final File? image;
  final UserAuthProvider auth;
  final VehicleProvider provider;
  final VoidCallback onSuccess;

  const AddVehicleSubmitButton({
    super.key,
    required this.isLoading,
    required this.selectedType,
    required this.name,
    required this.model,
    required this.number,
    required this.image,
    required this.auth,
    required this.provider,
    required this.onSuccess,
  });

  bool get isValid =>
      name.isNotEmpty &&
      model.isNotEmpty &&
      number.isNotEmpty &&
      selectedType != null;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "Add Vehicle",
      isLoading: isLoading,
      onPressed: () async {
        if (!isValid) {
          Helpers.showSnackBar(context, "Please fill all fields",
              backgroundColor: Colors.red);
          return;
        }

        if (auth.currentUserId == null) {
          Helpers.showSnackBar(
              context, "User not logged in!", backgroundColor: Colors.red);
          return;
        }

        await VehicleController().addVehicle(
          context: context,
          userId: auth.currentUserId!,
          vehicleName: name,
          vehicleModel: model,
          vehicleNumber: number,
          vehicleType: selectedType!,
          provider: provider,
        );

        onSuccess();
      },
    );
  }
}
