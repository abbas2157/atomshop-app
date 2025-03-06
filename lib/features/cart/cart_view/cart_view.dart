import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/common/constants/image_constants.dart';
import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/common/widgets/loading.dart';
import 'package:atomshop/extenstion/padding_extension.dart';
import 'package:atomshop/features/bottom_nav_bar/bottom_nav_bar_controller/bottom_nav_bar_controller.dart';
import 'package:atomshop/features/cart/controller/cart_controller.dart';
import 'package:atomshop/features/cart/model/cart_item_model.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  CartView({super.key});
  final CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.cartItemsList.isEmpty) {
          return _emptyCart();
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: controller.cartItemsList.length,
                itemBuilder: (context, index) {
                  final item = controller.cartItemsList[index];
                  return _cartItemTile(item, controller);
                },
              ),
            ),
            _cartSummary(controller),
          ],
        );
      }),
    );
  }

  /// Empty cart view
  Widget _emptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.emptyCart, height: 150),
          const SizedBox(height: 10),
          Text("Your cart is empty", style: AppTextStyles.headline2),
          const SizedBox(height: 5),
          Text("Start shopping now!", style: AppTextStyles.bodyText1),
          const SizedBox(height: 20),
          CommonButton(
            text: "Explore categories",
            onPressed: () {
              final BottomNavController bottomNavController =
                  Get.find<BottomNavController>();
              bottomNavController.changePage(1);
            },
          ),
        ],
      ).paddingHorizontel(AppConstants.HorizontelPadding),
    );
  }

  /// Compact cart item UI
  Widget _cartItemTile(CartItemModel item, CartController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          // Product Image
          CachedNetworkImage(
            imageUrl: item.product?.picture ?? "",
            height: 60,
            width: 60,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                ShimmerLoading(height: 60, width: 60, borderRadius: 10),
            errorWidget: (context, url, error) =>
                const Icon(Icons.image_not_supported, size: 40),
          ),
          const SizedBox(width: 10),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product?.title ?? "Product",
                    style: AppTextStyles.bodyText1, maxLines: 1),
                const SizedBox(height: 4),
                Text("Rs. ${item.productPrice ?? "0"}",
                    style: AppTextStyles.bodyText1.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),

          // Quantity Controls + Delete
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red, size: 22),
                onPressed: () {
                  controller.removeItem(item.id.toString());
                  controller.getCartItems();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Minimalist quantity button

  /// Total price & Checkout
  Widget _cartSummary(CartController controller) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total:", style: TextStyle(fontSize: 16)),
              Obx(() => Text("Rs. ${controller.totalAmount}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold))),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.toNamed('/checkout'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Checkout",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
