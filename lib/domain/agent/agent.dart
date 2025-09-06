// import 'dart:convert';
// import 'package:flutter_gemini/flutter_gemini.dart';
// import 'package:smart_trip_planner/domain/entities/itinerary_entities.dart';

// class AIAgent2 {
//   final Gemini _gemini;

//   AIAgent2() : _gemini = Gemini.instance; // API key set in main.dart

//   Stream<Itinerary> generateItinerary({
//     required String prompt,
//     Itinerary? previousItinerary,
//     required List<String> chatHistory,
//   }) async* {
//     final specASchema = {
//       'title': 'Kyoto 5-Day Solo Trip',
//       'startDate': '2025-04-10',
//       'endDate': '2025-04-15',
//       'days': [
//         {
//           'date': '2025-04-10',
//           'summary': 'Fushimi Inari & Gion',
//           'items': [
//             {
//               'time': '09:00',
//               'activity': 'Climb Fushimi Inari Shrine',
//               'location': '34.9671,135.7727',
//             },
//             {
//               'time': '14:00',
//               'activity': 'Lunch at Nishiki Market',
//               'location': '35.0047,135.7630',
//             },
//             {
//               'time': '18:30',
//               'activity': 'Evening walk in Gion',
//               'location': '35.0037,135.7788',
//             },
//           ],
//         },
//       ],
//     };

//     final systemPrompt = '''
// You are a travel planner. Generate a structured itinerary in JSON matching this schema:
// ${jsonEncode(specASchema)}.

// Instructions:
// - Create detailed, realistic itineraries with specific times, activities, and locations
// - Use coordinates in "lat,lon" format for locations
// - Include diverse activities (sightseeing, dining, cultural experiences)
// - Consider travel time between locations
// - For follow-up requests, refine the previous itinerary based on user input
// - Respond only with valid JSON matching the schema
// - Do not include any text outside the JSON response
// ''';

//     final messages = [
//       {'role': 'system', 'content': systemPrompt},
//       if (previousItinerary != null)
//         {
//           'role': 'user',
//           'content':
//               'Previous itinerary: ${jsonEncode(previousItinerary.toJson())}',
//         },
//       ...chatHistory.map((msg) => {'role': 'user', 'content': msg}),
//       {'role': 'user', 'content': prompt},
//     ];

//     // Note: Function calling is not directly supported in the current API structure
//     // Web search functionality can be integrated through prompt engineering

//     try {
//       // Convert messages to the new format
//       final parts = <Part>[];
//       for (final message in messages) {
//         if (message['role'] == 'system') {
//           // System messages are handled differently in the new API
//           continue;
//         }
//         parts.add(Part.text(message['content'] as String));
//       }

//       // Add system prompt as first part
//       parts.insert(0, Part.text(systemPrompt));

//       final responseStream = _gemini.promptStream(
//         parts: parts,
//         model: 'gemini-1.5-flash',
//         generationConfig: GenerationConfig(
//           temperature: 0.7,
//           maxOutputTokens: 2048,
//         ),
//       );

//       String buffer = '';
//       await for (final response in responseStream) {
//         final responseText = response.text;
//         if (responseText != null) {
//           buffer += responseText;
//         }
//         try {
//           final json = jsonDecode(buffer);
//           _validateJson(json, specASchema);
//           yield Itinerary.fromJson(json);
//           buffer = ''; // Reset after valid JSON
//         } catch (e) {
//           // Partial JSON, continue buffering
//         }
//       }
//     } catch (e) {
//       throw _handleError(e);
//     }
//   }

//   void _validateJson(Map<String, dynamic> json, Map<String, dynamic> schema) {
//     // Basic validation; use json_schema package for robustness
//     if (json['title'] == null || json['days'] == null) {
//       throw FormatException('Invalid itinerary JSON');
//     }
//   }

//   Exception _handleError(dynamic e) {
//     if (e is GeminiException) {
//       if (e.statusCode == 401) return Exception('Invalid API key');
//       if (e.statusCode == 429) return Exception('Rate limit exceeded');
//       if (e.statusCode == 400) return Exception('Bad request: ${e.message}');
//       if (e.statusCode == 404) return Exception('Model not found');
//     }
//     return Exception('Unexpected error: $e');
//   }
// }
