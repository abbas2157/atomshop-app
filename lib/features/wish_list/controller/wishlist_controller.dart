import 'package:atomshop/common/utils/app_utils.dart';
import 'package:atomshop/features/profile/utils/utils.dart';
import 'package:atomshop/features/wish_list/model/wish_list_item_model.dart';
import 'package:atomshop/local_storage/local_storage_methods.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController {
  final RxList<WishListItemModel> wishList = <WishListItemModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxMap<String, bool> favoriteProducts = <String, bool>{}.obs;

  void getWishListItems() async {
    try {
      bool isUserLoggedIn = AppUtils.isUserLoggedIn();
      isLoading.value = true;
      wishList.clear();
      Map<String, dynamic> payload = {
        "user_type": isUserLoggedIn ? "auth" : "guest",
        if (!isUserLoggedIn) "guest_id": "abcd-6789-mkvb-8765",
        if (isUserLoggedIn) "user_id": LocalStorageMethods.instance.getUserId(),
      };
      var response = await NetworkManager().postRequest("favorites", payload);
      if (response['success'] == true) {
        for (Map<String, dynamic> item in response['data']) {
          wishList.add(WishListItemModel.fromJson(item));
        }
        getCount();
      } else {
        throw Exception('Login failed: ${response['message']}');
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  void addToWishList({
    required String productId,
  }) async {
    try {
      bool isUserLoggedIn = AppUtils.isUserLoggedIn();

      Map<String, dynamic> payload = {
        "user_type": isUserLoggedIn ? "auth" : "guest",
        if (!isUserLoggedIn) "guest_id": "abcd-6789-mkvb-8765",
        if (isUserLoggedIn) "user_id": LocalStorageMethods.instance.getUserId(),
        "product_id": productId,
      };

      // Check if the item is already in the favorites
      if (favoriteProducts[productId] == true) {
        // If it's already a favorite, remove it
        var response =
            await NetworkManager().postRequest("favorites/remove", payload);
        if (response['original']['success'] == true) {
          showToastMessage(response['original']['message']);
          favoriteProducts[productId] = false; // Update the local state
          getWishListItems(); // Refresh wishlist items
          getCount();
        } else {
          throw Exception('Failed to remove: ${response['message']}');
        }
      } else {
        var response =
            await NetworkManager().postRequest("favorites/add", payload);
        if (response['success'] == true) {
          showToastMessage(response['message']);
          favoriteProducts[productId] = !(favoriteProducts[productId] ?? false);
          getCount();
        } else {
          throw Exception('Login failed: ${response['message']}');
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  RxInt wishCount = 0.obs;
  RxBool showWishBadge = false.obs;

  void getCount() async {
    try {
      bool isUserLoggedIn = AppUtils.isUserLoggedIn();

      Map<String, dynamic> payload = {
        "user_type": isUserLoggedIn ? "auth" : "guest",
        if (!isUserLoggedIn) "guest_id": "abcd-6789-mkvb-8765",
        if (isUserLoggedIn) "user_id": LocalStorageMethods.instance.getUserId(),
      };

      var response =
          await NetworkManager().postRequest("favorites/count", payload);
      if (response['success'] == true) {
        wishCount.value = response['count'];
        showWishBadge.value = response['count'] > 0;
      } else {
        throw Exception('Login failed: ${response['message']}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> removeItem(String id) async {
    try {
      bool isUserLoggedIn = AppUtils.isUserLoggedIn();

      Map<String, dynamic> payload = {
        "user_type": isUserLoggedIn ? "auth" : "guest",
        if (!isUserLoggedIn) "guest_id": "abcd-6789-mkvb-8765",
        if (isUserLoggedIn) "user_id": LocalStorageMethods.instance.getUserId(),
        "product_id": id,
      };

      var response =
          await NetworkManager().postRequest("favorites/remove", payload);
      if (response['original']['success'] == true) {
        showToastMessage(response['original']['message']);
        getWishListItems();
        getCount();
      } else {
        throw Exception('Login failed: ${response['message']}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
