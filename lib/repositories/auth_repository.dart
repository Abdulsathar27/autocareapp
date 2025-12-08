import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // GoogleSignIn instance (scopes can be adjusted)
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  User? get currentUser => _auth.currentUser;
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  /// Email login (named params)
  Future<User?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final result = await _auth.signInWithEmailAndPassword(
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
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  /// Google Sign-In flow (returns Firebase User or null if cancelled)
  Future<User?> loginWithGoogle() async {
    try {
      
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
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
      final userCred = await _auth.signInWithCredential(credential);
      return userCred.user;
    } catch (e) {
      
      rethrow;
    }
  }

  /// Logout (clears Google session too) not using anywhere
  Future<void> logout() async {
    try {
      
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.disconnect();
      }
    } catch (_) {
      
    }
    await _auth.signOut();
  }
}
