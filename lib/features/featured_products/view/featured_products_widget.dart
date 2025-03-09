import 'package:atomshop/common/widgets/loading.dart';
import 'package:atomshop/features/featured_products/controller/featured_products_controller.dart';
import 'package:atomshop/features/featured_products/model/featured_products_model.dart';
import 'package:atomshop/features/featured_products/view/single_product_detail_view.dart';
import 'package:atomshop/features/wish_list/controller/wishlist_controller.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class FeaturedProductsWidget extends StatelessWidget {
  final FeaturedProductsController controller =
      Get.put(FeaturedProductsController());

  FeaturedProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Obx(() {
      if (controller.isLoading.value) {
        return _buildShimmerGrid(screenHeight);
      }
      if (controller.featuredProducts.isEmpty) {
        return const Center(child: Text("No featured products available"));
      }
      return SizedBox(
        height: screenHeight * 0.3, // Adjust height based on screen
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.featuredProducts.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final product = controller.featuredProducts[index];
            return ProductCard(product: product);
          },
        ),
      );
    });
  }

  /// Shimmer Loading for Skeleton UI
  Widget _buildShimmerGrid(double screenHeight) {
    return SizedBox(
      height: screenHeight * 0.3, // Dynamic height
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 160,
              height: screenHeight * 0.30, // Adjust card height dynamically
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final FeaturedProductsModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.4; // 40% of screen width
    double imageSize = cardWidth * 0.6; // 60% of card width

    return InkWell(
      onTap: () {
        Get.to(() => SingleProductDetailView(
              productId: product.id ?? 0,
            ));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Wishlist Icon
            Align(
              alignment: Alignment.topRight,
              child: Obx(() {
                final WishlistController controller =
                    Get.put(WishlistController());

                bool isFavorited =
                    controller.favoriteProducts[product.id.toString()] ?? false;

                return InkWell(
                  onTap: () {
                    // final controller = Get.put(WishlistController());
                    controller.addToWishList(productId: product.id.toString());
                  },
                  child: CircleAvatar(
                    radius: cardWidth * 0.1, // 10% of card width
                    backgroundColor: Colors.grey.shade200,

                    child: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: isFavorited ? Colors.red : Colors.white),
                  ),
                );
              }),
            ),

            /// Product Image
            Expanded(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: product.picture ?? "",
                    fit: BoxFit.contain,
                    width: imageSize,
                    height: imageSize,
                    placeholder: (context, url) =>
                        ShimmerLoading(height: 180, borderRadius: 12),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.image_not_supported,
                      size: 100,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            /// Product Title
            Text(
              product.title ?? "Product Name",
              style: AppTextStyles.headline3.copyWith(
                fontSize: cardWidth * 0.08, // Adjust font size
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            /// Category & Brand
            if ((product.category?.isNotEmpty ?? false) ||
                (product.brand?.isNotEmpty ?? false)) ...[
              Row(
                children: [
                  // if (product.category?.isNotEmpty ?? false)
                  //   Container(
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal: cardWidth * 0.04, vertical: 2),
                  //     decoration: BoxDecoration(
                  //       // ignore: deprecated_member_use
                  //       color: AppColors.primaryLight.withOpacity(0.2),
                  //       borderRadius: BorderRadius.circular(6),
                  //     ),
                  //     child: Text(
                  //       product.category!,
                  //       style: AppTextStyles.bodyText1.copyWith(fontSize: 10),
                  //     ),
                  //   ),
                  // const SizedBox(width: 6),
                  if (product.brand?.isNotEmpty ?? false)
                    Text(
                      product.brand!,
                      style: AppTextStyles.bodyText1
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
              const SizedBox(height: 6),
            ],

            /// Installment Text
            Text(
              "Available On Installment",
              style: AppTextStyles.bodyText1.copyWith(fontSize: 12),
              // maxLines: 1,
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: 6),

            /// Price
            Text(
              "Advance: RS.${product.price}",
              style: AppTextStyles.normal.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: cardWidth * 0.09,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
