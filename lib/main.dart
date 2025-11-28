// lib/main.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'routes/app_routes.dart';

import 'providers/user_auth_provider.dart';
import 'providers/user_provider.dart';
import 'providers/vehicle_provider.dart';
import 'providers/booking_provider.dart';
import 'controllers/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Run the app with providers
  runApp(
    MultiProvider(
      providers: [
        // This is your auth helper provider (wraps firebase auth conveniences)
        ChangeNotifierProvider(create: (_) => UserAuthProvider()),

        // App-level profile provider (loads Firestore user)
        ChangeNotifierProvider(create: (_) => UserProvider()),

        // Domain providers
        ChangeNotifierProvider(create: (_) => VehicleProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: const AutoCareGarageApp(),
    ),
  );

  // ------------------------------------------------------------------
  // Listen to FirebaseAuth changes and load Firestore user into provider
  // ------------------------------------------------------------------
  FirebaseAuth.instance.authStateChanges().listen((firebaseUser) async {
    try {
      // Signed out
      if (firebaseUser == null) {
        // If app context is available, clear the UserProvider so UI updates immediately.
        final ctx = AppRoutes.navigatorKey.currentContext;
        if (ctx != null) {
          try {
            Provider.of<UserProvider>(ctx, listen: false).clearUser();
          } catch (_) {}
        }
        return;
      }

      // Signed in: we need a BuildContext to access UserProvider.
      // AppRoutes.navigatorKey.currentContext might not be ready immediately after runApp,
      // so retry for a short time (max ~2s) until we get a context.
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
        // Could not obtain context — fallback: try to call AuthController.loadUser without context usage.
        // AuthController.loadUser expects (uid, userProvider) — but we don't have userProvider here.
        // Log and exit early to avoid crashes.
        // You can handle a background load elsewhere (for ex: in a splash screen).
        // print('Warning: App context not ready to load UserProvider. User will load later.');
        return;
      }

      // Load Firestore user into UserProvider via AuthController (keeps logic centralized)
      final userProvider = Provider.of<UserProvider>(ctx, listen: false);

      // AuthController.loadUser should set userProvider.setUser(...) internally
      await AuthController().loadUser(firebaseUser.uid, userProvider);
    } catch (e, st) {
      // Never let uncaught errors in this listener crash the app
      // You can optionally log to your error-logger here.
      // print('authStateChanges listener error: $e\n$st');
    }
  });
}
