import 'package:flutter/material.dart';
import '../../../constants/app_sizes.dart';
import 'vehicle_details_info_row.dart';

class VehicleDetailsInfoCard extends StatelessWidget {
  final String name;
  final String model;
  final String number;
  final String type;

  const VehicleDetailsInfoCard({
    super.key,
    required this.name,
    required this.model,
    required this.number,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
        boxShadow: const [
          BoxShadow(
            blurRadius: 12,
            offset: Offset(0, 4),
            color: Colors.black26,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VehicleDetailsInfoRow(label: "Vehicle Name", value: name),
          const SizedBox(height: 14),
          VehicleDetailsInfoRow(label: "Model", value: model),
          const SizedBox(height: 14),
          VehicleDetailsInfoRow(label: "Vehicle Number", value: number),
          const SizedBox(height: 14),
          VehicleDetailsInfoRow(label: "Type", value: type),
        ],
      ),
    );
  }
}
