import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/common/widgets/loading.dart';
import 'package:atomshop/features/cart/controller/cart_controller.dart';
import 'package:atomshop/features/installment_calculator/view/calculator_view.dart';
import 'package:atomshop/features/wish_list/controller/wishlist_controller.dart';
import 'package:atomshop/style/colors/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/single_product_detail_controller.dart';
import '../widgets/quantity_selector_button/quantity_selector_button.dart';

class SingleProductDetailView extends StatelessWidget {
  final int productId;

  const SingleProductDetailView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.4;
    final ProductDetailController controller =
        Get.put(ProductDetailController());
    controller.fetchProductDetails(productId);

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ShimmerLoading(height: 300, borderRadius: 12), // Image Slider
                const SizedBox(height: 16),
                ShimmerLoading(height: 20, width: 200), // Title
                const SizedBox(height: 10),
                ShimmerLoading(height: 20, width: 100), // Price
                const SizedBox(height: 20),
                ShimmerLoading(height: 40, borderRadius: 20), // Buttons
                const SizedBox(height: 20),
                ShimmerLoading(height: 100, borderRadius: 12), // Description
              ],
            ),
          );
        }

        if (controller.productDetail.value == null) {
          return const Center(child: Text("Failed to load product details"));
        }

        final product = controller.productDetail.value!;

        return Stack(
          children: [
            // Top section with image slider
            Container(
              color: const Color(0xFFF5F5F5), // Lighter background for top part
              child: Column(
                children: [
                  SafeArea(
                    bottom: false,
                    right: false,
                    left: false,
                    child: const SizedBox(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(Icons.arrow_back_ios),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.white.withOpacity(0.8)),
                            shape: MaterialStateProperty.all(CircleBorder()),
                          ),
                        ),
                        Obx(() {
                          final WishlistController controller =
                              Get.put(WishlistController());

                          bool isFavorited = controller
                                  .favoriteProducts[product.id.toString()] ??
                              false;

                          return InkWell(
                            onTap: () {
                              // final controller = Get.put(WishlistController());
                              controller.addToWishList(
                                  productId: product.id.toString());
                            },
                            child: CircleAvatar(
                              radius: cardWidth * 0.1, // 10% of card width
                              backgroundColor: Colors.grey.shade200,

                              child: Icon(
                                  isFavorited
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color:
                                      isFavorited ? Colors.red : Colors.white),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 220,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      viewportFraction: 0.85,
                      onPageChanged: (index, reason) {
                        controller.currentPage.value = index;
                      },
                    ),
                    items:
                        [product.picture, ...product.gallery].map((imageUrl) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return ShimmerLoading(
                                  height: 220, borderRadius: 15);
                            },
                            errorBuilder: (_, __, ___) => Container(
                              height: 220,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Icon(Icons.broken_image, size: 50),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        [product.picture, ...product.gallery].length,
                        (index) {
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.currentPage.value == index
                                  ? AppColors.secondaryDark
                                  : Colors.grey.withOpacity(0.5),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom section with product details
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.68,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, -4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.HorizontelPadding),
                  children: [
                    const SizedBox(height: 30),

                    // Tags row
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "Top Rated",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF08E488),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "Pre-Order",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Title and Price
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            product.detailPageTitle,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "RS ${controller.selectedVariationPrice.value}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.secondaryDark,
                                ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // Color Selection
                    _buildSelectionCard(
                      title: "Color",
                      children: product.colors.map((color) {
                        bool isSelected =
                            controller.selectedColor.value == color.id;
                        return _buildSelectionChip(
                          title: color.title,
                          isSelected: isSelected,
                          onTap: () => controller.updateSelectedColor(color.id),
                          selectedColor: AppColors.secondaryDark,
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    // Memory Selection
                    _buildSelectionCard(
                      title: "Select Memory",
                      children: product.memories.map((memory) {
                        bool isSelected =
                            controller.selectedMemory.value == memory.id;
                        return _buildSelectionChip(
                          title: memory.title,
                          isSelected: isSelected,
                          onTap: () => controller.updateSelectedMemory(memory),
                          selectedColor: const Color(0xFF08E488),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 25),

                    // Short Description
                    _buildDescriptionCard(
                      title: "Overview",
                      content: product.shortDescription,
                    ),

                    const SizedBox(height: 20),

                    InstallmentCalculator(
                      totalProductPrice: double.parse(
                          controller.selectedVariationPrice.value.toString()),
                      minAdvanceAmount:
                          double.parse(product.minAdvancePrice.toString()),
                    ),

                    const SizedBox(height: 20),

                    // Long Description (HTML)
                    _buildDescriptionCard(
                      title: "Details",
                      content: product.longDescription,
                    ),

                    const SizedBox(height: 20),

                    // Quantity selector
                    Row(
                      children: [
                        Text(
                          "Quantity",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 15),
                        QuantitySelector(),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // Buy Now & Add to Cart Buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                side: const BorderSide(
                                    color: Colors.grey, width: 1.5),
                              ),
                              child: const Text(
                                "Buy Now",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: CommonButton(
                              icon: const Icon(
                                Icons.shopping_cart,
                                size: 20,
                                color: Colors.white,
                              ),
                              text: "Add To Cart",
                              onPressed: () {
                                final cartController =
                                    Get.put(CartController());
                                cartController.addToCart(
                                  tenureMonths: "1",
                                  productId: product.id.toString(),
                                  memoryId:
                                      controller.selectedMemory.value != null
                                          ? controller.selectedMemory.value
                                          : null,
                                  color: controller.selectedColor.value != null
                                      ? controller.selectedColor.value
                                      : null,
                                  price: controller.selectedVariationPrice.value
                                      .toString(),
                                  minAdvancePrice:
                                      product.minAdvancePrice.toString(),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  /// Selection Card UI
  Widget _buildSelectionCard(
      {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: children,
        ),
      ],
    );
  }

  /// Selection Chip UI
  Widget _buildSelectionChip({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    required Color selectedColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                      color: selectedColor.withOpacity(0.3),
                      blurRadius: 4,
                      offset: Offset(0, 2))
                ]
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  /// Description Card UI
  Widget _buildDescriptionCard(
      {required String title, String? content, Widget? child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        if (content != null)
          AnimatedReadMoreText(
            content,
            maxLines: 2,
            readMoreText: 'show more',
            readLessText: 'show less',
            textStyle: const TextStyle(
                fontSize: 14, color: Colors.black87, height: 1.5),
            buttonTextStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryDark,
            ),
          ),
        if (child != null) child,
      ],
    );
  }

  /// Payment Calculator UI
  /// Payment Calculator UI
}
