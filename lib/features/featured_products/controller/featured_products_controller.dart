import 'package:atomshop/features/featured_products/model/featured_products_model.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:get/get.dart';


class FeaturedProductsController extends GetxController {
  var isLoading = true.obs;
  var featuredProducts = <LatestProductsModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  Future<void> fetchFeaturedProducts() async {
    try {
      isLoading(true);
      var response = await NetworkManager().getRequest('products');

      if (response['success'] == true) {
        var products = response['data']['data'] as List;
        featuredProducts.value = products.map((json) => LatestProductsModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      isLoading(false);
    }
  }
}

