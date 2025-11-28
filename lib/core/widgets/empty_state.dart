import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String message;
  final String? imagePath; // supports your uploaded images (/mnt/data/*.png)
  final double imageSize;

  const EmptyState({
    super.key,
    required this.title,
    required this.message,
    this.imagePath,
    this.imageSize = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingLG),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // IMAGE (optional)
            if (imagePath != null) ...[
              SizedBox(
                height: imageSize,
                width: imageSize,
                child: Image.network(
                  imagePath!,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => const Icon(
                    Icons.info_outline,
                    size: 48,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // TITLE
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: AppSizes.fontXL,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 10),

            // MESSAGE
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: AppSizes.fontMD,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
