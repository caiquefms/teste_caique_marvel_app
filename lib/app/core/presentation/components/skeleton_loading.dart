import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonLoading extends StatelessWidget {
  final double height;
  final double width;
  final double? radius;

  SkeletonLoading({
    required this.height,
    required this.width,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      shimmerColor: Colors.grey.shade50,
      gradientColor: Color(0X00D7DDE0),
      borderRadius: BorderRadius.circular(radius ?? 10),
      shimmerDuration: 1000,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Color(0XFFF1F4F5),
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
      ),
    );
  }
}
