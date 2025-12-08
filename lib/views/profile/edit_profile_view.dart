import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/constants/app_sizes.dart';
import 'package:autocare/constants/app_strings.dart';
import 'package:autocare/contollers/edit_profile_provider.dart';
import 'package:autocare/contollers/user_provider.dart';
import 'package:autocare/views/profile/widgets/profile/edit_profile_form.dart';
import 'package:autocare/views/profile/widgets/profile/edit_profile_image_picker.dart';
import 'package:autocare/views/profile/widgets/profile/edit_profile_save_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    final edit = context.watch<EditProfileProvider>();
    Future.microtask(() {
      edit.loadUser(userProvider.user);
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text(AppStrings.editProfile),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingMD),
        child: Column(
          children: [
            const SizedBox(height: AppSizes.paddingMD),
            /// IMAGE PICKER
            EditProfileImagePicker(
              newImage: edit.newImage,
              userImage: userProvider.user?.profileImage,
              onPick: edit.pickImage,
            ),
            const SizedBox(height: AppSizes.paddingMD),
            /// TEXT FORM FIELDS 
            EditProfileForm(
              nameCtrl: edit.nameCtrl,
              emailCtrl: edit.emailCtrl,
              phoneCtrl: edit.phoneCtrl,
            ),
            const SizedBox(height: AppSizes.paddingMD),
            /// SAVE BUTTON
            EditProfileSaveButton(
              isLoading: edit.isLoading,
              onSave: () async {
                final success = await edit.saveProfile(userId: userProvider.userId!);
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(AppStrings.profileUpdated)),
                  );
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
