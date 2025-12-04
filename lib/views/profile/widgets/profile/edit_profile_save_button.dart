import 'dart:io';
import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/contollers/user_provider.dart';
import 'package:autocare/core/widgets/custom_button.dart';
import 'package:autocare/services/user_controller.dart';
import 'package:flutter/material.dart';

class EditProfileSaveButton extends StatelessWidget {
  final bool isLoading;
  final UserProvider userProvider;
  final String name;
  final String email;
  final String phone;
  final File? image;
  const EditProfileSaveButton({
    super.key,
    required this.isLoading,
    required this.userProvider,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "Save Changes",
      isLoading: isLoading,
      onPressed: () async {
        final uid = userProvider.user?.id;
        if (uid == null || uid.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User not loaded. Please login again.")),
          );
          return;
        }
        bool ok = await UserController().updateProfile(
          uid: uid,
          userProvider: userProvider,
          name: name,
          email: email,
          phone: phone,
          imageFile: image,
        );
        if (ok) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profile updated successfully")),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Update failed"),
              backgroundColor: AppColors.redButton,
            ),
          );
        }
      },
    );
  }
}
