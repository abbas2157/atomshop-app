import 'package:atomshop/features/auth/forget_password/view/forget_pass_otp_verify.dart';
import 'package:atomshop/features/auth/forget_password/view/password_reset_success.dart';
import 'package:atomshop/features/auth/forget_password/view/reset_password.dart';
import 'package:atomshop/features/profile/utils/utils.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  Future<String?> sendOTPonEmail(String email, bool resend) async {
    try {
      isLoading.value = true;
      var data = await NetworkManager()
          .postRequest("account/send/code", {"email": email});
      debugPrint(data.toString());
      if (data["success"]) {
        showToastMessage(data["data"], gravity: ToastGravity.TOP);
        final String uuid = (data["message"]["user"]["uuid"]).toString();
        final String otp = (data["message"]["code"]).toString();
        Get.to(() => ForgetPassOtpVerify(
              uuid: uuid,
              email: email,
              otp: otp,
             
            ));
        return uuid;
      } else {
        showToastMessage(data["message"]);
      }
      return null;
    } catch (e) {
      showToastMessage(e.toString());
      debugPrint(e.toString());
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOTP(String userID, String otp) async {
    try {
      isLoading.value = true;
      var data =
          await NetworkManager().postRequest("account/send/code/verify", {
        "user_id": userID,
        "code": otp,
      });
      print(data);
      if (data["success"]) {
        final String userID = data["message"]["user_id"];
        Get.to(() => ResetPassword(
              userId: userID,
            ));
      } else {
        showToastMessage("Error");
      }
    } catch (e) {
      showToastMessage(e.toString());
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword(String password, String userID) async {
    try {
      isLoading.value = true;
      var data = await NetworkManager()
          .postRequest("account/send/code/reset/password", {
        "user_id": userID,
        "password": password,
      });
      print(data);
      if (data["success"]) {
        
        Get.offAll(() => PasswordResetSuccess());
        showToastMessage(data["data"]);
      } else {
        showToastMessage("Error");
      }
    } catch (e) {
      showToastMessage(e.toString());
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
