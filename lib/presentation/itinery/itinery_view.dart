import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_trip_planner/core/constants/shadows.dart';
import 'package:smart_trip_planner/presentation/shared/avater_widget.dart';
import 'package:smart_trip_planner/presentation/shared/button_widget.dart';

class ItineryView extends ConsumerWidget {
  const ItineryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_sharp),
        ),
        centerTitle: false,
        title: Text(
          "Home",
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [SAvaterWidget()],
        actionsPadding: EdgeInsets.only(right: 24),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 27),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30),
              Text(
                "Creating Itinerary...",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ), // TODO: FIND A WHY TO WORK THIS WITH LOADING
              const SizedBox(height: 24),

              Container(
                width: 339, // TODO: Change to use expanded
                height: 481,
                decoration: BoxDecoration(
                  boxShadow: boxShadow1,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: 0.3,
                      color: Color(0xFF065F46),
                      backgroundColor: Color(0x5C816E91),
                    ),
                    Text(
                      "Curating a perfect plan for you...",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              GreenButton(),

              const SizedBox(height: 10),
              
              OfflineButton(),
            ],
          ),
        ),
      ),
    );
  }
}
