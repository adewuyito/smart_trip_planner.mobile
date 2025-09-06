import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;
import 'package:smart_trip_planner/domain/entities/itinerary_entities.dart';
import 'package:smart_trip_planner/config/env_config.dart';

class AIAgent {
  final GenerativeModel _model;

  AIAgent(String apiKey)
    : _model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
        ),
      );

  Stream<Itinerary> generateItinerary({
    required String prompt,
    Itinerary? previousItinerary,
    required List<String> chatHistory,
  }) async* {
    final specASchema = {
      'title': 'Kyoto 5-Day Solo Trip',
      'startDate': '2025-04-10',
      'endDate': '2025-04-15',
      'days': [
        {
          'date': '2025-04-10',
          'summary': 'Fushimi Inari & Gion',
          'items': [
            {
              'time': '09:00',
              'activity': 'Climb Fushimi Inari Shrine',
              'location': '34.9671,135.7727',
            },
            {
              'time': '14:00',
              'activity': 'Lunch at Nishiki Market',
              'location': '35.0047,135.7630',
            },
            {
              'time': '18:30',
              'activity': 'Evening walk in Gion',
              'location': '35.0037,135.7788',
            },
          ],
        },
      ],
    };

    /*     final systemPrompt = '''
You are a travel planner. Generate a structured itinerary in JSON matching this schema:
${jsonEncode(specASchema)}.
Use the search_web function for real-time info (e.g., restaurants, attractions).
For follow-up requests, refine the previous itinerary based on user input.
Respond only with valid JSON matching the schema.
'''; */

    final systemPrompt = '''
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

    final tools = [
      Tool(
        functionDeclarations: [
          FunctionDeclaration(
            'search_web',
            'Search the web for real-time info like restaurants or attractions.',
            Schema.object(
              properties: {
                'query': Schema.string(
                  description: 'Search query (e.g., "restaurants in Kyoto")',
                ),
              },
              requiredProperties: ['query'],
            ),
          ),
        ],
      ),
    ];

    final content = [
      Content.text(
        '$systemPrompt\n\n'
        '${previousItinerary != null ? 'Previous itinerary: ${jsonEncode(previousItinerary.toJson())}\n\n' : ''}'
        '${chatHistory.isNotEmpty ? 'Chat history: ${chatHistory.join('\n')}\n\n' : ''}'
        'User request: $prompt'
      ),
    ];

    try {
      final responseStream = _model.generateContentStream(
        content,
        tools: tools,
      );

      String buffer = '';
      await for (final response in responseStream) {
        if (response.functionCalls.isNotEmpty) {
          final call = response.functionCalls.first;
          if (call.name == 'search_web') {
            final query = call.args['query'] as String;
            final searchResults = await _performSearch(query);
            final followUpContent = [
              ...content,
              Content.functionResponse('search_web', {
                'results': searchResults,
              }),
            ];
            final followUpStream = _model.generateContentStream(
              followUpContent,
            );
            await for (final followUp in followUpStream) {
              final jsonText = followUp.candidates
                  .expand((c) => c.content.parts)
                  .whereType<TextPart>()
                  .map((p) => p.text)
                  .join('');
              if (jsonText.isNotEmpty) {
                buffer += jsonText;
                try {
                  final json = jsonDecode(buffer);
                  _validateJson(json, specASchema);
                  yield Itinerary.fromJson(json);
                  buffer = '';
                } catch (e) {
                  // Continue buffering
                }
              }
            }
          }
        } else {
          final jsonText = response.candidates
              .expand((c) => c.content.parts)
              .whereType<TextPart>()
              .map((p) => p.text)
              .join('');
          if (jsonText.isNotEmpty) {
            buffer += jsonText;
            try {
              final json = jsonDecode(buffer);
              _validateJson(json, specASchema);
              yield Itinerary.fromJson(json);
              buffer = '';
            } catch (e) {
              // Continue buffering
            }
          }
        }
      }
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<String>> _performSearch(String query) async {
    final serpApiKey = EnvConfig.serpApiKey;
    if (serpApiKey.isEmpty) {
      return ['Error: SERP_API_KEY not configured'];
    }
    try {
      final uri = Uri.parse(
        'https://serpapi.com/search?engine=google&q=$query&api_key=$serpApiKey',
      );
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Extract relevant snippets (e.g., top organic results)
        final results = data['organic_results'] as List<dynamic>? ?? [];
        return results
            .map(
              (result) =>
                  '${result['title'] ?? ''}: ${result['snippet'] ?? ''}',
            )
            .toList();
      } else {
        return ['Error fetching search results: ${response.statusCode}'];
      }
    } catch (e) {
      return ['Search failed: $e'];
    }
  }

  // Future<List<String>> _performSearch(String query) async {
  //   try {
  //     const serpAPIKEY =
  //         "e3e511d3747d04a6bf2044871a362e60f30536c37e0aa947f3b4974b59f4a85e"; // TODO: remove from here
  //     final response = await http.get(
  //       Uri.parse(
  //         'https://serpapi.com/search?api_key=$serpAPIKEY&q=$query',
  //       ),
  //     );
  //     // final response = await http.get(
  //     //   Uri.parse('https://api.duckduckgo.com/?q=$query&format=json'),
  //     // );
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       return [data['AbstractText'] ?? 'No results found'];
  //     }
  //     return ['Error fetching search results'];
  //   } catch (e) {
  //     return ['Search failed: $e'];
  //   }
  // }

  void _validateJson(Map<String, dynamic> json, Map<String, dynamic> schema) {
    // Basic validation; enhance with json_schema
    if (json['title'] == null || json['days'] == null) {
      throw FormatException('Invalid itinerary JSON');
    }
  }

  Exception _handleError(dynamic e) {
    if (e is GenerativeAIException) {
      if (e.message.contains('401')) return Exception('Invalid API key');
      if (e.message.contains('429')) return Exception('Rate limit exceeded');
    }
    return Exception('Unexpected error: $e');
  }
}

Future<Stream<Itinerary>> generateItineraryInIsolate({
  required String prompt,
  Itinerary? previousItinerary,
  required List<String> chatHistory,
  required String apiKey,
}) async {
  return await compute(_generateItineraryIsolate, {
    'prompt': prompt,
    'previousItinerary': previousItinerary?.toJson(),
    'chatHistory': chatHistory,
    'apiKey': apiKey,
  });
}

Stream<Itinerary> _generateItineraryIsolate(Map<String, dynamic> params) {
  final agent = AIAgent(params['apiKey']);
  return agent.generateItinerary(
    prompt: params['prompt'],
    previousItinerary:
        params['previousItinerary'] != null
            ? Itinerary.fromJson(params['previousItinerary'])
            : null,
    chatHistory: params['chatHistory'].cast<String>(),
  );
}
