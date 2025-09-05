import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_trip_planner/core/services/auth_service.dart';

/// Firebase implementation of the AuthService
class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  @override
  User? get currentUser => _firebaseAuth.currentUser;
  
  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  
  @override
  bool get isEmailVerified => currentUser?.emailVerified ?? false;
  
  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
  }
  
  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
  }
  
  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
  
  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
  }
  
  @override
  Future<void> sendEmailVerification() async {
    final user = currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }
  
  /// Handle Firebase Auth exceptions and convert to user-friendly messages
  Exception _handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return Exception('No user found for that email.');
      case 'wrong-password':
        return Exception('Wrong password provided for that user.');
      case 'email-already-in-use':
        return Exception('The account already exists for that email.');
      case 'weak-password':
        return Exception('The password provided is too weak.');
      case 'invalid-email':
        return Exception('The email address is not valid.');
      case 'user-disabled':
        return Exception('This user account has been disabled.');
      case 'too-many-requests':
        return Exception('Too many requests. Try again later.');
      case 'operation-not-allowed':
        return Exception('Signing in with Email and Password is not enabled.');
      default:
        return Exception('Authentication failed: ${e.message}');
    }
  }
}
