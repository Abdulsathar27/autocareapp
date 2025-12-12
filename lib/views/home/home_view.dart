import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/constants/app_strings.dart';
import 'package:autocare/controller/home_nav_provider.dart';
import 'package:autocare/views/booking/booking_view.dart';
import 'package:autocare/views/home/widgets/home_dashboard.dart';
import 'package:autocare/views/profile/profile_view.dart';
import 'package:autocare/views/vehicle/vehicle_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final screens = const [
      HomeDashboard(),
      BookingView(),
      VehicleListView(),
      ProfileView(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,

      // BODY listens to provider
      body: Consumer<HomeNavProvider>(
        builder: (_, nav, _) => screens[nav.index],
      ),

      // BOTTOM NAV also listens to provider
      bottomNavigationBar: Consumer<HomeNavProvider>(
        builder: (_, nav, _) => BottomNavigationBar(
          currentIndex: nav.index,
          selectedItemColor: AppColors.primaryGreen,
          unselectedItemColor: AppColors.textSecondary,
          backgroundColor: AppColors.cardBackground,
          type: BottomNavigationBarType.fixed,
          onTap: (i) => nav.setIndex(i),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: AppStrings.home),
            BottomNavigationBarItem(icon: Icon(Icons.event_note), label: AppStrings.booking),
            BottomNavigationBarItem(icon: Icon(Icons.car_repair), label: AppStrings.vehicles),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: AppStrings.profile),
          ],
        ),
      ),
    );
  }
}
