import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_trip_planner/core/constants/shadows.dart';

class GradientBorderContainer extends StatelessWidget {
  const GradientBorderContainer({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    Color color1 = Color(0xEF883A33).withValues(alpha: .2);
    Color color2 = Color(0x59AB9633).withValues(alpha: .2);
    Color color3 = Color(0x83A9F333).withValues(alpha: .2);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color1, color2, color3],
          stops: [0.0, 0.5, 1.0],
        ),
        boxShadow: boxShadow1,
      ),
      child: Container(
        margin: const EdgeInsets.all(1),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Color(0xFF35AF8D),
                border: Border.all(color: Color(0xFF6CE7C5)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
