import 'package:atomshop/features/top_rated_products/model/top_rated_products_model.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class TopRatedProductsController extends GetxController {
  var isLoading = true.obs;
  var topRatedProducts = <TopRatedProductsModel>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      var response = await NetworkManager().getRequest('products/toprated');

      if (response['success'] == true) {
        var products = response['data'] as List;
        topRatedProducts.value = products
            .map((json) => TopRatedProductsModel.fromJson(json))
            .toList();
      } else {
        throw Exception("Failed to load top rated products");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching top rated products: $e");
      }
    } finally {
      isLoading(false);
    }
  }
}
