import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // GoogleSignIn instance (scopes can be adjusted)
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  User? get currentUser => auth.currentUser;
  Stream<User?> authStateChanges() => auth.authStateChanges();

  /// Email login (named params)
  Future<User?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final result = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  /// Email register (named params)
  Future<User?> registerWithEmail({
    required String email,
    required String password,
  }) async {
    final result = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  /// Google Sign-In flow (returns Firebase User or null if cancelled)
  Future<User?> loginWithGoogle() async {
    try {
      
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        
        return null;
      }

      // Obtain auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create Firebase credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final userCred = await auth.signInWithCredential(credential);
      return userCred.user;
    } catch (e) {
      
      rethrow;
    }
  }

  /// Logout (clears Google session too) not using anywhere
  Future<void> logout() async {
    try {
      
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.disconnect();
      }
    } catch (_) {
      
    }
    await auth.signOut();
  }
}
