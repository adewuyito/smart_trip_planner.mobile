import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bubbleDecoration = BoxDecoration(
      color: Color(0xFFF6F3F0),
      borderRadius: BorderRadius.circular(6),
    );

    Widget profileInfoBubble({
      required String label,
      required (int, int) data,
      Color color = Colors.red,
    }) {
      return Container(
        padding: EdgeInsets.all(18),
        decoration: bubbleDecoration,
        child: Column(
          spacing: 12,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Text(
                  "${data.$1}/${data.$2}",
                  style: GoogleFonts.inter(
                    textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            LinearProgressIndicator(
              value: data.$1 / data.$2,
              color: color,
              minHeight: 8,
              borderRadius: BorderRadius.circular(21),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        centerTitle: false,
        title: Text(
          "Profile",
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 27),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 19, vertical: 28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [],
              ),
              child: Column(
                children: [
                  // Profile Details
                  Row(
                    spacing: 16,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFF065F46),
                        child: Center(
                          child: Text(
                            "T",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Shubham S.",
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            "shubham.s@gmail.com",
                            style: GoogleFonts.inter(),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Divider
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 19),
                    child: Divider(),
                  ),

                  //Profile Usegage
                  profileInfoBubble(label: "Request Token", data: (728, 1000)),
                  const SizedBox(height: 14),
                  profileInfoBubble(label: "Response Token", data: (75, 1000)),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: bubbleDecoration,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ~ Label
                        Text(
                          "Total Cost",
                          style: GoogleFonts.inter(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),

                        // ~ Date
                        Text(
                          "\$ 1000 USD",
                          style: GoogleFonts.inter(
                            textStyle: Theme.of(
                              context,
                            ).textTheme.labelLarge!.copyWith(
                              color: Colors.green.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 43),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                backgroundColor: Colors.white,
                shape: StadiumBorder(),
              ),
              onPressed: () {},
              child: Row(
                spacing: 13,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.door_back_door, color: Colors.red),
                  Text("Log Out", style: GoogleFonts.inter(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
