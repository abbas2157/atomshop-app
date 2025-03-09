import 'package:atomshop/common/utils/app_utils.dart';
import 'package:atomshop/features/auth/login/login_view/login_view.dart';
import 'package:atomshop/features/profile_feature/utils/utils.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:atomshop/network/urls/app_urls.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  Future<Map<String, dynamic>> signup(
    String name,
    String email,
    String password,
    String cPassword,
  ) async {
    final Map<String, dynamic> body = {
      'name': name,
      'email': email,
      'password': password,
      'c_password': cPassword,
    };

    try {
      AppUtils.showLoading();
      final response = await NetworkManager().postRequest(
        AppUrls.signup, 
        body,
      );
      AppUtils.hideLoading();
      // Check if login was successful and return the user data
      if (response['success'] == true) {
        AppUtils.showSnackBar("", "Success");
        Get.offAll(() => LoginScreen());
        return response['data']; // Return user data and token
      }
      else if(response['success'] == false){
        showToastMessage(response['data']["email"][0]??"Email already exists");
        return response['data'];
      }
       else {
        throw Exception('Login failed: ${response['message']}');
      }
    } catch (e) {
      throw Exception('An error occurred during login: $e');
    }
  }
}
