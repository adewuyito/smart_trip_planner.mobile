import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SAvaterWidget extends StatelessWidget {
  // TODO: Get the name from some where
  final double? radius;
  const SAvaterWidget({super.key, this.radius = 20});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
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
    );
  }
}
