import '../../domain/entities/itinerary_entities.dart';
import '../datasource/agent_data_source.dart';


abstract class ItineraryRepository {
  Stream<Itinerary> generateItinerary({
    required String prompt,
    Itinerary? previousItinerary,
    required List<String> chatHistory,
  });
}

class ItineraryRepositoryImpl implements ItineraryRepository {
  final LLMDataSource _dataSource;

  ItineraryRepositoryImpl(this._dataSource);

  @override
  Stream<Itinerary> generateItinerary({
    required String prompt,
    Itinerary? previousItinerary,
    required List<String> chatHistory,
  }) {
    return _dataSource.generateItinerary(
      prompt: prompt,
      previousItinerary: previousItinerary,
      chatHistory: chatHistory,
    );
  }
}
