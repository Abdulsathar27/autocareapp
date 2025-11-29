import 'package:flutter/material.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AddVehicleTypeDropdown extends StatelessWidget {
  final String? selectedType;
  final ValueChanged<String?> onChanged;

  const AddVehicleTypeDropdown({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Vehicle Type",
          style: GoogleFonts.poppins(
            fontSize: AppSizes.fontMD,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedType,
              items: const [
                DropdownMenuItem(value: "Car", child: Text("Car")),
                DropdownMenuItem(value: "Bike", child: Text("Bike")),
              ],
              hint: const Text("Select Type"),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
