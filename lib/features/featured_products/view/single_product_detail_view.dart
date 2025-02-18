import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/common/widgets/loading.dart';
import 'package:atomshop/features/cart/controller/cart_controller.dart';
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
    final ProductDetailController controller =
        Get.put(ProductDetailController());
    controller.fetchProductDetails(productId);

    return Scaffold(
      // appBar: AppBar(backgroundColor: Colors.transparent,),
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
          //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Image Slider with smooth transition
            //  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),

            Container(
              //  height: 400,
              color: Color(0xFFD9D9D9),
              child: Column(
                children: [
                  SafeArea(
                      bottom: false,
                      right: false,
                      left: false,
                      child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black,
                        child: const Icon(Icons.favorite, color: Colors.red),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                        height: 150,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        onPageChanged: (index, reason) {
                          controller.currentPage.value = index;
                        }),
                    items:
                        [product.picture, ...product.gallery].map((imageUrl) {
                      return Image.network(
                        imageUrl,
                        width: double.infinity,
                        // fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return ShimmerLoading(height: 300, borderRadius: 12);
                        },
                        errorBuilder: (_, __, ___) => Container(
                            height: 200,
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image, size: 50)),
                      );
                    }).toList(),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
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
                                // ignore: deprecated_member_use
                                : Colors.grey.withOpacity(0.5),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.66,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.HorizontelPadding),
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Text(
                              "Top Rated",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Color(0xFF08E488),
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Text("Top Rated",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            product.detailPageTitle,
                            style: Theme.of(context).textTheme.headlineSmall,
                            softWrap:
                                true, // Ensures text wraps instead of overflowing
                          ),
                        ),
                        Obx(() => Text(
                              "RS ${controller.selectedVariationPrice.value}",
                              style: Theme.of(context).textTheme.headlineSmall,
                            )),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // 🔹 Color Selection
                    _buildSelectionCard(
                      title: "Color",
                      children: product.colors.map((color) {
                        bool isSelected =
                            controller.selectedColor.value == color.id;
                        return _buildSelectionChip(
                          title: color.title,
                          isSelected: isSelected,
                          onTap: () => controller.updateSelectedColor(color.id),
                          selectedColor: Colors.blue,
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    // 🔹 Memory Selection
                    _buildSelectionCard(
                      title: "Select Memory",
                      children: product.memories.map((memory) {
                        bool isSelected =
                            controller.selectedMemory.value == memory.id;
                        return _buildSelectionChip(
                          title: memory.title,
                          isSelected: isSelected,
                          onTap: () => controller.updateSelectedMemory(memory),
                          selectedColor: Colors.green,
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    // 🔹 Short Description
                    _buildDescriptionCard(
                      title: "Overview",
                      content: product.shortDescription,
                    ),

                    const SizedBox(height: 10),

                    // 🔹 Long Description (HTML)
                    _buildDescriptionCard(
                      title: "Details",
                      content: product.longDescription,
                      // child: Html(data: product.longDescription),
                    ),

                    const SizedBox(height: 10),
                    Row(
                      children: [
                        QuantitySelector(),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // 🔹 Buy Now Button
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.s,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          height: 50,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12), // Adjust radius for rounded edges
                              ),
                              side: BorderSide(
                                  color: Colors.grey, width: 2), // Grey border
                              padding: EdgeInsets.symmetric(
                                  vertical: 12), // Adjust padding
                            ),
                            child: Text(
                              "Buy Now",
                            ), // Adjust text color
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            height: 50,
                            child: CommonButton(
                                icon: Icon(
                                  Icons.shopping_cart,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                text: "Add To Cart",
                                onPressed: () {
                                  final cartController =
                                      Get.put(CartController());
                                  cartController.addToCart(
                                      productId: product.id.toString(),
                                      memoryId: controller.selectedMemory.value
                                          .toString(),
                                      color: controller.selectedColor.value
                                          .toString(),
                                      price: controller
                                          .selectedVariationPrice.value
                                          .toString(),
                                      minAdvancePrice:
                                          product.minAdvancePrice.toString());
                                })),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            // const SizedBox(height: 20),

            // // 🔹 Title & Price

            // const SizedBox(height: 30),
          ],
        );
      }),
    );
  }

  /// 🔹 Selection Card UI
  Widget _buildSelectionCard(
      {required String title, required List<Widget> children}) {
    return SizedBox(
      // padding: const EdgeInsets.all(16),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(12),
      //   boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Wrap(spacing: 8, children: children),
        ],
      ),
    );
  }

  /// 🔹 Selection Chip UI
  Widget _buildSelectionChip({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    required Color selectedColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(title,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
        backgroundColor: isSelected ? selectedColor : Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: isSelected ? 2 : 0,
      ),
    );
  }

  /// 🔹 Description Card UI
  Widget _buildDescriptionCard(
      {required String title, String? content, Widget? child}) {
    return SizedBox(
      //  padding: const EdgeInsets.all(16),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(12),
      //   boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          if (content != null)
            AnimatedReadMoreText(
              content,
              maxLines: 2,
              // Set a custom text for the expand button. Defaults to Read more
              readMoreText: 'show more',
              // Set a custom text for the collapse button. Defaults to Read less
              readLessText: 'show less',
              // Set a custom text style for the main block of text
              textStyle: const TextStyle(fontSize: 14, color: Colors.black87),
              // Set a custom text style for the expand/collapse button
              buttonTextStyle: TextStyle(
                  fontSize: 16,
                  // fontWeight: FontWeight.bold,
                  color: AppColors.secondaryDark),
            ),
          if (child != null) child,
        ],
      ),
    );
  }
}
