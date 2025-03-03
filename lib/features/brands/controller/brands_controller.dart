import 'package:atomshop/features/brands/model/brands_model.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:get/get.dart';

class BrandsController extends GetxController {
  var isLoading = true.obs;
  var brands = <BrandsModel>[].obs;

  @override
  void onInit() {
    fetchBrands();
    super.onInit();
  }

  Future<void> fetchBrands() async {
    try {
      isLoading(true);
      var response = await NetworkManager().getRequest('brands');

      if (response['success'] == true) {
        var products = response['data'] as List;
        brands.value =
            products.map((json) => BrandsModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print("Error fetching brands: $e");
    } finally {
      isLoading(false);
    }
  }
}
