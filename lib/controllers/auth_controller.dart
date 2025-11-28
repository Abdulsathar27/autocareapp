// lib/controllers/auth_controller.dart


import '../models/user_model.dart';
import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';
import '../providers/user_auth_provider.dart';
import '../providers/user_provider.dart';

// Simple result wrapper
class AuthResult {
  final bool success;
  final String? error;

  AuthResult({required this.success, this.error});
}

class AuthController {
  final AuthRepository _authRepo = AuthRepository();
  final UserRepository _userRepo = UserRepository();

  // ---------------------------------------------------------
  // LOAD USER (used in main.dart)
  // ---------------------------------------------------------
  Future<void> loadUser(String uid, UserProvider userProvider) async {
    final user = await _userRepo.getUser(uid);
    if (user != null) userProvider.setUser(user);
  }

  // ---------------------------------------------------------
  // LOGIN WITH EMAIL
  // ---------------------------------------------------------
  Future<AuthResult> loginWithEmail({
    required String email,
    required String password,
    required UserAuthProvider authProvider,
  }) async {
    try {
      authProvider.setLoading(true);

      final user = await _authRepo.loginWithEmail(
        email: email,
        password: password,
      );

      if (user == null) return AuthResult(success: false, error: "Invalid credentials");

      // Optionally we could load UserProvider here, but LoginView currently only calls this.
      return AuthResult(success: true);
    } catch (e) {
      return AuthResult(success: false, error: e.toString());
    } finally {
      authProvider.setLoading(false);
    }
  }

  // ---------------------------------------------------------
  // LOGIN WITH GOOGLE
  // ---------------------------------------------------------
  Future<AuthResult> loginWithGoogle({
    required UserAuthProvider authProvider,
    UserProvider? userProvider, // optional: controller can populate userProvider if passed
  }) async {
    try {
      authProvider.setLoading(true);

      final user = await _authRepo.loginWithGoogle();

      if (user == null) return AuthResult(success: false, error: "Google sign-in cancelled");

      // Ensure Firestore user exists; create if missing
      final existing = await _userRepo.getUser(user.uid);
      if (existing == null) {
        final created = UserModel(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
          phone: user.phoneNumber ?? '',
          profileImage: user.photoURL,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await _userRepo.createUser(created);
        if (userProvider != null) userProvider.setUser(created);
      } else {
        if (userProvider != null) userProvider.setUser(existing);
      }

      return AuthResult(success: true);
    } catch (e) {
      return AuthResult(success: false, error: e.toString());
    } finally {
      authProvider.setLoading(false);
    }
  }

  // ---------------------------------------------------------
  // REGISTER WITH EMAIL
  // ---------------------------------------------------------
  // NOTE: userProvider is optional for backward compatibility
  Future<AuthResult> registerWithEmail({
    required String name,
    required String email,
    required String password,
    required String phone,
    required UserAuthProvider authProvider,
    UserProvider? userProvider, // optional
  }) async {
    try {
      authProvider.setLoading(true);

      final firebaseUser = await _authRepo.registerWithEmail(
        email: email,
        password: password,
      );

      if (firebaseUser == null) {
        return AuthResult(success: false, error: "Registration failed");
      }

      final newUser = UserModel(
        id: firebaseUser.uid,
        name: name,
        email: email,
        phone: phone,
        profileImage: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Create Firestore doc
      await _userRepo.createUser(newUser);

      // If caller passed a userProvider, populate it now
      if (userProvider != null) {
        userProvider.setUser(newUser);
      }

      return AuthResult(success: true);
    } catch (e) {
      return AuthResult(success: false, error: e.toString());
    } finally {
      authProvider.setLoading(false);
    }
  }
}
