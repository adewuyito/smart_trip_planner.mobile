import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GreenButton extends StatelessWidget { // TODO: IMPROVE on the dependency
  const GreenButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Color(0xFFD8DAE5)),
          ),
          backgroundColor: Color(0xFF065F46),
        ),
        onPressed: () {},
        child: Text(
          "Sign Up",
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
