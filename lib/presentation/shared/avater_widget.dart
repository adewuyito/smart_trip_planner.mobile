import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SAvaterWidget extends StatelessWidget {
  const SAvaterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
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
    );
  }
}
