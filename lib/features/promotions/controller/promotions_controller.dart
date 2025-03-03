import 'package:atomshop/features/promotions/model/promotions_model.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class PromotionsController extends GetxController {
  var isLoading = true.obs;
  var promotions = <PromotionsModel>[].obs;

  @override
  void onInit() {
    fetchBrands();
    super.onInit();
  }

  Future<void> fetchBrands() async {
    try {
      isLoading(true);
      var response = await NetworkManager().getRequest('promotions');

      if (response['success'] == true) {
        var promotionsList = response['data'] as List;
        promotions.value = promotionsList
            .map((json) => PromotionsModel.fromJson(json))
            .toList();
      } else {
        throw Exception("Failed to load promotions");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching promotions: $e");
      }
    } finally {
      isLoading(false);
    }
  }
}
