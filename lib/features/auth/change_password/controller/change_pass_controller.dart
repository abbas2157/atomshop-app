import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  
  RxBool isLoading = false.obs;

  void changePassword() {
    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "New passwords do not match!",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    // Simulate API Call (Replace with actual API request)
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
      Get.snackbar("Success", "Password changed successfully!",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
      Get.back(); // Go back after success
    });
  }
}
