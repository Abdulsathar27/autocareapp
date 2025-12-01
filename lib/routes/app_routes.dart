// lib/routes/app_routes.dart

import 'package:autocare/views/services_pages/car_wash_view.dart';
import 'package:autocare/views/services_pages/general_service_view.dart';
import 'package:autocare/views/services_pages/repair_work_view.dart';
import 'package:autocare/views/services_pages/tyre_service_view.dart';
import 'package:flutter/material.dart';

// -------------------------
// AUTH
// -------------------------
import '../views/auth/login_view.dart';
import '../views/auth/register_view.dart';
import '../views/auth/phone_auth_view.dart';

// -------------------------
// HOME
// -------------------------
import '../views/home/home_view.dart';

// -------------------------
// VEHICLES
// -------------------------
import '../views/vehicle/vehicle_list_view.dart';
import '../views/vehicle/add_vehicle_view.dart';
import '../views/vehicle/vehicle_details_view.dart';

// -------------------------
// BOOKING
// -------------------------
import '../views/booking/booking_view.dart';
import '../views/booking/booking_services.dart';
import '../views/booking/booking_summary_view.dart';
import '../views/booking/booking_success_view.dart';
import '../views/booking/my_bookings_view.dart';

// -------------------------
// PROFILE
// -------------------------
import '../views/profile/profile_view.dart';
import '../views/profile/edit_profile_view.dart';

// -------------------------
// SERVICE DETAILS (NEW)
// -------------------------


class AppRoutes {
  // GLOBAL NAVIGATION KEY
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // INITIAL ROUTE
  static const String initialRoute = '/login';

  // -------------------------
  // ROUTE NAMES
  // -------------------------

  // Auth
  static const String login = '/login';
  static const String register = '/register';
  static const String phoneAuth = '/phone-auth';

  // Home
  static const String home = '/home';

  // Vehicles
  static const String vehicleList = '/vehicle-list';
  static const String addVehicle = '/add-vehicle';
  static const String vehicleDetails = '/vehicle-details';

  // Booking
  static const String booking = '/booking';
  static const String bookingServices = '/booking-services';
  static const String bookingSummary = '/booking-summary';
  static const String bookingSuccess = '/booking-success';
  static const String myBookings = '/my-bookings';

  // Profile
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';

  // Service Details
  static const String serviceGeneral = '/service-general';
  static const String serviceRepair = '/service-repair';
  static const String serviceWash = '/service-wash';
  static const String serviceTyre = '/service-tyre';

  // -------------------------
  // ROUTE WIDGET MAP
  // -------------------------
  static Map<String, WidgetBuilder> routes = {
    // Auth
    login: (_) => const LoginView(),
    register: (_) => const RegisterView(),
    phoneAuth: (_) => const PhoneAuthView(),

    // Home
    home: (_) => const HomeView(),

    // Vehicles
    vehicleList: (_) => const VehicleListView(),
    addVehicle: (_) => const AddVehicleView(),
    vehicleDetails: (_) => const VehicleDetailsView(),

    // Booking
    booking: (_) => const BookingView(),
    bookingServices: (_) => const BookingServicesView(),
    bookingSummary: (_) => const BookingSummaryView(),
    bookingSuccess: (_) => const BookingSuccessView(),
    myBookings: (_) => const MyBookingsView(),

    // Profile
    profile: (_) => const ProfileView(),
    editProfile: (_) => const EditProfileView(),

    // Service Details
    serviceGeneral: (_) => const GeneralServiceView(),
    serviceRepair: (_) => const RepairWorkView(),
    serviceWash: (_) => const CarWashView(),
    serviceTyre: (_) => const TyreServiceView(),
  };
}
