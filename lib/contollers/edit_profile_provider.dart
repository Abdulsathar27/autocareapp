import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class EditProfileProvider extends ChangeNotifier {
  final UserRepository _repo = UserRepository();

  // TEXT CONTROLLERS
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  // STATE
  File? newImage;
  bool isLoading = false;

  // LOAD INITIAL USER DATA
  void loadUser(UserModel? user) {
    nameCtrl.text = user?.name ?? "";
    emailCtrl.text = user?.email ?? "";
    phoneCtrl.text = user?.phone ?? "";
  }

  // PICK NEW IMAGE
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      newImage = File(picked.path);
      notifyListeners();
    }
  }

  // SAVE PROFILE
  Future<bool> saveProfile({
    required String userId,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      await _repo.updateUser(
        userId as UserModel,
        name: nameCtrl.text.trim(),
        email: emailCtrl.text.trim(),
        phone: phoneCtrl.text.trim(),
        imageFile: newImage,
      );

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // CLEANUP
  void disposeControllers() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
  }
}
