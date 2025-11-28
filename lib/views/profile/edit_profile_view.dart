import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../../providers/user_provider.dart';

// Custom Widgets
import '../../widgets/profile/edit_profile_image_picker.dart';
import '../../widgets/profile/edit_profile_form.dart';
import '../../widgets/profile/edit_profile_save_button.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final ImagePicker picker = ImagePicker();
  File? newImage;
  bool isLoading = false;

  late TextEditingController nameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController phoneCtrl;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user;

    nameCtrl = TextEditingController(text: user?.name ?? "");
    emailCtrl = TextEditingController(text: user?.email ?? "");
    phoneCtrl = TextEditingController(text: user?.phone ?? "");
  }

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => newImage = File(picked.path));
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingMD),
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// Image Picker Widget
            EditProfileImagePicker(
              newImage: newImage,
              userImage: user?.profileImage,
              onPick: pickImage,
            ),

            const SizedBox(height: 30),

            /// Form Fields Widget
            EditProfileForm(
              nameCtrl: nameCtrl,
              emailCtrl: emailCtrl,
              phoneCtrl: phoneCtrl,
            ),

            const SizedBox(height: 30),

            /// Save Button Widget
            EditProfileSaveButton(
              isLoading: isLoading,
              userProvider: userProvider,
              name: nameCtrl.text.trim(),
              email: emailCtrl.text.trim(),
              phone: phoneCtrl.text.trim(),
              image: newImage,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
