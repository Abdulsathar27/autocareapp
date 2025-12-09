import 'dart:developer';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';

class AuthResult {
  final bool success;
  final String? error;
  final UserModel? user;

  AuthResult({
    required this.success,
    this.error,
    this.user,
  });
}

class AuthController {
  final AuthRepository authRepo = AuthRepository();
  final UserRepository userRepo = UserRepository();

  // -----------------------------------------------------------
  // EMAIL LOGIN
  // -----------------------------------------------------------
  Future<AuthResult> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final firebaseUser = await authRepo.loginWithEmail(
        email: email,
        password: password,
      );

      if (firebaseUser == null) {
        return AuthResult(
          success: false,
          error: "Invalid email or password",
        );
      }

      // Load Firestore user
      final userData = await userRepo.getUser(firebaseUser.uid);

      return AuthResult(
        success: true,
        user: userData,
      );
    } catch (e, st) {
      log("loginWithEmail error: $e\n$st");
      return AuthResult(success: false, error: e.toString());
    }
  }

  // -----------------------------------------------------------
  // GOOGLE LOGIN
  // -----------------------------------------------------------
  Future<AuthResult> loginWithGoogle() async {
    try {
      final firebaseUser = await authRepo.loginWithGoogle();

      if (firebaseUser == null) {
        return AuthResult(
          success: false,
          error: "Google sign-in cancelled",
        );
      }

      // Check if user exists in Firestore
      final existingUser = await userRepo.getUser(firebaseUser.uid);

      if (existingUser != null) {
        return AuthResult(
          success: true,
          user: existingUser,
        );
      }

      // Create new Firestore user
      final newUser = UserModel(
        id: firebaseUser.uid,
        name: firebaseUser.displayName ?? "",
        email: firebaseUser.email ?? "",
        phone: firebaseUser.phoneNumber ?? "",
        profileImage: firebaseUser.photoURL,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await userRepo.createUser(newUser);

      return AuthResult(success: true, user: newUser);
    } catch (e, st) {
      log("loginWithGoogle error: $e\n$st");
      return AuthResult(success: false, error: e.toString());
    }
  }

  // -----------------------------------------------------------
  // REGISTER WITH EMAIL
  // -----------------------------------------------------------
  Future<AuthResult> registerWithEmail({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final firebaseUser = await authRepo.registerWithEmail(
        email: email,
        password: password,
      );

      if (firebaseUser == null) {
        return AuthResult(
          success: false,
          error: "Registration failed",
        );
      }

      // Create new Firestore user data
      final newUser = UserModel(
        id: firebaseUser.uid,
        name: name,
        email: email,
        phone: phone,
        profileImage: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await userRepo.createUser(newUser);

      return AuthResult(
        success: true,
        user: newUser,
      );
    } catch (e, st) {
      log("registerWithEmail error: $e\n$st");
      return AuthResult(success: false, error: e.toString());
    }
  }

  // ---------------------------
// LOAD USER BY UID (PURE)
// ---------------------------
Future<UserModel?> loadUser(String uid) async {
  try {
    final user = await userRepo.getUser(uid);
    return user; // may be null if not found
  } catch (e) {
    return null;
  }
}

}
