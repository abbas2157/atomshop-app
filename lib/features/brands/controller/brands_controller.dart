import 'package:atomshop/features/brands/model/brand_product_model.dart';
import 'package:atomshop/features/brands/model/brands_model.dart';
import 'package:atomshop/features/brands/view/brands_products.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class BrandsController extends GetxController {
  var isLoading = true.obs;
  var brands = <BrandsModel>[].obs;

  var isLoadingBrandProducts = true.obs;

  var brandProducts = <BrandProductModel>[].obs;

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

  Future<void> fetchBrandProducts(String brandId) async {
    try {
      isLoadingBrandProducts(true);
      var response =
          await NetworkManager().getRequest('products/brand/$brandId');

      if (response['success'] == true) {
        var products = response['data'] as List;
        brandProducts.value =
            products.map((json) => BrandProductModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load  brand products");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching brands: $e");
      }
    } finally {
      isLoadingBrandProducts(false);
    }
  }
}
