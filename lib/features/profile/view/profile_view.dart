import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/common/constants/image_constants.dart';
import 'package:atomshop/common/utils/app_utils.dart';
import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/features/profile/utils/utils.dart';
import 'package:atomshop/local_storage/local_storage_methods.dart';
import 'package:atomshop/routes/routeNames.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isUserLoggedIn = AppUtils.isUserLoggedIn();
    return Center(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: AppConstants.HorizontelPadding),
        child: isUserLoggedIn
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person),
                  ),
                  SizedBox(height: 20),
                  Text(
                    LocalStorageMethods.instance.getUserName() ?? "",
                    style: AppTextStyles.headline1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  CommonButton(
                    text: "Logout",
                    onPressed: () async {
                      showLogoutDialog(context, () async {
                        await LocalStorageMethods.instance.clearLocalStorage();
                        Get.offAllNamed(RouteNames.login);
                      });
                    },
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages
                        .profilePlaceholder, // Change to a profile-related image
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Welcome to AtomShop!",
                    style: AppTextStyles.headline1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Sign in to save your favorite items, track orders, and get personalized recommendations.",
                    style: AppTextStyles.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  CommonButton(
                    text: "Login",
                    onPressed: () {
                      Get.toNamed(RouteNames.login);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to Login Page
                      // );
                    },
                  ),
                  SizedBox(height: 15),
                ],
              ),
      ),
    );
  }
}
