import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A6B7F9C), // #6B7F9C1A
            offset: Offset(0, 12),
            blurRadius: 27,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x17D8BACF), // #D8BACF17
            offset: Offset(0, 49),
            blurRadius: 49,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x0DA2C0AA), // #A2C0AA0D
            offset: Offset(0, 109),
            blurRadius: 66,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x037E8696), // #7E869603
            offset: Offset(0, 194),
            blurRadius: 78,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(
              0x00A4639D,
            ), // #A4639D00 (fully transparent, no effect)
            offset: Offset(0, 304),
            blurRadius: 85,
            spreadRadius: 0,
          ),
        ],
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
