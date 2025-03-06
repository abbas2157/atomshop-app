import 'package:atomshop/common/utils/app_utils.dart';
import 'package:atomshop/features/cart/model/cart_item_model.dart';
import 'package:atomshop/features/profile/utils/utils.dart';
import 'package:atomshop/local_storage/local_storage_methods.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final RxList<CartItemModel> cartItemsList = <CartItemModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxInt cartCount = 0.obs;
  final RxBool showCartBadge = false.obs;
  RxString totalAmount = "0".obs;

  @override
  void onInit() {
    super.onInit();
    getCartItems();
    getCount();
  }

  /// Fetch Cart Items
  void getCartItems() async {
    try {
      cartItemsList.clear();
      cartItemsList.refresh();
      isLoading.value = true;
      Map<String, dynamic> payload = {
        "user_type": AppUtils.isUserLoggedIn() ? "auth" : "guest",
        if (!AppUtils.isUserLoggedIn()) "guest_id": "abcd-6789-mkvb-8765",
        if (AppUtils.isUserLoggedIn())
          "user_id": LocalStorageMethods.instance.getUserId(),
      };

      var response = await NetworkManager().postRequest("cart", payload);
      if (response['success'] == true) {
        cartItemsList.assignAll(
          response['data']['cart']
              .map<CartItemModel>((item) => CartItemModel.fromJson(item))
              .toList(),
        );
        totalAmount.value = response['data']['total'] ?? "0";
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Add Item to Cart
  void addToCart({
    required String productId,
     int? memoryId,
     int? color,
    required String price,
    required String minAdvancePrice,
    required String tenureMonths,
  }) async {
    try {
      Map<String, dynamic> payload = {
        "product_id": productId,
        "memory_id":  memoryId,
        "color_id": color,
        "price": price,
        "tenure_months":tenureMonths,
        "min_advance_price": minAdvancePrice,
        "user_type": AppUtils.isUserLoggedIn() ? "auth" : "guest",
        if (!AppUtils.isUserLoggedIn()) "guest_id": "abcd-6789-mkvb-8765",
        if (AppUtils.isUserLoggedIn())
          "user_id": LocalStorageMethods.instance.getUserId(),
      };

      var response = await NetworkManager().postRequest("cart/add", payload);
      if (response['success'] == true) {
        showToastMessage(response['message']);
        cartItemsList.clear();
        cartItemsList.refresh();
        getCartItems(); // Refresh cart
        getCount();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Remove Item from Cart
  void removeItem(String id) async {
    try {
      Map<String, dynamic> payload = {"cart_id": id};
      var response = await NetworkManager().postRequest("cart/remove", payload);
       print(response);
      if (response["original"]['success'] == true) {
        getCartItems(); // Refresh cart
        getCount();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Get Cart Count (For Badge Updates)
  void getCount() async {
    try {
      Map<String, dynamic> payload = {
        "user_type": AppUtils.isUserLoggedIn() ? "auth" : "guest",
        if (!AppUtils.isUserLoggedIn()) "guest_id": "abcd-6789-mkvb-8765",
        if (AppUtils.isUserLoggedIn())
          "user_id": LocalStorageMethods.instance.getUserId(),
      };

      var response = await NetworkManager().postRequest("cart/count", payload);
      if (response['success'] == true) {
        cartCount.value = response['count'];
        showCartBadge.value = response['count'] > 0;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Clear Cart
  void clearCart() async {
    try {
      Map<String, dynamic> payload = {
        "user_type": AppUtils.isUserLoggedIn() ? "auth" : "guest",
        if (!AppUtils.isUserLoggedIn()) "guest_id": "abcd-6789-mkvb-8765",
        if (AppUtils.isUserLoggedIn())
          "user_id": LocalStorageMethods.instance.getUserId(),
      };

      var response = await NetworkManager().postRequest("cart/clear", payload);
      if (response['success'] == true) {
        cartItemsList.clear();
        totalAmount.value = "0";
        cartCount.value = 0;
        showCartBadge.value = false;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
