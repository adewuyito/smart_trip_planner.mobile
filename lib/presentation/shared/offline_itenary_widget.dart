import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_trip_planner/presentation/shared/gradient_border_container.dart';


class OfflineItenaryWidget extends StatelessWidget {
  final String label;

  const OfflineItenaryWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return GradientBorderContainer(
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
    );
  }
}
