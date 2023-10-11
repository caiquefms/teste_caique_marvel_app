import 'package:flutter/material.dart';
import 'skeleton_loading.dart';

class CustomNetworkImage extends StatelessWidget {
  final String path;
  final double width;
  final double height;

  CustomNetworkImage(
      {required this.path, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      path,
      width: width,
      height: height,
      filterQuality: FilterQuality.high,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Image.network(
          "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/standard_fantastic.jpg",
          width: width,
          height: height,
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SkeletonLoading(
          width: width,
          height: height,
        );
      },
    );
  }
}
