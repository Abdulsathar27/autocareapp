import 'package:autocare/views/home/widgets/home_header.dart';
import 'package:autocare/views/home/widgets/search_bar.dart';
import 'package:autocare/views/home/widgets/services_section.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../booking/booking_view.dart';
import '../profile/profile_view.dart';
import '../vehicle/vehicle_list_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}
class _HomeViewState extends State<HomeView> {
  int _index = 0;
  final List<Widget> screens = const [
    _HomeDashboard(),
    BookingView(),
    VehicleListView(),
    ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: AppColors.textSecondary,
        backgroundColor: AppColors.cardBackground,
        type: BottomNavigationBarType.fixed,
        onTap: (i) => setState(() => _index = i),
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
class _HomeDashboard extends StatelessWidget {
  const _HomeDashboard();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.paddingMD),
      child: Column(
        children: const [
          SizedBox(height: AppSizes.paddingXL),
          HomeHeader(),
          SizedBox(height: AppSizes.paddingXL),
          HomeSearchBar(),
          SizedBox(height: AppSizes.paddingXL),
          ServicesSection(),
        ],
      ),
    );
  }
}
