import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/common/widgets/common_text_field.dart';
import 'package:atomshop/features/auth/auth_widget/lable_text.dart';
import 'package:atomshop/features/auth/forgot_password/controller/forget_password_controller.dart';
import 'package:atomshop/features/auth/forgot_password/view/email_verification/email_verification_view.dart';
import 'package:atomshop/features/profile_feature/utils/utils.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ConfirmationEmailView extends StatelessWidget {
  ConfirmationEmailView({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppConstants.HorizontelPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back)),
                  title: Text("Forgot Password"),
                ),
                Divider(),
                SizedBox(
                  height: 20.h,
                ),
                Text("Confirmation Email", style: AppTextStyles.headline1),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Enter your email for verification",
                  style: AppTextStyles.hintTextStyle,
                ),
                SizedBox(
                  height: 20.h,
                ),
                lableText("Email"),
                SizedBox(
                  height: 5.h,
                ),
                ReusableTextField(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  icon: Icons.email,
                  isPassword: false,
                  controller: emailController,
                ),
                SizedBox(
                  height: 30.h,
                ),
                CommonButton(
                    text: "Send",
                    onPressed: () async {
                      final email = emailController.text.trim();
                      if (email.isEmpty) {
                        showToastMessage(
                          'Email required!',
                        );
                        return;
                      } else if (!email.isEmail) {
                        showToastMessage(
                          'Invalid email!',
                        );
                      } else {
                        final controller = Get.put(ForgetPasswordController());
                        bool result = await controller.sendOtpToEmail(email);
                        if (result) {
                          Get.to(() => EmailVerificationView());
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
