import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:smart_trip_planner/data/datasource/agent_data_source.dart';
import 'package:smart_trip_planner/domain/agent/main_agent.dart';
import 'package:smart_trip_planner/domain/entities/itinerary_entities.dart';


import 'llm_data_source_test.mocks.dart';

// Create a testable version of LLMDataSource that doesn't use isolates
class TestLLMDataSourceImpl implements LLMDataSource {
  final AIAgent _agent;
  
  TestLLMDataSourceImpl(this._agent);
  
  @override
  Stream<Itinerary> generateItinerary({
    required String prompt,
    Itinerary? previousItinerary,
    required List<String> chatHistory,
  }) {
    return _agent.generateItinerary(
      prompt: prompt,
      previousItinerary: previousItinerary,
      chatHistory: chatHistory,
    );
  }
}

@GenerateMocks([AIAgent])
void main() {
  late TestLLMDataSourceImpl dataSource;
  late MockAIAgent mockAgent;

  setUp(() {
    mockAgent = MockAIAgent();
    dataSource = TestLLMDataSourceImpl(mockAgent);
  });

  test('LLMDataSourceImpl generates itinerary stream', () async {
    final itinerary = Itinerary(
      title: 'Test Trip',
      startDate: '2025-04-10',
      endDate: '2025-04-15',
      days: [
        Day(
          date: '2025-04-10',
          summary: 'Test Day',
          items: [
            Activity(time: '09:00', activity: 'Test Activity', location: '0,0'),
          ],
        ),
      ],
    );

    when(mockAgent.generateItinerary(
      prompt: anyNamed('prompt'),
      previousItinerary: anyNamed('previousItinerary'),
      chatHistory: anyNamed('chatHistory'),
    )).thenAnswer((_) => Stream.fromIterable([itinerary]));

    final stream = dataSource.generateItinerary(
      prompt: 'Test prompt',
      previousItinerary: null,
      chatHistory: [],
    );

    final itineraries = await stream.toList();
    expect(itineraries.first.title, 'Test Trip');
  });
}
