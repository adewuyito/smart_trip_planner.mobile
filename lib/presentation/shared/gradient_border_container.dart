import 'package:flutter/material.dart';
import 'package:smart_trip_planner/core/constants/colors.dart';
import 'package:smart_trip_planner/core/constants/shadows.dart';

class GradientBorderContainer extends StatelessWidget {
  const GradientBorderContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  });
  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: appColors.gradient1,
          stops: [0.0, 0.5, 1.0],
        ),
        boxShadow: boxShadow1,
      ),
      child: Container(
        margin: const EdgeInsets.all(1),
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: child,
      ),
    );
  }
}
