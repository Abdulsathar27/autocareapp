// lib/widgets/services/service_card.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.label,
  });

  // ---------------------------------------------------------
  // ROUTING MAP (Safe & Avoids If-Else chains)
  // ---------------------------------------------------------
  String _getRoute() {
    switch (label) {
      case "General Service":
        return "/service-general";
      case "Repair Work":
        return "/service-repair";
      case "Car Wash":
        return "/service-wash";
      case "Tyre Service":
        return "/service-tyre";
      default:
        return "/service-general"; // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSizes.radiusLG),
      splashColor: AppColors.primaryGreen.withOpacity(0.1),
      onTap: () => Navigator.pushNamed(context, _getRoute()),

      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppSizes.radiusLG),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,     // FIX: no dark shading
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ICON BOX
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: AppColors.iconBgGreen,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: AppColors.primaryGreen,
                size: 28,
              ),
            ),

            const SizedBox(height: AppSizes.paddingSM),

            // LABEL
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
