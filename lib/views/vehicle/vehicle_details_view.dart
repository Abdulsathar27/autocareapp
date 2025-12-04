import 'package:autocare/views/vehicle/widgets/vehicle/details/vehicle_details_delete_button.dart';
import 'package:autocare/views/vehicle/widgets/vehicle/details/vehicle_details_edit_button.dart';
import 'package:autocare/views/vehicle/widgets/vehicle/details/vehicle_details_image.dart';
import 'package:autocare/views/vehicle/widgets/vehicle/details/vehicle_details_info_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';



class VehicleDetailsView extends StatelessWidget {
  const VehicleDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    final name = (args?["vehicleName"] ?? "Unknown Vehicle").toString();
    final number = (args?["vehicleNumber"] ?? "—").toString();
    final model = (args?["vehicleModel"] ?? "Model Unavailable").toString();
    final type = (args?["vehicleType"] ?? "Car").toString();
    final image = args?["vehicleImage"] as String?;
    final id = args?["vehicleId"] as String?;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Vehicle Details", style: GoogleFonts.poppins(fontSize: 20)),
        backgroundColor: AppColors.background,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingMD),
        child: Column(
          children: [
            const SizedBox(height: 10),
            VehicleDetailsImage(image: image),
            const SizedBox(height: 22),
            VehicleDetailsInfoCard(
              name: name,
              model: model,
              number: number,
              type: type,
            ),
            const SizedBox(height: 30),
             VehicleDetailsEditButton(
              vehicleId: id,
              name: name,
              number: number,
              model: model,
              type: type,
              image: image,
            ),
            const SizedBox(height: 14),
            VehicleDetailsDeleteButton(vehicleId: id),
          ],
        ),
      ),
    );
  }
}
