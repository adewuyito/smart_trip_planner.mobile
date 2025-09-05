import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_trip_planner/core/constants/colors.dart';
import 'package:smart_trip_planner/presentation/shared/gradient_border_container.dart';

// ---------- User Message ----------
class UserMessage extends StatelessWidget {
  final String text;

  const UserMessage({super.key, required this.text});

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Copied to clipboard")));
  }

  @override
  Widget build(BuildContext context) {
    return GradientBorderContainer(
      padding: EdgeInsets.fromLTRB(18, 22, 18, 19),
      child: Column(
        spacing: 14,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: appColors.appGreen,
                child: Text("T", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(width: 6),
              Text("You", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),

          Text(text, style: GoogleFonts.inter(fontWeight: FontWeight.w500)),

          // Copy button aligned right
          GestureDetector(
            onTap: () => _copyToClipboard(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [const Icon(Icons.copy, size: 16), Text("Copy")],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- Responder Message ----------
class AIMessage extends StatelessWidget {
  final String text;

  const AIMessage({super.key, required this.text});

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Copied to clipboard")));
  }

  @override
  Widget build(BuildContext context) { // TODO: Add different state - Loading, Data, Error
    return GradientBorderContainer(
      padding: EdgeInsets.fromLTRB(18, 22, 18, 19),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: appColors.appYellow,
                child: Icon(Icons.message, color: Colors.white, size: 14),
              ),
              SizedBox(width: 6),
              Text("Itinera AI", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 14),

          Text(text, style: GoogleFonts.inter(fontWeight: FontWeight.w500)),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFF6F3F0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "📍 Open in maps ",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Icon(Icons.exit_to_app),
                  ],
                ),
                Text(
                  "Mumbai to Bali, Indonesia | 11hrs 5mins",
                  style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Divider(color: appColors.appDivider),

          const SizedBox(height: 14),
          // Copy button aligned right
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _copyToClipboard(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [const Icon(Icons.copy, size: 16), Text("Copy")],
                ),
              ),
              GestureDetector(
                onTap: () => _copyToClipboard(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [const Icon(Icons.copy, size: 16), Text("Copy")],
                ),
              ),
              GestureDetector(
                onTap: () => _copyToClipboard(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [const Icon(Icons.copy, size: 16), Text("Copy")],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// TODO: Fix the actions on chat