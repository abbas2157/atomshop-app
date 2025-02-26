import 'package:atomshop/common/constants/image_constants.dart';
import 'package:atomshop/common/widgets/build_svg_asset_image.dart';
import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/common/widgets/common_container.dart';
import 'package:atomshop/extenstion/padding_extension.dart';
import 'package:atomshop/features/auth/login/login_view/login_view.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PasswordResetSuccess extends StatelessWidget {
  const PasswordResetSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomContainer(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(64.0),
                    child: buildAssetImage(AppImages.resetSuccess),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            "New password set successfully",
            style: AppTextStyles.headline2,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Congratulations! Your password has been set successfully. Please proceed to the login screen to verify your account.",
            style: AppTextStyles.bodyText1.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30.h,
          ),
          CommonButton(
              text: "Login",
              onPressed: () {
                Get.offAll(() => LoginScreen());
              }).paddingHorizontel(16),
        ],
      )),
    );
  }
}
