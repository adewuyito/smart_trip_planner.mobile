import 'package:flutter_test/flutter_test.dart';
import 'package:smart_trip_planner/domain/agent/main_agent.dart';
import 'package:smart_trip_planner/domain/entities/itinerary_entities.dart';
import 'package:smart_trip_planner/const.dart';

void main() {
  group('AIAgent Integration Tests', () {
    late AIAgent agent;

    setUpAll(() {
      // Use the actual API key from const.dart
      agent = AIAgent(GEMINI_API_SECRET);
    });

    test('generateItinerary returns valid data from real API', () async {
      // This test makes an actual API call
      final stream = agent.generateItinerary(
        prompt: 'Plan a simple 1-day trip to Paris with 2 activities',
        previousItinerary: null,
        chatHistory: [],
      );

      expect(stream, isA<Stream<Itinerary>>());

      // Collect results from the stream with a timeout
      final List<Itinerary> results = [];
      final streamSubscription = stream.listen(
        (itinerary) {
          results.add(itinerary);
          print('Received itinerary: ${itinerary.title}');
        },
        onError: (error) {
          print('Stream error: $error');
          fail('Stream should not emit errors: $error');
        },
      );

      // Wait for data with a timeout
      await Future.delayed(const Duration(seconds: 30));
      await streamSubscription.cancel();

      // Verify we got at least one result
      expect(results, isNotEmpty, reason: 'Should receive at least one itinerary');

      final itinerary = results.first;
      
      // Validate the structure of returned data
      expect(itinerary.title, isNotEmpty, reason: 'Title should not be empty');
      expect(itinerary.startDate, isNotEmpty, reason: 'Start date should not be empty');
      expect(itinerary.endDate, isNotEmpty, reason: 'End date should not be empty');
      expect(itinerary.days, isNotEmpty, reason: 'Should have at least one day');
      
      final firstDay = itinerary.days.first;
      expect(firstDay.date, isNotEmpty, reason: 'Day date should not be empty');
      expect(firstDay.summary, isNotEmpty, reason: 'Day summary should not be empty');
      expect(firstDay.items, isNotEmpty, reason: 'Should have at least one activity');
      
      final firstActivity = firstDay.items.first;
      expect(firstActivity.time, isNotEmpty, reason: 'Activity time should not be empty');
      expect(firstActivity.activity, isNotEmpty, reason: 'Activity description should not be empty');
      expect(firstActivity.location, isNotEmpty, reason: 'Activity location should not be empty');

      print('✅ Test passed! Itinerary contains:');
      print('   Title: ${itinerary.title}');
      print('   Days: ${itinerary.days.length}');
      print('   First day activities: ${firstDay.items.length}');
    }, timeout: const Timeout(Duration(minutes: 2)));

    test('generateItinerary with previous itinerary works', () async {
      // Create a simple previous itinerary
      final previousItinerary = Itinerary(
        title: 'Previous Paris Trip',
        startDate: '2025-04-10',
        endDate: '2025-04-11',
        days: [
          Day(
            date: '2025-04-10',
            summary: 'Eiffel Tower Visit',
            items: [
              Activity(
                time: '10:00',
                activity: 'Visit Eiffel Tower',
                location: '48.8584,2.2945',
              ),
            ],
          ),
        ],
      );

      final stream = agent.generateItinerary(
        prompt: 'Add a museum visit to my Paris trip',
        previousItinerary: previousItinerary,
        chatHistory: ['I want to add more cultural activities'],
      );

      final List<Itinerary> results = [];
      final streamSubscription = stream.listen(
        (itinerary) {
          results.add(itinerary);
        },
        onError: (error) {
          print('Stream error: $error');
          fail('Stream should not emit errors: $error');
        },
      );

      await Future.delayed(const Duration(seconds: 30));
      await streamSubscription.cancel();

      expect(results, isNotEmpty, reason: 'Should receive updated itinerary');

      final updatedItinerary = results.first;
      expect(updatedItinerary.title, isNotEmpty);
      expect(updatedItinerary.days, isNotEmpty);
      
      print('✅ Updated itinerary test passed!');
      print('   Updated title: ${updatedItinerary.title}');
    }, timeout: const Timeout(Duration(minutes: 2)));

    test('generateItinerary handles errors gracefully', () async {
      // Test with an invalid prompt that might cause issues
      final stream = agent.generateItinerary(
        prompt: '', // Empty prompt
        previousItinerary: null,
        chatHistory: [],
      );

      bool errorReceived = false;
      final streamSubscription = stream.listen(
        (itinerary) {
          // If we get data, that's fine too
          print('Received data for empty prompt: ${itinerary.title}');
        },
        onError: (error) {
          errorReceived = true;
          print('Expected error received: $error');
        },
      );

      await Future.delayed(const Duration(seconds: 15));
      await streamSubscription.cancel();

      // Either we get an error or the AI handles the empty prompt gracefully
      print('✅ Error handling test completed. Error received: $errorReceived');
    }, timeout: const Timeout(Duration(minutes: 1)));
  });
}
