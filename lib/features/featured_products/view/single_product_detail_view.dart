import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:atomshop/common/widgets/loading.dart';
import 'package:atomshop/features/cart/controller/cart_controller.dart';
import 'package:atomshop/features/profile/utils/utils.dart';
import 'package:atomshop/style/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/single_product_detail_controller.dart';
import '../widgets/quantity_selector_button/quantity_selector_button.dart';


class SingleProductDetailView extends StatelessWidget {
  final int productId;

  const SingleProductDetailView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final ProductDetailController controller =
        Get.put(ProductDetailController());
     controller.fetchProductDetails(productId);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Obx(() {
        if (controller.isLoading.value) {
          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ShimmerLoading(height: 400, borderRadius: 16),
                const SizedBox(height: 24),
                ShimmerLoading(height: 24, width: 200),
                const SizedBox(height: 16),
                ShimmerLoading(height: 24, width: 120),
                const SizedBox(height: 24),
                ShimmerLoading(height: 48, borderRadius: 24),
                const SizedBox(height: 24),
                ShimmerLoading(height: 120, borderRadius: 16),
              ],
            ),
          );
        }

        if (controller.productDetail.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  "Failed to load product details",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        final product = controller.productDetail.value!;

        return SafeArea(
          child: CustomScrollView(
            slivers: [
              // Image Gallery Section
              // Previous code remains the same until SliverAppBar section
              SliverAppBar(
                expandedHeight: 150, // Reduced height
                pinned: true,
                backgroundColor: Colors.transparent, // Light grey background
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.black, size: 18),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.favorite,
                            color: Colors.red, size: 20),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Main Image
                      Obx(() {
                        final currentImage = [
                          product.picture,
                          ...product.gallery
                        ][controller.currentPage.value];
                        return GestureDetector(
                          onTap: () {
                            // Show full screen image dialog
                            Get.dialog(
                              Dialog(
                                backgroundColor: Colors.transparent,
                                insetPadding: EdgeInsets.zero,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    // Full screen image
                                    InteractiveViewer(
                                      minScale: 0.5,
                                      maxScale: 3.0,
                                      child: Image.network(
                                        currentImage,
                                        // fit: BoxFit.contain,
                                      ),
                                    ),
                                    // Close button
                                    Positioned(
                                      top: 40,
                                      right: 16,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: IconButton(
                                          icon: const Icon(Icons.close,
                                              color: Colors.black),
                                          onPressed: () => Get.back(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.grey[100],
                            padding: const EdgeInsets.all(16),
                            child: Image.network(
                              currentImage,
                              // fit: BoxFit.contain,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return ShimmerLoading(
                                  height: 350,
                                  borderRadius: 0,
                                );
                              },
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.grey[200],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.broken_image,
                                      size: 64,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Image not available',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),

                      // Thumbnail strip at bottom
                      Positioned(
                        bottom: 16,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 70,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                [product.picture, ...product.gallery].length,
                            itemBuilder: (context, index) {
                              final imageUrl =
                                  [product.picture, ...product.gallery][index];
                              return Obx(
                                () => GestureDetector(
                                  onTap: () =>
                                      controller.currentPage.value = index,
                                  child: Container(
                                    width: 60,
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: controller.currentPage.value ==
                                                index
                                            ? Colors.black
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return ShimmerLoading(
                                            height: 60,
                                            borderRadius: 6,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Rest of the code remains the same as in the previous modern version
              // Product Details Section
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tags
                      Wrap(
                        spacing: 8,
                        children: [
                          _buildTag("Top Rated", Colors.blue),
                          _buildTag("Best Seller", const Color(0xFF08E488)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        product.detailPageTitle,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                      // Title and Price
                      const SizedBox(width: 16),
                      Obx(() => Text(formatAmount(controller.selectedVariationPrice.value.toString()),
                            
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: AppColors.secondaryDark,
                                  fontWeight: FontWeight.bold,
                                ),
                          )),
                      const SizedBox(height: 24),

                      // Color Selection
                      if( product.colors.isNotEmpty)
                      _buildSelectionSection(
                        title: "Color",
                        children: product.colors.map((color) {
                          return _buildSelectionChip(
                            title: color.title,
                            isSelected:
                                controller.selectedColor.value == color.id,
                            onTap: () =>
                                controller.updateSelectedColor(color.id),
                            selectedColor: AppColors.secondaryDark,
                          );
                        }).toList(),
                      ),
                   if( product.colors.isNotEmpty)   const SizedBox(height: 24),

                      // Memory Selection
                      if( product.memories.isNotEmpty)
                      _buildSelectionSection(
                        title: "Storage",
                        children: product.memories.map((memory) {
                          return _buildSelectionChip(
                            title: memory.title,
                            isSelected:
                                controller.selectedMemory.value == memory.id,
                            onTap: () =>
                                controller.updateSelectedMemory(memory),
                            selectedColor: AppColors.secondaryDark,
                          );
                        }).toList(),
                      ),
                     if( product.memories.isNotEmpty)   const SizedBox(height: 24),

                      // Description Sections
                      _buildDescriptionSection(
                        title: "Overview",
                        content: product.shortDescription,
                      ),
                      const SizedBox(height: 16),
                      _buildDescriptionSection(
                        title: "Details",
                        content: product.longDescription,
                      ),
                      const SizedBox(height: 24),

                      // Quantity Selector
                      QuantitySelector(),
                      const SizedBox(height: 24),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppColors.secondaryDark,
                                elevation: 0,
                                side:
                                    BorderSide(color: AppColors.secondaryDark),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text("Buy Now"),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                final cartController =
                                    Get.put(CartController());
                                cartController.addToCart(
                                  productId: product.id.toString(),
                                  memoryId: controller.selectedMemory.value
                                      .toString(),
                                  color:
                                      controller.selectedColor.value.toString(),
                                  price: controller.selectedVariationPrice.value
                                      .toString(),
                                  minAdvancePrice:
                                      product.minAdvancePrice.toString(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryDark,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.shopping_cart,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8),
                                  Text("Add to Cart"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSelectionSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: children,
        ),
      ],
    );
  }

  Widget _buildSelectionChip({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    required Color selectedColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? selectedColor : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionSection({
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        AnimatedReadMoreText(
          content,
          maxLines: 3,
          readMoreText: 'Show more',
          readLessText: 'Show less',
          textStyle: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            height: 1.5,
          ),
          buttonTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryDark,
          ),
        ),
      ],
    );
  }
}
