import 'package:autocare/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class ServiceDescriptionView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final List<String> features;
  const ServiceDescriptionView({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.features,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingLG),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 45,
                backgroundColor: AppColors.iconBgGreen,
                child: Icon(icon, size: 48, color: AppColors.primaryGreen),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: 15,
                height: 1.6,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Text(
              AppStrings.included,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ...features.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item,
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
