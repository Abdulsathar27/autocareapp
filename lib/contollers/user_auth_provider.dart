import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import '../services/auth_controller.dart';

class UserAuthProvider extends ChangeNotifier {
  // internal states
  bool _isEmailLoading = false;
  bool _isGoogleLoading = false;
  UserModel? _user;

  final AuthController _authController = AuthController();

  // getters
  bool get isEmailLoading => _isEmailLoading;
  bool get isGoogleLoading => _isGoogleLoading;
  UserModel? get currentUser => _user;

  User? get firebaseUser => FirebaseAuth.instance.currentUser;
  String? get currentUserId => firebaseUser?.uid;

  // ------------------------
  // REGISTER
  // ------------------------
  Future<AuthResult> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    _isEmailLoading = true;
    notifyListeners();

    try {
      final result = await _authController.registerWithEmail(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );

      if (result.success && result.user != null) {
        _user = result.user;
        notifyListeners();
      }

      return result;
    } catch (e) {
      return AuthResult(success: false, error: e.toString());
    } finally {
      _isEmailLoading = false;
      notifyListeners();
    }
  }

  // ------------------------
  // EMAIL LOGIN
  // ------------------------
  Future<AuthResult> loginUser({
    required String email,
    required String password,
  }) async {
    _isEmailLoading = true;
    notifyListeners();

    try {
      final result = await _authController.loginWithEmail(
        email: email,
        password: password,
      );

      if (result.success && result.user != null) {
        _user = result.user;
        notifyListeners();
      }

      return result;
    } catch (e) {
      return AuthResult(success: false, error: e.toString());
    } finally {
      _isEmailLoading = false;
      notifyListeners();
    }
  }

  // ------------------------
  // GOOGLE LOGIN
  // ------------------------
  Future<AuthResult> loginWithGoogle() async {
    _isGoogleLoading = true;
    notifyListeners();

    try {
      final result = await _authController.loginWithGoogle();

      if (result.success && result.user != null) {
        _user = result.user;
        notifyListeners();
      }

      return result;
    } catch (e) {
      return AuthResult(success: false, error: e.toString());
    } finally {
      _isGoogleLoading = false;
      notifyListeners();
    }
  }

  // ------------------------
  // SIGN OUT
  // ------------------------
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
  }

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
