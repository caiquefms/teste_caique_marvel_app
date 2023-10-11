import 'package:flutter/material.dart';

class HorizontalDivisor extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? marginEnd;
  final double? marginStart;
  final double? marginTop;
  final double? marginBottom;

  HorizontalDivisor({
    this.color,
    this.height,
    this.marginEnd,
    this.marginStart,
    this.marginTop,
    this.marginBottom,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: marginStart ?? 0.0,
        right: marginEnd ?? 0.0,
        top: marginTop ?? 0.0,
        bottom: marginBottom ?? 0.0,
      ),
      child: Container(
        height: height ?? 1,
        color: color ?? Colors.grey.shade100,
      ),
    );
  }
}
