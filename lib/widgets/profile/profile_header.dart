import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  final String? imageUrl;

  const ProfileHeader({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: AppColors.iconBgGreen,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: imageUrl == null
            ? const Icon(Icons.person, color: AppColors.primaryGreen, size: 70)
            : ClipOval(
                child: Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const Icon(
                    Icons.person,
                    color: AppColors.primaryGreen,
                    size: 70,
                  ),
                ),
              ),
      ),
    );
  }
}
