import 'package:atomshop/features/cart/model/cart_item_model.dart';
import 'package:atomshop/features/profile/utils/utils.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final RxList<CartItemModel> cartItemsList = <CartItemModel>[].obs;
  final RxBool isLoading = false.obs;

  void getCartItems() async {
    try {
      isLoading.value = true;
      cartItemsList.clear();
      Map<String, dynamic> payload = {
        "user_type": "guest",
        "guest_id": "GHD768GGYH",
      };
      var response = await NetworkManager().postRequest("cart", payload);
      if (response['success'] == true) {
        for (Map<String, dynamic> item in response['data']['cart']) {
          cartItemsList.add(CartItemModel.fromJson(item));
        }

        //showToastMessage(response['original']['message']);
      } else {
        throw Exception('Login failed: ${response['message']}');
      }
      isLoading.value = false;
    } catch (e) {
      debugPrint(e.toString());
      isLoading.value = false;
    }
  }

  void addToCart({
    required String productId,
    required String memoryId,
    required String color,
    required String price,
    required String minAdvancePrice,
  }) async {
    try {
      Map<String, dynamic> payload = {
        "product_id": productId,
        "memory_id": memoryId,
        "color_id": color,
        "price": price,
        "min_advance_price": productId,
        "user_type": "guest",
        "guest_id": "GHD768GGYH",
      };

      var response = await NetworkManager().postRequest("cart/add", payload);
      if (response['success'] == true) {
        showToastMessage(response['message']);
        getCount();
      } else {
        throw Exception('Login failed: ${response['message']}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  RxInt cartCount = 0.obs;
  RxBool showCartBadge = false.obs;

  void getCount() async {
    try {
      Map<String, dynamic> payload = {
        "user_type": "guest",
        "guest_id": "GHD768GGYH",
      };

      var response = await NetworkManager().postRequest("cart/count", payload);
      if (response['success'] == true) {
        cartCount.value = response['count'];
        showCartBadge.value = response['count'] > 0;
      } else {
        throw Exception('Login failed: ${response['message']}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void removeItem(String id) async {
    try {
      Map<String, dynamic> payload = {
        "cart_id": id,
      };
      var response = await NetworkManager().postRequest("cart/count", payload);
      if (response['original']['success'] == true) {
        showToastMessage(response['original']['message']);
      } else {
        throw Exception('Login failed: ${response['message']}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
