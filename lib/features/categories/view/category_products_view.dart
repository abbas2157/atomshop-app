import 'package:atomshop/features/categories/categories_controller/categories_controller.dart';
import 'package:atomshop/features/categories/model/category_product_model.dart';
import 'package:atomshop/features/featured_products/view/single_product_detail_view.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CategoryProductsView extends StatelessWidget {
  final CategoriesController controller = Get.put(CategoriesController());
  final String id;
  final String name;

  CategoryProductsView({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Fetch data only once when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchCategoryProducts(id);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(name, style: AppTextStyles.headline2),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.transparent,
        forceMaterialTransparency: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Obx(() {
            if (controller.isLoadingCategoryProducts.value) {
              return buildShimmerGrid(screenHeight);
            }
            if (controller.categoryProducts.isEmpty) {
              return const Center(
                child: Text(
                  "No brand products available",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                controller.fetchCategoryProducts(id);
              },
              child: GridView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                itemCount: controller.categoryProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenWidth > 600 ? 3 : 2, // Responsive grid
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75, // Adjust card height
                ),
                itemBuilder: (context, index) {
                  final product = controller.categoryProducts[index];
                  return CategoryProductCard(product: product);
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}

/// Shimmer Loading for Skeleton UI
Widget buildShimmerGrid(double screenHeight) {
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

class CategoryProductCard extends StatelessWidget {
  final CategoryProductModel product;

  const CategoryProductCard({super.key, required this.product});

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
              child: CircleAvatar(
                radius: cardWidth * 0.1, // 10% of card width
                backgroundColor: Colors.grey.shade200,
                child: const Icon(Icons.favorite_border, color: Colors.white),
              ),
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
