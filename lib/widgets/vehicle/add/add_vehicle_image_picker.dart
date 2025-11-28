import 'dart:io';
import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_sizes.dart';

class AddVehicleImagePicker extends StatelessWidget {
  final File? image;
  final VoidCallback onPick;

  const AddVehicleImagePicker({
    super.key,
    required this.image,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPick,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: AppColors.iconBgGreen,
          borderRadius: BorderRadius.circular(AppSizes.radiusXL),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: image == null
            ? const Icon(Icons.camera_alt,
                size: 40, color: AppColors.primaryGreen)
            : ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusXL),
                child: Image.file(image!, fit: BoxFit.cover),
              ),
      ),
    );
  }
}
