import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/local_storage/local_storage_methods.dart';
import 'package:atomshop/style/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

abstract class AppUtils {
  static void hideLoading() {
    final context = AppConstants.navigatorKey.currentContext;
    if (context != null && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  static void showLoading() async {
    final context = AppConstants.navigatorKey.currentContext!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final leftDotColor =
        isDarkMode ? Colors.white : Colors.black; // Theme-based color

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppConstants.dialogsBorderRadius),
          ),
          backgroundColor: Colors.transparent,
          child: Center(
            child: LoadingAnimationWidget.flickr(
              leftDotColor: leftDotColor, // Apply theme-aware color
              rightDotColor: AppColors.secondaryLight,
              size: 50,
            ),
          ),
        );
      },
    );
  }

  static void showSnackBar(String title, String message) {
    Get.rawSnackbar(
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
        isDismissible: true,
        message: message,
        backgroundColor: Colors.black,
        borderRadius: AppConstants.fieldsBorderRadius,
        margin: const EdgeInsets.only(top: 10, left: 15, right: 15));
  }

  static bool isUserLoggedIn() {
    String? token = LocalStorageMethods.instance.getUserApiToken();
    return token != null && token.isNotEmpty;
  }
}
