
// import 'dart:convert';

// import 'package:smart_trip_planner/domain/agent/main_agent.dart';

// void main() async {

//   final _agent = AIAgent('***REMOVED***');

//   final stream =  _agent.generateItinerary(
//     prompt: '5 days in Kyoto, solo, mid-range budget',
//     previousItinerary: null,
//     chatHistory: [],
//   );
//   await for (final itinerary in stream) {
//     print(jsonEncode(itinerary.toJson()));
//   }
// }