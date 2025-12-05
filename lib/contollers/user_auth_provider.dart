import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuthProvider extends ChangeNotifier {
  // LOGIN LOADING STATES
  bool _isEmailLoading = false;
  bool _isGoogleLoading = false;

  // USER (FIRESTORE MODEL)
  UserModel? _user;

  // GETTERS
  bool get isEmailLoading => _isEmailLoading;
  bool get isGoogleLoading => _isGoogleLoading;
  UserModel? get currentUser => _user;

  // Firebase User
  User? get firebaseUser => FirebaseAuth.instance.currentUser;
  String? get currentUserId => firebaseUser?.uid;

  // SET LOADING STATES
  void setEmailLoading(bool value) {
    _isEmailLoading = value;
    notifyListeners();
  }

  void setGoogleLoading(bool value) {
    _isGoogleLoading = value;
    notifyListeners();
  }

  // SET USER
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
