import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config/theme/app_theme.dart';
import 'routes/app_routes.dart';

class AutoCareGarageApp extends StatelessWidget {
  const AutoCareGarageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoCare Garage',
      debugShowCheckedModeBanner: false,

      // ---------------------------------------------------------
      // GLOBAL NAVIGATOR KEY (IMPORTANT FOR CONTROLLERS)
      // ---------------------------------------------------------
      navigatorKey: AppRoutes.navigatorKey,

      // ---------------------------------------------------------
      // THEME
      // ---------------------------------------------------------
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),

      // ---------------------------------------------------------
      // ROUTING
      // ---------------------------------------------------------
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,

      // If route is not found
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                "Page not found",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        );
      },
    );
  }
}
