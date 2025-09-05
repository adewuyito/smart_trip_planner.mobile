import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_trip_planner/core/services/auth_service.dart';
import 'package:smart_trip_planner/core/services/firebase_auth_service.dart';
import 'package:smart_trip_planner/core/services/functions_service.dart';

/// Provider for the AuthService implementation
final authServiceProvider = Provider<AuthService>((ref) {
  return FirebaseAuthService();
});

/// Provider for the current user stream
final authStateChangesProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

/// Provider for the current user
final currentUserProvider = Provider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.currentUser;
});

/// Provider to check if user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user != null;
});

/// Provider to check if user email is verified
final isEmailVerifiedProvider = Provider<bool>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.isEmailVerified;
});

/// Provider for the Functions service
final functionsServiceProvider = Provider<FunctionsService>((ref) {
  return FunctionsService();
});
