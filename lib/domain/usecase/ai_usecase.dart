import 'package:smart_trip_planner/domain/agent/main_agent.dart';
import 'package:smart_trip_planner/domain/entities/itinerary_entities.dart';


class CreateItineraryUseCase {
  final AIAgent _agent;

  CreateItineraryUseCase(String apiKey) : _agent = AIAgent(apiKey);

  Stream<Itinerary> execute(String prompt) {
    return _agent.generateItinerary(
      prompt: prompt,
      previousItinerary: null,
      chatHistory: [],
    );
  }
}

class RefineItineraryUseCase {
  final AIAgent _agent;

  RefineItineraryUseCase(String apiKey) : _agent = AIAgent(apiKey);

  Stream<Itinerary> execute({
    required String prompt,
    required Itinerary previousItinerary,
    required List<String> chatHistory,
  }) {
    return _agent.generateItinerary(
      prompt: prompt,
      previousItinerary: previousItinerary,
      chatHistory: chatHistory,
    );
  }
}