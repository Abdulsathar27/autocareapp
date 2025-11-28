import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';

class VehicleListAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const VehicleListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0.4,
      centerTitle: true,
      title: Text(
        "My Vehicles",
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => Navigator.pushNamed(context, "/add-vehicle"),
          icon: const Icon(
            Icons.add_circle_outline,
            color: AppColors.primaryGreen,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
