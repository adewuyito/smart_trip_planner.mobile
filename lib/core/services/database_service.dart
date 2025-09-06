// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:isar/isar.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:smart_trip_planner/data/model/trip.dart';

// class DatabaseService {
//   static Isar? _isar;

//   static Future<Isar> get db async {
//     if (_isar != null) return _isar!;
//     final dir = await getApplicationDocumentsDirectory();
//     _isar = await Isar.open(
//       [ItinerarySchema],
//       directory: dir.path,
//       inspector: true,
//     );
//     return _isar!;
//   }

//   /// Save or update an itinerary
//   static Future<void> saveItinerary(Itinerary itinerary) async {
//     final isar = await db;
//     await isar.writeTxn(() async {
//       await isar.itinerarys.put(itinerary);
//     });
//   }

//   /// Get all itineraries
//   static Future<List<Itinerary>> getItineraries() async {
//     final isar = await db;
//     return await isar.itinerarys.where().findAll();
//   }

//   /// Get a single itinerary by ID
//   static Future<Itinerary?> getItinerary(int id) async {
//     final isar = await db;
//     return await isar.itinerarys.get(id);
//   }

//   /// Delete itinerary by ID
//   static Future<void> deleteItinerary(int id) async {
//     final isar = await db;
//     await isar.writeTxn(() async {
//       await isar.itinerarys.delete(id);
//     });
//   }

//   /// Clear all itineraries
//   static Future<void> clearAll() async {
//     final isar = await db;
//     await isar.writeTxn(() async {
//       await isar.itinerarys.clear();
//     });
//   }
// }


// final localDatabseProvider = Provider<DatabaseService>((ref) {
//   return DatabaseService();
// });