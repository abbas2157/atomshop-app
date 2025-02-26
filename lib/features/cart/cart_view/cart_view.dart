import 'package:atomshop/common/constants/image_constants.dart';
import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/common/widgets/loading.dart';
import 'package:atomshop/extenstion/padding_extension.dart';
import 'package:atomshop/features/cart/controller/cart_controller.dart';
import 'package:atomshop/features/cart/widget/cart_item.dart';
import 'package:atomshop/style/colors/app_colors.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  CartView({super.key});
  final controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    controller.getCartItems();
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: List.generate(5, (index) => ShimmerLoading(height: 100, borderRadius: 12)),
          );
        }

        if (controller.cartItemsList.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.emptyCart, height: 200),
                  const SizedBox(height: 16),
                  Text("Your cart is empty", style: AppTextStyles.headline1),
                  const SizedBox(height: 8),
                  Text(
                    "Looks like you haven't added anything to your cart. Browse our top categories!",
                    style: AppTextStyles.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  CommonButton(text: "Explore Categories", onPressed: () {}),
                ],
              ),
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: controller.cartItemsList.length,
                itemBuilder: (context, index) {
                  final item = controller.cartItemsList[index];
                  return CartItemWidget(
                    item: item,
                    onDeleteTap: () => controller.removeItem(item.id.toString()),
                  );
                },
              ),
            ),
            _buildSummarySection(),
          ],
        );
      }),
    );
  }

  Widget _buildSummarySection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Subtotal", style: TextStyle(fontSize: 16)),
              Text("Rs ${controller.subtotal.value}", style: AppTextStyles.headline2),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("Rs ${controller.total.value}",
                  style: AppTextStyles.headline2.copyWith(color: AppColors.secondaryLight)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryLight,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text("Proceed to Checkout", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
