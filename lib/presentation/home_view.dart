import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_trip_planner/presentation/shared/avater_widget.dart';
import 'package:smart_trip_planner/presentation/shared/green_button.dart';
import 'package:smart_trip_planner/presentation/shared/offline_itenary_widget.dart';
import 'package:smart_trip_planner/presentation/shared/prompt_input_widget.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();

    bool offlineItenary = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hey Shubham 👋",
          style: GoogleFonts.inter(
            color: Colors.green,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [SAvaterWidget()],
        actionsPadding: EdgeInsets.only(right: 24),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 34), // TODO: Add lenear grad to the border
              Text(
                "What's your vision\nfor this trip?",
                style: GoogleFonts.inter(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.1,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),
              NoteInputField(controller: textController),
              const SizedBox(height: 30),
              GreenButton(),
              const SizedBox(height: 37),

              offlineItenary == true
                  ? Column(
                    children: [
                      Text(
                        "Offline Saved Itineraries",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          // TODO: REMOVE THIS PLACEHOLDER
                          final text =
                              "Bali next April, 3 people, mid-range budget, wanted to explore less populated areas, it should be a peaceful trip!";
                          return GradientBorderContainer(label: text);
                        },
                      ),
                    ],
                  )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
