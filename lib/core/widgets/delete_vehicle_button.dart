// lib/core/widgets/delete_vehicle_button.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_sizes.dart';
import '../../core/utils/helpers.dart';
import '../../controllers/vehicle_controller.dart';

/// A reusable delete button that deletes a vehicle from Firestore.
/// - [vehicleId] : the document id in the `vehicles` collection (required).
/// - [onDeleted] : optional callback invoked after successful deletion.
/// - [popAfterDelete] : if true, the widget will pop the current route after deletion.
class DeleteVehicleButton extends StatefulWidget {
  final String? vehicleId;
  final VoidCallback? onDeleted;
  final bool popAfterDelete;
  final String buttonText;

  const DeleteVehicleButton({
  super.key,
  required this.vehicleId,
  this.onDeleted,
  this.popAfterDelete = true,
  this.buttonText = "Delete Vehicle",
});

  @override
  State<DeleteVehicleButton> createState() => _DeleteVehicleButtonState();
}

class _DeleteVehicleButtonState extends State<DeleteVehicleButton> {
  bool _isLoading = false;

  Future<void> _handleDelete() async {
    if (widget.vehicleId == null || widget.vehicleId!.isEmpty) {
      Helpers.showSnackBar(
        context,
        "Vehicle ID is missing. Cannot delete.",
        backgroundColor: Colors.red,
      );
      return;
    }

    // Show confirmation dialog using Helpers helper
    await Helpers.showConfirmDialog(
      context: context,
      title: "Delete Vehicle?",
      message: "Are you sure you want to delete this vehicle from your list?",
      cancelText: "Cancel",
      confirmText: "Delete",
      onConfirm: () async {
        setState(() => _isLoading = true);

        try {
          await VehicleController().deleteVehicle(widget.vehicleId!);

          if (!mounted) return;

          Helpers.showSnackBar(
            context,
            "Vehicle deleted successfully",
            backgroundColor: Colors.red,
          );

          // invoke callback if provided
          widget.onDeleted?.call();

          // optionally pop the current route (go back to list)
          if (widget.popAfterDelete && mounted) {
            Navigator.of(context).pop();
          }
        } catch (e) {
          if (mounted) {
            Helpers.showSnackBar(
              context,
              "Delete failed: ${e.toString()}",
              backgroundColor: Colors.red,
            );
          }
        } finally {
          if (mounted) setState(() => _isLoading = false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.red, width: 1.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
          ),
        ),
        onPressed: _isLoading ? null : _handleDelete,
        child: _isLoading
            ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(
                widget.buttonText,
                style: GoogleFonts.poppins(
                  fontSize: AppSizes.fontLG,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
