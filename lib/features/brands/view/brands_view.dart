// ignore_for_file: deprecated_member_use

import 'package:atomshop/features/brands/controller/brands_controller.dart';
import 'package:atomshop/features/brands/model/brands_model.dart';
import 'package:atomshop/features/brands/view/brands_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BrandsView extends StatelessWidget {
  final BrandsController controller = Get.put(BrandsController());

  BrandsView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final brandLogoSize = screenWidth * 0.2; // 20% of screen width

    return Obx(() {
      if (controller.isLoading.value) {
        return _buildShimmerList(brandLogoSize);
      }
      if (controller.brands.isEmpty) {
        return const Center(child: Text("No brands available"));
      }
      return SizedBox(
        height: brandLogoSize + 20,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: controller.brands.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final brand = controller.brands[index];
            return BrandCard(brand: brand, size: brandLogoSize);
          },
        ),
      );
    });
  }

  Widget _buildShimmerList(double size) {
    return SizedBox(
      height: size + 20,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 6,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return ShimmerLoading(
            size: size,
            height: 100,
            borderRadius: 12,
          );
        },
      ),
    );
  }
}

class BrandCard extends StatelessWidget {
  final BrandsModel brand;
  final double size;

  const BrandCard({super.key, required this.brand, required this.size});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => BrandProductsView(id: brand.id.toString(),brandName: brand.title.toString(),));
      }, // Add navigation if needed
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: CachedNetworkImage(
          imageUrl: brand.picture ?? "",
          fit: BoxFit.contain,
          width: size,
          height: size,
          placeholder: (context, url) => ShimmerLoading(
            size: size,
            height: 100,
            borderRadius: 12,
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.image_not_supported,
            size: 50,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  final double size;

  const ShimmerLoading(
      {super.key,
      required this.size,
      required int height,
      required int borderRadius});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
