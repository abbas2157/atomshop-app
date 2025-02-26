import 'package:atomshop/features/categories/category_wise_products/model/category_wise_product_model.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:get/get.dart';

class CategoriesWiseProductsController extends GetxController {
  final RxList<CategoryWiseProductModel> categoryProducts =
      <CategoryWiseProductModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> fetchProducts(String id) async {
    try {
      isLoading(true);
      var response = await NetworkManager().getRequest('products/category/$id');

      if (response['success'] == true) {
        var products = response['data'] as List;
        categoryProducts.value = products
            .map((json) => CategoryWiseProductModel.fromJson(json))
            .toList();
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
