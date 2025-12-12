import 'dart:async';
import 'package:autocare/controller/add_vehicle_form_provider.dart';
import 'package:autocare/controller/booking_form_provider.dart';
import 'package:autocare/controller/booking_provider.dart';
import 'package:autocare/controller/edit_profile_provider.dart';
import 'package:autocare/controller/home_nav_provider.dart';
import 'package:autocare/controller/login_form_provider.dart';
import 'package:autocare/controller/register_form_provider.dart';
import 'package:autocare/controller/user_auth_provider.dart';
import 'package:autocare/controller/user_provider.dart';
import 'package:autocare/controller/vehicle_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'routes/app_routes.dart';
import 'services/auth_services.dart';

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
        ChangeNotifierProvider(create: (_) => RegisterFormProvider()),
        ChangeNotifierProvider(create: (_) => LoginFormProvider()),
        ChangeNotifierProvider(create: (_) => BookingFormProvider()),
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
            if (!ctx.mounted) return;
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

      if (ctx == null) return;

      if (!ctx.mounted) return;
      final userProvider = Provider.of<UserProvider>(ctx, listen: false);
      // FIXED: load user using updated AuthController
      final userModel = await AuthController().loadUser(firebaseUser.uid);
      if (userModel != null) {
        userProvider.setUser(userModel);
      }
    } catch (e, st) {
      // handle error quietly or log
    }
  });
}
