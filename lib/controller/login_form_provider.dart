import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  void clear() {
    emailCtrl.clear();
    passwordCtrl.clear();
    notifyListeners();
  }
}
