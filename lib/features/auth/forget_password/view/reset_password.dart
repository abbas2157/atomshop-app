import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/common/widgets/common_text_field.dart';
import 'package:atomshop/extenstion/alignment_extension.dart';
import 'package:atomshop/extenstion/padding_extension.dart';
import 'package:atomshop/features/auth/auth_widget/lable_text.dart';
import 'package:atomshop/features/auth/forget_password/widgets/forget_password_widget.dart';
import 'package:atomshop/features/profile/utils/utils.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/forget_password_controller.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key, required this.userId});
  final String userId ;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final controller = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: forgetPasswordFlowAppBar(title: 'Create Password', step: '03'),
      body: Column(
        children: [
          Divider(), //
          SizedBox(
            height: 10.h,
          ),
          Column(
            children: [
              Text(
                "New Password",
                style: AppTextStyles.headline2,
              ).alignTopLeft(),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Enter your new password and remember it.",
                style: AppTextStyles.bodyText1.copyWith(color: Colors.grey),
              ).alignTopLeft(),
              SizedBox(
                height: 20.h,
              ),
              lableText("Password").alignTopLeft(),
              SizedBox(
                height: 5.h,
              ),
              ReusableTextField(
                labelText: '',
                hintText: 'Enter your password',
                // icon: Icons.email,
                isPassword: true,
                controller: passwordController,
              ),
              SizedBox(
                height: 20.h,
              ),
              lableText("Confirm Password").alignTopLeft(),
              SizedBox(
                height: 5.h,
              ),
              ReusableTextField(
                labelText: '',
                hintText: 'Enter your password',
                // icon: Icons.email,
                isPassword: true,
                controller: confirmPasswordController,
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(
                () => CommonButton(
                    text: controller.isLoading.value ? "Saving..." : "Save",
                    onPressed: controller.isLoading.value
                        ? () {}
                        : () async {
                            if (passwordController.text.isEmpty ||
                                confirmPasswordController.text.isEmpty) {
                              showToastMessage("Fill all fields");
                            }
                            if (passwordController.text.isEmpty !=
                                confirmPasswordController.text.isEmpty) {
                              showToastMessage("Password did not match");
                            } else {
                              await controller.resetPassword(
                                  passwordController.text.trim(), userId);
                            }
                          }),
              ),
            ],
          ).paddingHorizontel(AppConstants.HorizontelPadding),
        ],
      ),
    );
  }
}
