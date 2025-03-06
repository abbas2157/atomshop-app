import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/features/auth/login/login_view/login_view.dart';
import 'package:atomshop/features/bottom_nav_bar/bottom_nav_bar_view/bottom_nav_bar_view.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PasswordCreatedView extends StatelessWidget {
  const PasswordCreatedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppConstants.HorizontelPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New Password Set Successfully",
                  style: AppTextStyles.headline1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Congartulations! Your new password has been set successfully. Please proceed to the login screen to verify your account.",
                  style: AppTextStyles.hintTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CommonButton(
                    text: "Login",
                    onPressed: () {
                      
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginScreen()));
                    }),
                    SizedBox(
                      height: 30,
                    ),
                     CommonButton(
                    text: "Home",
                    onPressed: () {
                      Get.offAll(()=>BottomNavPage());
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => LoginScreen()));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
