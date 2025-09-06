import 'package:smart_trip_planner/domain/agent/main_agent.dart';
import 'package:smart_trip_planner/domain/entities/itinerary_entities.dart';

abstract class LLMDataSource {
  Stream<Itinerary> generateItinerary({
    required String prompt,
    Itinerary? previousItinerary,
    required List<String> chatHistory,
  });
}

class LLMDataSourceImpl implements LLMDataSource {
  final String _apiKey;

  LLMDataSourceImpl(this._apiKey);

  @override
  Stream<Itinerary> generateItinerary({
    required String prompt,
    Itinerary? previousItinerary,
    required List<String> chatHistory,
  }) {
    return Stream.fromFuture(
      generateItineraryInIsolate(
        prompt: prompt,
        previousItinerary: previousItinerary,
        chatHistory: chatHistory,
        apiKey: _apiKey,
      ),
    ).asyncExpand((stream) => stream);
    
  }
}
