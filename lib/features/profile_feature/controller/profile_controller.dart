import 'package:atomshop/local_storage/local_storage_methods.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString address = ''.obs;
  RxMap selectedCity = {}.obs;
  RxMap selectedArea = {}.obs;
  RxList<dynamic> cities = [].obs;
  RxList<dynamic> areas = [].obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
    getCities();
  }

  Future<void> getProfile() async {
    try {
      isLoading(true);
      var response = await NetworkManager().getRequest(
          "account/profile/${LocalStorageMethods.instance.getUserUUID()}");
      print(response);
      if (response["success"] == true) {
        var userData = response["message"]["user"];
        var customerData = response["message"]["customer"];

        name.value = userData["name"] ?? "";
        email.value = userData["email"] ?? "";
        phone.value = userData["phone"] ?? "";
        address.value = customerData["address"] ?? "";
        selectedCity.value = customerData["city"] ?? {};
        selectedArea.value = customerData["area"] ?? {};

        getAreasByCity(selectedCity['id']);
      }
    } catch (e) {
      print("Error fetching profile: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getCities() async {
    try {
      var response = await NetworkManager().getRequest("cities");
      if (response["success"] == true) {
        cities.assignAll(response["data"]);
      }
    } catch (e) {
      print("Error fetching cities: $e");
    }
  }

  Future<void> getAreasByCity(int cityId) async {
    try {
      var response = await NetworkManager().getRequest("areas/$cityId");
      if (response["success"] == true) {
        areas.assignAll(response["data"]);
      }
    } catch (e) {
      print("Error fetching areas: $e");
    }
  }

  Future<void> updateProfile({
    required String inputname,
    required String inputphone,
    required String inputadress,
    required String inputemail,
  }) async {
    try {
      isLoading(true);
      var body = {
        "user_id": LocalStorageMethods.instance.getUserUUID(),
        "name": inputname,
        "phone": inputphone,
        "email": inputemail,
        "address": inputadress,
        "city_id": selectedCity['id'],
        "area_id": selectedArea['id'],
      };
      var response =
          await NetworkManager().postRequest("account/profile/update", body);

      if (response["success"] == true) {
        Get.snackbar("Success", "Profile updated successfully");
        getProfile();
        getCities();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error updating profile: $e");
      }
    } finally {
      isLoading(false);
    }
  }
}
