import 'package:atomshop/features/my_installments/model/installment_model.dart';
import 'package:atomshop/local_storage/local_storage_methods.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InstallmentController extends GetxController {
  var installments = <InstallmentModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchInstallments();
    super.onInit();
  }

  Future<void> fetchInstallments() async {
    try {
      isLoading(true);
      final response = await NetworkManager().postRequest(
          "account/my-instalments",
          {"uuid": LocalStorageMethods.instance.getUserUUID()});

      if (response['success']) {
        installments.value = (response['data'] as List)
            .map((e) => InstallmentModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching installments: $e");
      }
    } finally {
      isLoading(false);
    }
  }
}
