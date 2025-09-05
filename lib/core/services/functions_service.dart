import 'package:cloud_functions/cloud_functions.dart';

/// Service for Firebase Cloud Functions operations
class FunctionsService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;
  
  /// Call a Firebase Cloud Function
  Future<T> callFunction<T>({
    required String functionName,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final HttpsCallable callable = _functions.httpsCallable(functionName);
      final result = await callable.call(parameters);
      return result.data as T;
    } on FirebaseFunctionsException catch (e) {
      throw _handleFunctionsException(e);
    } catch (e) {
      throw Exception('Failed to call function $functionName: $e');
    }
  }
  
  /// Example function calls for trip planning
  
  /// Generate trip itinerary
  Future<Map<String, dynamic>> generateItinerary({
    required String destination,
    required int days,
    required List<String> interests,
    String? budget,
  }) async {
    return await callFunction<Map<String, dynamic>>(
      functionName: 'generateItinerary',
      parameters: {
        'destination': destination,
        'days': days,
        'interests': interests,
        if (budget != null) 'budget': budget,
      },
    );
  }
  
  /// Get destination recommendations
  Future<List<dynamic>> getDestinationRecommendations({
    required String userPreferences,
  }) async {
    return await callFunction<List<dynamic>>(
      functionName: 'getDestinationRecommendations',
      parameters: {
        'preferences': userPreferences,
      },
    );
  }
  
  /// Save trip to user's profile
  Future<void> saveTripToProfile({
    required String userId,
    required Map<String, dynamic> tripData,
  }) async {
    await callFunction<void>(
      functionName: 'saveTripToProfile',
      parameters: {
        'userId': userId,
        'tripData': tripData,
      },
    );
  }
  
  /// Handle Firebase Functions exceptions
  Exception _handleFunctionsException(FirebaseFunctionsException e) {
    switch (e.code) {
      case 'unauthenticated':
        return Exception('User must be authenticated to call this function.');
      case 'permission-denied':
        return Exception('User does not have permission to call this function.');
      case 'not-found':
        return Exception('The requested function was not found.');
      case 'internal':
        return Exception('Internal server error occurred.');
      case 'unavailable':
        return Exception('Service is temporarily unavailable.');
      case 'deadline-exceeded':
        return Exception('Function call timed out.');
      default:
        return Exception('Function call failed: ${e.message}');
    }
  }
}
