import 'package:atomshop/common/utils/app_utils.dart';
import 'package:atomshop/features/profile_feature/utils/utils.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  RxString userId = ''.obs;
  final emailController = TextEditingController();
  Future<bool> sendOtpToEmail(String email) async {
    try {
      AppUtils.showLoading();
      Map<String, dynamic> response = await NetworkManager()
          .postRequest("account/send/code", {"email": email});
      AppUtils.hideLoading();

      // Debugging logs

      if (response["success"] == true) {
        userId.value = response["message"]["user"]["uuid"];
        return true;
      } else if (response["success"] == false) {
        showToastMessage(response["message"]);
      }
      return false;
    } catch (e) {
      debugPrint("Error: $e");
      showToastMessage("An error occurred. Please try again.");
      return false;
    }
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      Map<String, dynamic> response = await NetworkManager().postRequest(
          "account/send/code/verify", {"user_id": userId.value, "code": otp});

      if (response["success"] == true) {
        showToastMessage("OTP verified successfully");
        return true;
      } else if (response["success"] == false) {
        showToastMessage(response["message"]);
      }
      return false;
    } catch (e) {
      debugPrint("Error: $e");
      showToastMessage("An error occurred. Please try again.");
      return false;
    }
  }

  Future<bool> setNewPassword(String password) async {
    try {
      AppUtils.showLoading();
      Map<String, dynamic> response = await NetworkManager().postRequest(
          "account/send/code/reset/password",
          {"user_id": userId.value, "password": password});
      AppUtils.hideLoading();

      if (response["success"] == true) {
        showToastMessage(response["data"] ?? "Password reset successfully.");
        return true;
      } else {
        showToastMessage(response["message"] ?? "Failed to reset password");
      }
    } catch (e) {
      debugPrint("Error: $e");
      showToastMessage("An error occurred. Please try again.");
    }
    return false;
  }
}
