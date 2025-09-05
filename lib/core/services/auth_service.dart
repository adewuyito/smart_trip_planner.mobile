import 'package:firebase_auth/firebase_auth.dart';

/// Authentication service interface for Firebase Auth operations
abstract class AuthService {
  /// Current authenticated user
  User? get currentUser;
  
  /// Stream of authentication state changes
  Stream<User?> get authStateChanges;
  
  /// Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  
  /// Create user with email and password
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });
  
  /// Sign out current user
  Future<void> signOut();
  
  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email);
  
  /// Send email verification
  Future<void> sendEmailVerification();
  
  /// Check if current user's email is verified
  bool get isEmailVerified;
}
