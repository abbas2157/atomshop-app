import 'package:atomshop/features/areas/model/area_model.dart';
import 'package:atomshop/features/areas/model/city_model.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:get/get.dart';


class CityAreaController extends GetxController {
  RxList<CityModel> cities = <CityModel>[].obs;
  RxList<AreaModel> areas = <AreaModel>[].obs;
  RxBool isLoading = false.obs;

  Future<void> fetchCities() async {
    isLoading.value = true;
    try {
      var response = await NetworkManager().getRequest("cities");
      if (response["success"] == true) {
        var cityList =
            (response["data"] as List).map((json) => CityModel.fromJson(json)).toList();
        cities.assignAll(cityList);
      }
    } catch (e) {
      print("Error fetching cities: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAreasByCity(int cityId) async {
    isLoading.value = true;
    try {
      var response = await NetworkManager().getRequest("areas/$cityId");
      if (response["success"] == true) {
        var areaList =
            (response["data"] as List).map((json) => AreaModel.fromJson(json)).toList();
        areas.assignAll(areaList);
      }
    } catch (e) {
      print("Error fetching areas: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
