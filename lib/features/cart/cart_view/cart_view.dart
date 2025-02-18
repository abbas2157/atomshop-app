import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/common/constants/image_constants.dart';
import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/common/widgets/loading.dart';
import 'package:atomshop/extenstion/padding_extension.dart';
import 'package:atomshop/features/cart/controller/cart_controller.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  CartView({super.key});
  final controller = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    controller.getCartItems();
    return SafeArea(child: Obx(() {
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

      if (!controller.isLoading.value && controller.cartItemsList.isEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.emptyCart,
              height: 200,
              width: 200,
            ),
            Text(
              "Your cart is empty",
              style: AppTextStyles.headline1,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Looks like you have not added anything in your cart. Go ahead and explore top categories.",
              style: AppTextStyles.bodyText1,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            CommonButton(text: "Explore Categories", onPressed: () {}),
          ],
        );
      }

      return Text(controller.cartItemsList.length.toString());
    }));
  }
}
