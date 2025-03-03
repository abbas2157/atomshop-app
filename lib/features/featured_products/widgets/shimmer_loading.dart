import 'package:atomshop/common/widgets/loading.dart';
import 'package:flutter/material.dart';
class ProductDetailShimmer extends StatelessWidget {
  const ProductDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShimmerLoading(height: 250), // Image placeholder
        SizedBox(height: 20),
        ShimmerLoading(height: 20, width: 200), // Title placeholder
        SizedBox(height: 10),
        ShimmerLoading(height: 20, width: 100), // Price placeholder
        SizedBox(height: 10),
        ShimmerLoading(height: 40, width: 150), // Variant selector placeholder
      ],
    );
  }
}
