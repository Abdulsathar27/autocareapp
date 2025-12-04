import 'package:autocare/views/profile/widgets/profile/logout_button.dart';
import 'package:autocare/views/profile/widgets/profile/profile_header.dart';
import 'package:autocare/views/profile/widgets/profile/profile_info.dart';
import 'package:autocare/views/profile/widgets/profile/profile_option_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../../contollers/user_provider.dart';
import '../../core/utils/helpers.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: true,
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingMD),
        child: Column(
          children: [
            const SizedBox(height: AppSizes.paddingMD),
            ProfileHeader(imageUrl: user?.profileImage),
            const SizedBox(height: AppSizes.paddingMD),
            ProfileInfo(
              name: user?.name ?? "User",
              email: user?.email ?? "No Email",
              phone: user?.phone ?? "No Phone",
            ),
            const SizedBox(height: AppSizes.paddingMD),
            ProfileOptionList(
              onEdit: () => Navigator.pushNamed(context, "/edit-profile"),
              onVehicles: () => Navigator.pushNamed(context, "/vehicle-list"),
              onBookings: () => Navigator.pushNamed(context, "/my-bookings"),
              onSettings: () {}, 
            ),
            const SizedBox(height: AppSizes.paddingMD),
            LogoutButton(
              onLogout: () {
                userProvider.clearUser();
                Navigator.pushNamedAndRemoveUntil(
                    context, "/login", (_) => false);
                Helpers.showSnackBar(context, "Logged out",
                    backgroundColor: AppColors.redButton);
              },
            ),
          ],
        ),
      ),
    );
  }
}
