import 'package:autocare/views/booking/booking_services.dart';
import 'package:autocare/views/booking/my_bookings_view.dart';
import 'package:flutter/material.dart';

// Views
import '../views/auth/login_view.dart';
import '../views/auth/register_view.dart';
import '../views/auth/phone_auth_view.dart';

import '../views/home/home_view.dart';

import '../views/vehicle/vehicle_list_view.dart';
import '../views/vehicle/add_vehicle_view.dart';
import '../views/vehicle/vehicle_details_view.dart';

import '../views/booking/booking_view.dart';
import '../views/booking/booking_summary_view.dart';
import '../views/booking/booking_success_view.dart';


import '../views/profile/profile_view.dart';
import '../views/profile/edit_profile_view.dart';

class AppRoutes {
  // GLOBAL NAVIGATOR KEY
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // ROUTE NAMES
  static const String initialRoute = '/login';

  static const String login = '/login';
  static const String register = '/register';
  static const String phoneAuth = '/phone-auth';

  static const String home = '/home';

  static const String vehicleList = '/vehicle-list';
  static const String addVehicle = '/add-vehicle';
  static const String vehicleDetails = '/vehicle-details';

  static const String booking = '/booking';
  static const String myBookings = "/my-bookings";
  static const String bookingServices = '/booking-services'; // <---- ADDED
  static const String bookingSummary = '/booking-summary';
  static const String bookingSuccess = '/booking-success';

  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';

  // ROUTES MAP
  static Map<String, WidgetBuilder> routes = {
    login: (_) => const LoginView(),
    register: (_) => const RegisterView(),
    phoneAuth: (_) => const PhoneAuthView(),

    home: (_) => const HomeView(),

    vehicleList: (_) => const VehicleListView(),
    addVehicle: (_) => const AddVehicleView(),
    vehicleDetails: (_) => const VehicleDetailsView(),

    booking: (_) => const BookingView(),
    myBookings: (_) => const MyBookingsView(),

    bookingServices: (_) => const BookingServicesView(), // <---- ADDED
    bookingSummary: (_) => const BookingSummaryView(),
    bookingSuccess: (_) => const BookingSuccessView(),

    profile: (_) => const ProfileView(),
    editProfile: (_) => const EditProfileView(),
  };
}
