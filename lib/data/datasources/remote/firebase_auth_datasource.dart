import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/firebase/firebase_config.dart';

/// Firebase Auth Data Source
/// Handles all authentication operations
class FirebaseAuthDataSource {
  final FirebaseAuth _auth;

  FirebaseAuthDataSource() : _auth = FirebaseConfig.auth;

  /// Get current user
  User? get currentUser => _auth.currentUser;

  /// Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException('Sign in failed: ${e.message}');
    } catch (e) {
      throw AuthException('Unexpected error during sign in: $e');
    }
  }

  /// Sign up with email and password
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException('Sign up failed: ${e.message}');
    } catch (e) {
      throw AuthException('Unexpected error during sign up: $e');
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw AuthException('Sign out failed: $e');
    }
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException('Password reset failed: ${e.message}');
    } catch (e) {
      throw AuthException('Unexpected error during password reset: $e');
    }
  }

  /// Update user profile
  Future<void> updateProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw AuthException('No user signed in');
      }
      await user.updateDisplayName(displayName);
      await user.updatePhotoURL(photoURL);
    } catch (e) {
      throw AuthException('Profile update failed: $e');
    }
  }

  /// Delete user account
  Future<void> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw AuthException('No user signed in');
      }
      await user.delete();
    } catch (e) {
      throw AuthException('Account deletion failed: $e');
    }
  }
}

/// Auth Exception
class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  
  @override
  String toString() => message;
}

