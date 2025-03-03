import 'package:atomshop/features/promotions/controller/promotions_controller.dart';
import 'package:atomshop/features/promotions/model/promotions_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PromotionsView extends StatelessWidget {
  final PromotionsController controller = Get.put(PromotionsController());

  PromotionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bannerHeight = screenWidth * 0.4; // 40% of screen width
    final bannerWidth = screenWidth * 0.75; // 75% of screen width

    return Obx(() {
      if (controller.isLoading.value) {
        return _buildShimmerList(bannerWidth, bannerHeight);
      }
      if (controller.promotions.isEmpty) {
        return const Center(child: Text("No promotions available"));
      }
      return SizedBox(
        height: bannerHeight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: controller.promotions.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final promotion = controller.promotions[index];
            return PromotionsCard(
              promotion: promotion,
              width: bannerWidth,
              height: bannerHeight,
            );
          },
        ),
      );
    });
  }

  Widget _buildShimmerList(double width, double height) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return ShimmerLoading(width: width, height: height);
        },
      ),
    );
  }
}

class PromotionsCard extends StatelessWidget {
  final PromotionsModel promotion;
  final double width;
  final double height;

  const PromotionsCard({
    super.key,
    required this.promotion,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {}, // Add navigation if needed
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: CachedNetworkImage(
          imageUrl: promotion.picture ?? "",
          fit: BoxFit.cover,
          width: width,
          height: height,
          placeholder: (context, url) =>
              ShimmerLoading(width: width, height: height),
          errorWidget: (context, url, error) => const Icon(
            Icons.image_not_supported,
            size: 100,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  final double height;
  final double width;

  const ShimmerLoading({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
