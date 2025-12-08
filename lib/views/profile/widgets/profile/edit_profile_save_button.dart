
import 'package:autocare/constants/app_strings.dart';
import 'package:flutter/material.dart';

class EditProfileSaveButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onSave;

  const EditProfileSaveButton({
    super.key,
    required this.isLoading,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onSave,
      child: isLoading
          ? const CircularProgressIndicator()
          : const Text(AppStrings.saveChanges),
    );
  }
}
