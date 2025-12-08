import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
  
class AddVehicleFormProvider extends ChangeNotifier {
  // Text controllers
  final nameCtrl = TextEditingController();
  final modelCtrl = TextEditingController();
  final numberCtrl = TextEditingController();

  // Dropdown & Image
  String? selectedType;
  File? selectedImage;

  // Loading
  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  final ImagePicker picker = ImagePicker();

  // Pick image
  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedImage = File(picked.path);
      notifyListeners();
    }
  }

  // Set vehicle type
  void setType(String? value) {
    selectedType = value;
    notifyListeners();
  }

  // Set form loading
  void setSubmitting(bool value) {
    _isSubmitting = value;
    notifyListeners();
  }

  // Validate form
  bool isValid() {
    return nameCtrl.text.isNotEmpty &&
        modelCtrl.text.isNotEmpty &&
        numberCtrl.text.isNotEmpty &&
        selectedType != null;
  }

  // Clear form after submit
  void resetForm() {
    nameCtrl.clear();
    modelCtrl.clear();
    numberCtrl.clear();
    selectedType = null;
    selectedImage = null;
    _isSubmitting = false;
    notifyListeners();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    modelCtrl.dispose();
    numberCtrl.dispose();
    super.dispose();
  }
}
