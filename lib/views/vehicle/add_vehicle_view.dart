import 'package:autocare/contollers/add_vehicle_form_provider.dart';
import 'package:autocare/contollers/user_auth_provider.dart';
import 'package:autocare/contollers/vehicle_provider.dart';
import 'package:autocare/services/vehicle_controller.dart';
import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/vehicle/add/add_vehicle_image_picker.dart';
import 'widgets/vehicle/add/add_vehicle_form_fields.dart';
import 'widgets/vehicle/add/add_vehicle_type_dropdown.dart';
import 'widgets/vehicle/add/add_vehicle_submit_button.dart';

class AddVehicleView extends StatelessWidget {
  const AddVehicleView({super.key});

  @override
  Widget build(BuildContext context) {
    final form = context.watch<AddVehicleFormProvider>();
    final auth = context.read<UserAuthProvider>();
    final vehicleProvider = context.read<VehicleProvider>();
    final controller = VehicleController();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Add Vehicle"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingMD),
        child: Column(
          children: [
            // IMAGE PICKER
            AddVehicleImagePicker(
              image: form.selectedImage,
              onPick: form.pickImage,
            ),

            const SizedBox(height: 30),

            // TEXT FIELDS
            AddVehicleFormFields(
              nameCtrl: form.nameCtrl,
              modelCtrl: form.modelCtrl,
              numberCtrl: form.numberCtrl,
            ),

            const SizedBox(height: 20),

            // DROPDOWN
            AddVehicleTypeDropdown(
              selectedType: form.selectedType,
              onChanged: form.setType,
            ),

            const SizedBox(height: 30),

            // SUBMIT BUTTON
            AddVehicleSubmitButton(
              isLoading: form.isSubmitting,
              onPressed: () async {
                if (!form.isValid()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please fill all fields"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                form.setSubmitting(true);

                await controller.addVehicle(
                  context: context,
                  userId: auth.currentUserId!,
                  vehicleName: form.nameCtrl.text.trim(),
                  vehicleModel: form.modelCtrl.text.trim(),
                  vehicleNumber: form.numberCtrl.text.trim(),
                  vehicleType: form.selectedType!,
                  imageUrl: null, // upload later
                  provider: vehicleProvider,
                );

                form.setSubmitting(false);
                form.resetForm();

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
