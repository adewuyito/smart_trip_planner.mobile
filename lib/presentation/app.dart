import 'package:flutter/material.dart';
import 'package:smart_trip_planner/presentation/chat/chat_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: mainBackground,
          surfaceTintColor: mainBackground, // important for Material 3
          elevation: 0,
        ),
        scaffoldBackgroundColor: mainBackground,
      ),
      home: ChatView(),
      // home: ChatScreen(),
    );
  }
}

const mainBackground = Color(0xFFF5F5F7);
