import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/contollers/home_nav_provider.dart';
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
    final nav = context.watch<HomeNavProvider>();

    final screens = const [
      HomeDashboard(),
      BookingView(),
      VehicleListView(),
      ProfileView(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: screens[nav.index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: nav.index,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: AppColors.textSecondary,
        backgroundColor: AppColors.cardBackground,
        type: BottomNavigationBarType.fixed,
        onTap: (i) => context.read<HomeNavProvider>().setIndex(i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.event_note), label: "Bookings"),
          BottomNavigationBarItem(icon: Icon(Icons.car_repair), label: "Vehicles"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}


