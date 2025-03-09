import 'package:atomshop/common/widgets/loading.dart';
import 'package:atomshop/features/cart/controller/cart_controller.dart';
import 'package:atomshop/features/featured_products/model/single_product_detail_model.dart';
import 'package:atomshop/features/installment_calculator/view/calculator_view.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/single_product_detail_controller.dart';

class SingleProductDetailView extends StatelessWidget {
  final int productId;

  const SingleProductDetailView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final ProductDetailController controller =
        Get.put(ProductDetailController());
    controller.fetchProductDetails(productId);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildShimmerLoading();
        }

        if (controller.productDetail.value == null) {
          return const Center(child: Text("Failed to load product details"));
        }

        final product = controller.productDetail.value!;

        return SafeArea(
          child: Column(
            children: [
              _buildTopSection(product, controller),
              Expanded(child: _buildBottomDetails(product, controller)),
            ],
          ),
        );
      }),
    );
  }

  /// 🖼 **Top Section: Image Slider & Favorite Button**
  Widget _buildTopSection(
      ProductDetailModel product, ProductDetailController controller) {
    return Stack(
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            onPageChanged: (index) => controller.currentPage.value = index,
            itemCount: product.gallery.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: product.gallery[index],
                fit: BoxFit.contain,
                placeholder: (_, __) =>
                    ShimmerLoading(height: 250, borderRadius: 15),
                errorWidget: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 50),
              );
            },
          ),
        ),
        Positioned(
          top: 40,
          left: 16,
          child: _buildIconButton(Icons.arrow_back_ios, () => Get.back()),
        ),
        Positioned(
          top: 40,
          right: 16,
          child: _buildIconButton(Icons.favorite, () {}, Colors.red),
        ),
      ],
    );
  }

  /// 🛒 **Bottom Section: Details, Variants, & Actions**
  Widget _buildBottomDetails(
      ProductDetailModel product, ProductDetailController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: Colors.black12, offset: Offset(0, -4), blurRadius: 8)
        ],
      ),
      child: ListView(
        children: [
          _buildTitleAndPrice(product, controller),
          const SizedBox(height: 20),
          _buildSelectionRow("Color", product.colors, controller.selectedColor,
              controller.updateSelectedColor),
          const SizedBox(height: 20),
          _buildSelectionRow(
            "Memory",
            product.memories,
            controller.selectedMemory,
            (int id) {
              final selectedVariant = controller.productDetail.value!.memories
                  .firstWhere((memory) => memory.id == id);
              controller.updateSelectedMemory(selectedVariant);
            },
          ),
          const SizedBox(height: 20),
          _buildDescriptionSection("Overview", product.shortDescription),
          const SizedBox(height: 20),
          // _buildQuantitySelector(),
          InstallmentCalculator(
            totalProductPrice: double.tryParse(
                    controller.selectedVariationPrice.value.toString()) ??
                0,
            minAdvanceAmount:
                double.tryParse(product.minAdvancePrice.toString()) ?? 0,
            onInstallmentChange: (dealAmount, advanceAmount, months) {

              // 🔥 Store the values in your controller or state variables
              // controller.dealAmount = dealAmount.toStringAsFixed(2);
              // controller.advanceAmount.value = advanceAmount.toStringAsFixed(2);
              // controller.tenureMonths.value = months.toString();
            },
          ),
          const SizedBox(height: 20),

          _buildCTAButtons(product, controller),
        ],
      ),
    );
  }

  /// 🏷 **Title & Price**
  Widget _buildTitleAndPrice(
      ProductDetailModel product, ProductDetailController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(product.detailPageTitle,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
        Text(
          "Rs ${controller.selectedVariationPrice.value}",
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ],
    );
  }

  /// 🎨 **Selection Row (Color / Memory)**
  Widget _buildSelectionRow(String title, List<ProductVariant> items,
      Rxn<int> selectedId, Function(int) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          children: items.map((item) {
            bool isSelected = selectedId.value == item.id;
            return GestureDetector(
              onTap: () => onSelect(item.id),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 4)
                        ]
                      : null,
                ),
                child: Text(
                  item.title,
                  style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// 📜 **Product Description**
  Widget _buildDescriptionSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(content,
            style: const TextStyle(fontSize: 14, color: Colors.black87)),
      ],
    );
  }

  /// 🔢 **Quantity Selector**
  // Widget _buildQuantitySelector() {
  //   return Row(
  //     children: [
  //       const Text("Quantity",
  //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //       const SizedBox(width: 15),
  //       QuantitySelector(),
  //     ],
  //   );
  // }

  /// 🚀 **CTA Buttons (Buy Now, Add to Cart)**
  Widget _buildCTAButtons(
      ProductDetailModel product, ProductDetailController controller) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            child: const Text("Buy Now",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white)),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              final cartController = Get.put(CartController());
              cartController.addToCart(
                dealAmount: "0.00",
                tenureMonths: "1",
                productId: product.id.toString(),
                memoryId: controller.selectedMemory.value,
                color: controller.selectedColor.value,
                price: controller.selectedVariationPrice.value.toString(),
                minAdvancePrice: product.minAdvancePrice.toString(),
              );
            },
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            label: const Text(
              "Add To Cart",
              style: AppTextStyles.buttonText,
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
        ),
      ],
    );
  }

  /// 🔘 **Reusable Icon Button**
  Widget _buildIconButton(IconData icon, VoidCallback onTap,
      [Color color = Colors.black]) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(icon, color: color),
      ),
    );
  }

  /// 💨 **Shimmer Loading Skeleton**
  Widget _buildShimmerLoading() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ShimmerLoading(height: 250),
        const SizedBox(height: 16),
        ShimmerLoading(height: 20, width: 200)
      ],
    );
  }
}
