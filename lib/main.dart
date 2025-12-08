import 'dart:async';
import 'package:autocare/contollers/add_vehicle_form_provider.dart';
import 'package:autocare/contollers/edit_profile_provider.dart';
import 'package:autocare/contollers/home_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'routes/app_routes.dart';  
import 'contollers/user_auth_provider.dart';
import 'contollers/user_provider.dart';
import 'contollers/vehicle_provider.dart';
import 'contollers/booking_provider.dart';
import 'services/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [ 
        ChangeNotifierProvider(create: (_) => UserAuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => VehicleProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => HomeNavProvider()),
        ChangeNotifierProvider(create: (_) => EditProfileProvider()),
        ChangeNotifierProvider(create: (_) => AddVehicleFormProvider()),
      ],
      child: const AutoCareGarageApp(),
    ),
  );
  
  FirebaseAuth.instance.authStateChanges().listen((firebaseUser) async {
    try {
      if (firebaseUser == null) {
        final ctx = AppRoutes.navigatorKey.currentContext;
        if (ctx != null) {
          try {
            Provider.of<UserProvider>(ctx, listen: false).clearUser();
          } catch (_) {}
        }
        return;
      }
      const int maxRetries = 10;
      const Duration retryDelay = Duration(milliseconds: 200);
      int attempt = 0;
      BuildContext? ctx;

      while (attempt < maxRetries) {
        ctx = AppRoutes.navigatorKey.currentContext;
        if (ctx != null) break;
        attempt++;
        await Future.delayed(retryDelay);
      }
      if (ctx == null) {
        return;
      }
      final userProvider = Provider.of<UserProvider>(ctx, listen: false);
      await AuthController().loadUser(firebaseUser.uid, userProvider);
    } catch (e, st) {
      // print('authStateChanges listener error: $e\n$st');
    }
  });
}
