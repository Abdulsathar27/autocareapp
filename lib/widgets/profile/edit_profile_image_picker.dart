import 'dart:io';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class EditProfileImagePicker extends StatelessWidget {
  final File? newImage;
  final String? userImage;
  final VoidCallback onPick;

  const EditProfileImagePicker({
    super.key,
    required this.newImage,
    required this.userImage,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPick,
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: AppColors.iconBgGreen,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipOval(
          child: newImage != null
              ? Image.file(newImage!, fit: BoxFit.cover)
              : (userImage != null
                  ? Image.network(
                      userImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.person, size: 70, color: AppColors.primaryGreen),
                    )
                  : const Icon(Icons.person, size: 70, color: AppColors.primaryGreen)),
        ),
      ),
    );
  }
}
