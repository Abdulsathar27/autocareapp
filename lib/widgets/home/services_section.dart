import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import 'service_card.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Services",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSizes.paddingMD),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: AppSizes.paddingMD,
          mainAxisSpacing: AppSizes.paddingMD,
          childAspectRatio: 1.2,
          children: const [
            ServiceCard(icon: Icons.car_repair, label: "General Service"),
            ServiceCard(icon: Icons.build_circle, label: "Repair Work"),
            ServiceCard(icon: Icons.local_car_wash, label: "Car Wash"),
            ServiceCard(icon: Icons.tire_repair, label: "Tyre Service"),
          ],
        ),
      ],
    );
  }
}

