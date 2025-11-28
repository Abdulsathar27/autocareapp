import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  UserModel? _user;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Firebase user (authentication only)
  User? get firebaseUser => FirebaseAuth.instance.currentUser;
  String? get currentUserId => firebaseUser?.uid;

  // Full user model stored locally
  UserModel? get currentUser => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    clearUser();
  }
}
