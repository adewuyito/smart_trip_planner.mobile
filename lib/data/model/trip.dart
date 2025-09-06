// // ignore_for_file: public_member_api_docs, sort_constructors_first
// // lib/data/models/trip.dart
// import 'dart:convert';

// import 'package:isar/isar.dart';

// part 'trip.g.dart';

// @collection
// class Itinerary {
//   Id id = Isar.autoIncrement;
//   String? title;
//   String? startDate; // ISO yyyy-MM-dd
//   String? endDate;
//   List<TripDay>? days;

//   Itinerary();

//   factory Itinerary.fromJson(Map<String, dynamic> map) {
//     return Itinerary()
//       ..id = map['id'] ?? Isar.autoIncrement
//       ..title = map['title']
//       ..startDate = map['startDate']
//       ..endDate = map['endDate']
//       ..days =
//           (map['days'] as List<dynamic>?)
//               ?.map((day) => TripDay.fromJson(day as Map<String, dynamic>))
//               .toList();
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'startDate': startDate,
//       'endDate': endDate,
//       'days': days?.map((day) => day.toJson()).toList(),
//     };
//   }
// }

// @embedded
// class TripDay {
//   String? date; // ISO
//   String? summary;
//   List<TripItem>? items;

//   TripDay();

//   factory TripDay.fromJson(Map<String, dynamic> map) {
//     return TripDay()
//       ..date = map['date']
//       ..summary = map['summary']
//       ..items =
//           (map['items'] as List<dynamic>?)
//               ?.map((item) => TripItem.fromJson(item as Map<String, dynamic>))
//               .toList();
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'date': date,
//       'summary': summary,
//       'items': items?.map((item) => item.toJson()).toList(),
//     };
//   }
// }

// @embedded
// class TripItem {
//   String? time; // "HH:mm"
//   String? activity;
//   String? location; // "lat,lon"
//   // diff flags (for S-2):
//   // bool added = false;
//   // bool removed = false;
//   // bool changed = false;

//   TripItem({this.time, this.activity, this.location});

//   factory TripItem.fromJson(Map<String, dynamic> map) {
//     return TripItem(
//       time: map['time'],
//       activity: map['activity'],
//       location: map['location'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {'time': time, 'activity': activity, 'location': location};
//   }
// }
