import 'dart:io';
import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/contollers/user_auth_provider.dart';
import 'package:autocare/contollers/vehicle_provider.dart';
import 'package:autocare/core/utils/helpers.dart';
import 'package:autocare/core/widgets/custom_button.dart';
import 'package:autocare/services/vehicle_controller.dart';
import 'package:flutter/material.dart';

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
              backgroundColor: AppColors.redButton);
          return;
        }
        if (auth.currentUserId == null) {
          Helpers.showSnackBar(
              context, "User not logged in!", backgroundColor: AppColors.redButton);
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
