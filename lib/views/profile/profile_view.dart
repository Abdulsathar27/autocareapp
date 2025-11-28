import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../../providers/user_provider.dart';
import '../../core/utils/helpers.dart';

// Custom Widgets
import '../../widgets/profile/profile_header.dart';
import '../../widgets/profile/profile_info.dart';
import '../../widgets/profile/profile_option_list.dart';
import '../../widgets/profile/logout_button.dart';

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
            const SizedBox(height: 20),

            /// Profile image
            ProfileHeader(imageUrl: user?.profileImage),

            const SizedBox(height: 20),

            /// Basic user info
            ProfileInfo(
              name: user?.name ?? "User",
              email: user?.email ?? "No Email",
              phone: user?.phone ?? "No Phone",
            ),

            const SizedBox(height: 30),

            /// Options list
            ProfileOptionList(
              onEdit: () => Navigator.pushNamed(context, "/edit-profile"),
              onVehicles: () => Navigator.pushNamed(context, "/vehicle-list"),
              onBookings: () => Navigator.pushNamed(context, "/my-bookings"),
              onSettings: () {}, // Add later
            ),

            const SizedBox(height: 30),

            /// Logout Button
            LogoutButton(
              onLogout: () {
                userProvider.clearUser();
                Navigator.pushNamedAndRemoveUntil(
                    context, "/login", (_) => false);
                Helpers.showSnackBar(context, "Logged out",
                    backgroundColor: Colors.red);
              },
            ),
          ],
        ),
      ),
    );
  }
}
