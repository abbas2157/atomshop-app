import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SliderController extends GetxController {
  var isLoading = true.obs;
  var sliderList = [].obs;

  @override
  void onInit() {
    fetchSliders();
    super.onInit();
  }

  Future<void> fetchSliders() async {
    try {
      final data = await NetworkManager().getRequest("sliders");

      if (data["success"]) {
        sliderList.value = data["data"];
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching sliders: $e");
      }
    } finally {
      isLoading(false);
    }
  }
}
