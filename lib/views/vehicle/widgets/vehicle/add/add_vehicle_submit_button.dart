import 'package:flutter/material.dart';

class AddVehicleSubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const AddVehicleSubmitButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text("Add Vehicle"),
    );
  }
}

