import 'package:atomshop/common/utils/app_utils.dart';
import 'package:atomshop/features/bottom_nav_bar/bottom_nav_bar_view/bottom_nav_bar_view.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:atomshop/network/urls/app_urls.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };

    try {
      AppUtils.showLoading();
      final response = await NetworkManager().postRequest(
        AppUrls.login,
        body,
      );
      AppUtils.hideLoading();
      // Check if login was successful and return the user data
      if (response['success'] == true) {
        Get.to(() => BottomNavPage());
        return response['data']; // Return user data and token
      } else {
        throw Exception('Login failed: ${response['message']}');
      }
    } catch (e) {
      throw Exception('An error occurred during login: $e');
    }
  }
}
