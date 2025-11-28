import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

// Providers
import '../../providers/vehicle_provider.dart';
import '../../providers/user_auth_provider.dart';

// Custom widgets
import '../../widgets/vehicle/add/add_vehicle_image_picker.dart';
import '../../widgets/vehicle/add/add_vehicle_form_fields.dart';
import '../../widgets/vehicle/add/add_vehicle_type_dropdown.dart';
import '../../widgets/vehicle/add/add_vehicle_submit_button.dart';

class AddVehicleView extends StatefulWidget {
  const AddVehicleView({super.key});

  @override
  State<AddVehicleView> createState() => _AddVehicleViewState();
}

class _AddVehicleViewState extends State<AddVehicleView> {
  final nameCtrl = TextEditingController();
  final modelCtrl = TextEditingController();
  final numberCtrl = TextEditingController();

  final picker = ImagePicker();

  String? selectedType;
  File? selectedImage;
  bool isLoading = false;

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => selectedImage = File(picked.path));
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<UserAuthProvider>();
    final vehicleProvider = context.watch<VehicleProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        centerTitle: true,
        elevation: 0,
        title: const Text("Add Vehicle"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingMD),
        child: Column(
          children: [
            /// Image Picker
            AddVehicleImagePicker(
              image: selectedImage,
              onPick: pickImage,
            ),

            const SizedBox(height: 30),

            /// Form fields
            AddVehicleFormFields(
              nameCtrl: nameCtrl,
              modelCtrl: modelCtrl,
              numberCtrl: numberCtrl,
            ),

            const SizedBox(height: 20),

            /// Dropdown
            AddVehicleTypeDropdown(
              selectedType: selectedType,
              onChanged: (value) => setState(() => selectedType = value),
            ),

            const SizedBox(height: 30),

            /// Submit button
            AddVehicleSubmitButton(
              isLoading: isLoading,
              selectedType: selectedType,
              name: nameCtrl.text.trim(),
              model: modelCtrl.text.trim(),
              number: numberCtrl.text.trim(),
              image: selectedImage,
              auth: auth,
              provider: vehicleProvider,
              onSuccess: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
