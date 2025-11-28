import 'package:flutter/material.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_sizes.dart';

class VehicleDetailsImage extends StatelessWidget {
  final String? image;

  const VehicleDetailsImage({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    const fallbackAsset = AppAssets.homeScreen;
    final isNetwork = (image ?? "").startsWith("http");

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: AppColors.iconBgGreen,
        borderRadius: BorderRadius.circular(AppSizes.radiusXL),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusXL),
        child: image == null || image!.isEmpty
            ? Image.asset(fallbackAsset, fit: BoxFit.cover)
            : isNetwork
                ? Image.network(
                    image!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Image.asset(fallbackAsset, fit: BoxFit.cover),
                  )
                : Image.asset(
                    image!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Image.asset(fallbackAsset, fit: BoxFit.cover),
                  ),
      ),
    );
  }
}
