import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'profile_option_item.dart';

class ProfileOptionList extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onVehicles;
  final VoidCallback onBookings;
  final VoidCallback onSettings;
  const ProfileOptionList({
    super.key,
    required this.onEdit,
    required this.onVehicles,
    required this.onBookings,
    required this.onSettings,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
        boxShadow: const [
          BoxShadow(
            color:AppColors.textPrimary,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ProfileOptionItem(icon: Icons.edit, label: "Edit Profile", onTap: onEdit),
          divider(),
          ProfileOptionItem(icon: Icons.directions_car, label: "My Vehicles", onTap: onVehicles),
          divider(),
          ProfileOptionItem(icon: Icons.event_note, label: "My Bookings", onTap: onBookings),
          divider(),
          ProfileOptionItem(icon: Icons.settings, label: "Settings", onTap: onSettings),
        ],
      ),
    );
  }
  Widget divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Divider(color: AppColors.divider),
    );
  }
}
