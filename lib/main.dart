import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_trip_planner/presentation/app.dart';

void main() {
  runApp(ProviderScope(child: const App()));
}
