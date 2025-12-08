import 'package:autocare/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config/theme/app_theme.dart';
import 'routes/app_routes.dart';

class AutoCareGarageApp extends StatelessWidget {
  const AutoCareGarageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      // GLOBAL NAVIGATOR KEY 
      navigatorKey: AppRoutes.navigatorKey,
      // THEME
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      // ROUTING
     initialRoute: AppRoutes.initialRoute,
     routes: AppRoutes.routes,
     onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                AppStrings.errorSomethingWrong,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        );
      },
    );
  }
}
