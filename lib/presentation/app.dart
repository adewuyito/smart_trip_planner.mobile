import 'package:flutter/material.dart';
import 'package:smart_trip_planner/presentation/home_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView()
    );
  }
}
