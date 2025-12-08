import 'dart:developer';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';
import '../contollers/user_auth_provider.dart';
import '../contollers/user_provider.dart';

class AuthResult {
  final bool success;
  final String? error;
  AuthResult({required this.success, this.error});
}
class AuthController {
  final AuthRepository authRepo = AuthRepository();
  final UserRepository userRepo = UserRepository();
  // LOAD USER
  Future<void> loadUser(String uid, UserProvider userProvider) async {
    final user = await userRepo.getUser(uid);
    if (user != null) {
      userProvider.setUser(user);
    }
  }
  // LOGIN WITH EMAIL
  Future<AuthResult> loginWithEmail({
    required String email,
    required String password,
    required UserAuthProvider authProvider,
  }) async {
    try {
      authProvider.setEmailLoading(true);
      final firebaseUser = await authRepo.loginWithEmail(
        email: email,
        password: password,
      );
      if (firebaseUser == null) {
        return AuthResult(success: false, error: "Invalid credentials");
      }
      return AuthResult(success: true);
    } catch (e) {
      return AuthResult(success: false, error: e.toString());
    } finally {
      authProvider.setEmailLoading(false);
    }
  }
  // LOGIN WITH GOOGLE
  Future<AuthResult> loginWithGoogle({
    required UserAuthProvider authProvider,
    UserProvider? userProvider,
  }) async {
    try {
      authProvider.setGoogleLoading(true);

      final firebaseUser = await authRepo.loginWithGoogle();

      if (firebaseUser == null) {
        return AuthResult(success: false, error: "Google sign-in cancelled");
      }
      // Check Firestore for user
      final existing = await userRepo.getUser(firebaseUser.uid);
      if (existing == null) {
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
        userProvider?.setUser(newUser);
      } else {
        userProvider?.setUser(existing);
      }
      return AuthResult(success: true);
    } catch (e) {
      log(e.toString());
      return AuthResult(success: false, error: e.toString());
    } finally {
      authProvider.setGoogleLoading(false);
    }
  }
  // REGISTER WITH EMAIL
  Future<AuthResult> registerWithEmail({
    required String name,
    required String email,
    required String password,
    required String phone,
    required UserAuthProvider authProvider,
    UserProvider? userProvider,
  }) async {
    try {
      authProvider.setEmailLoading(true);

      final firebaseUser = await authRepo.registerWithEmail(
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
      await userRepo.createUser(newUser);
      userProvider?.setUser(newUser);
      return AuthResult(success: true);
    } catch (e) {
      return AuthResult(success: false, error: e.toString());
    } finally {
      authProvider.setEmailLoading(false);
    }
  }
}
