
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;

  final UserRepository _userRepo = UserRepository();

    // GETTERS
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;

  
  String? get userId => _user?.id;

   // SETTERS
  
  void setUser(UserModel? model) {
    _user = model;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

   // LOAD USER FROM FIRESTORE
  
  Future<void> loadUser(String uid) async {
    setLoading(true);
    try {
      final fetchedUser = await _userRepo.getUser(uid);
      if (fetchedUser != null) {
        _user = fetchedUser;
      }
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  
  // CORRECT LOGOUT
  
  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
