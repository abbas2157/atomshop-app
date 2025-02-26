import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/common/widgets/common_text_field.dart';
import 'package:atomshop/extenstion/alignment_extension.dart';
import 'package:atomshop/extenstion/padding_extension.dart';
import 'package:atomshop/features/auth/auth_widget/lable_text.dart';
import 'package:atomshop/features/auth/forget_password/controller/forget_password_controller.dart';
import 'package:atomshop/features/auth/forget_password/widgets/forget_password_widget.dart';
import 'package:atomshop/features/profile/utils/utils.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmailConfirmation extends StatelessWidget {
  EmailConfirmation({super.key});
  final TextEditingController emailController = TextEditingController();
  final controller = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: forgetPasswordFlowAppBar(title: 'Forgot Password', step: '01'),
      body: Column(
        children: [
          Divider(), //
          SizedBox(
            height: 10.h,
          ),
          Column(
            children: [
              Text(
                "Confirmation Email",
                style: AppTextStyles.headline2,
              ).alignTopLeft(),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Enter your email address for verification.",
                style: AppTextStyles.bodyText1.copyWith(color: Colors.grey),
              ).alignTopLeft(),
              SizedBox(
                height: 20.h,
              ),
              lableText("Email").alignTopLeft(),
              SizedBox(
                height: 5.h,
              ),
              ReusableTextField(
                labelText: 'Email',
                hintText: 'Enter your email',
                // icon: Icons.email,
                isPassword: false,
                controller: emailController,
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(
                () => CommonButton(
                    text:
                        controller.isLoading.value ? "Loading..." : "Send OTP",
                    onPressed: controller.isLoading.value
                        ? () {}
                        : () async {
                            if (emailController.text.isEmpty) {
                              showToastMessage("Email is required");
                            }
                            if (!emailController.text.isEmail) {
                              showToastMessage("Invalid email");
                            } else {
                              await controller.sendOTPonEmail(
                                  emailController.text.trim(), false);
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
