import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/constants/app_sizes.dart';
import 'package:autocare/constants/app_strings.dart';
import 'package:autocare/controller/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});
  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>().user;
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.iconBgGreen,
          child: user?.profileImage == null
              ? const Icon(Icons.person,
                  color: AppColors.primaryGreen, size: AppSizes.iconLG2)
              : ClipOval(
                  child: Image.network(
                    user!.profileImage!,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.person,
                      color: AppColors.primaryGreen,
                      size: AppSizes.iconLG2,
                    ),
                  ),
                ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.welcome,
              style: GoogleFonts.poppins(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            Text(
              user?.name ?? "User",
              style: GoogleFonts.poppins(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
