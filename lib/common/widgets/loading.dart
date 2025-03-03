import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class ShimmerLoading extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;

  const ShimmerLoading({
    super.key,
    required this.height,
    this.width = double.infinity,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
