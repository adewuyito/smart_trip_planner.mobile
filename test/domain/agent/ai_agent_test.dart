import 'package:flutter_test/flutter_test.dart';
import 'package:smart_trip_planner/domain/agent/main_agent.dart';
import 'package:smart_trip_planner/domain/entities/itinerary_entities.dart';

// Since GenerativeModel is a final class and cannot be mocked,
// we'll create integration-style tests that test the AIAgent class structure
// and basic functionality without actual API calls.
void main() {
  group('AIAgent', () {
    test('can be instantiated with API key', () {
      expect(() => AIAgent('test-api-key'), returnsNormally);
    });

    test('generateItinerary method exists and returns a stream', () {
      final agent = AIAgent('test-api-key');
      final stream = agent.generateItinerary(
        prompt: 'Test prompt',
        previousItinerary: null,
        chatHistory: [],
      );
      expect(stream, isA<Stream<Itinerary>>());
    });

    test('generateItinerary accepts all required parameters', () {
      final agent = AIAgent('test-api-key');
      
      // Test that method accepts parameters without throwing
      expect(() => agent.generateItinerary(
        prompt: 'Plan a trip to Tokyo',
        previousItinerary: null,
        chatHistory: ['Hello', 'How can I help you?'],
      ), returnsNormally);
    });
    
    test('generateItinerary accepts previous itinerary', () {
      final agent = AIAgent('test-api-key');
      final previousItinerary = Itinerary(
        title: 'Previous Trip',
        startDate: '2025-04-01',
        endDate: '2025-04-05',
        days: [],
      );
      
      // Test that method accepts previous itinerary without throwing
      expect(() => agent.generateItinerary(
        prompt: 'Update my trip',
        previousItinerary: previousItinerary,
        chatHistory: [],
      ), returnsNormally);
    });
  });

  group('Itinerary Entity', () {
    test('can create and serialize Itinerary objects', () {
      final itinerary = Itinerary(
        title: 'Test Trip',
        startDate: '2025-04-10',
        endDate: '2025-04-15',
        days: [
          Day(
            date: '2025-04-10',
            summary: 'Test Day',
            items: [
              Activity(
                time: '09:00',
                activity: 'Test Activity',
                location: '0,0',
              ),
            ],
          ),
        ],
      );
      
      expect(itinerary.title, equals('Test Trip'));
      expect(itinerary.days.length, equals(1));
      expect(itinerary.days.first.items.length, equals(1));
      
      // Test serialization
      final json = itinerary.toJson();
      expect(json['title'], equals('Test Trip'));
      expect(json['days'], isA<List>());
      
      // Test deserialization
      final reconstructed = Itinerary.fromJson(json);
      expect(reconstructed.title, equals(itinerary.title));
      expect(reconstructed.days.length, equals(itinerary.days.length));
    });
  });
}
