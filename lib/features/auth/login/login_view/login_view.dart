import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/common/widgets/common_text_field.dart';
import 'package:atomshop/common/widgets/logo.dart';
import 'package:atomshop/extenstion/alignment_extension.dart';
import 'package:atomshop/features/auth/auth_widget/terms_and_condi.dart';
import 'package:atomshop/features/auth/auth_widget/lable_text.dart';
import 'package:atomshop/features/auth/forget_password/view/email_confirmation.dart';
import 'package:atomshop/features/auth/login/login_controller/login_controller.dart';
import 'package:atomshop/features/auth/sign_up/sign_up_view/sign_up_view.dart';
import 'package:atomshop/main.dart';
import 'package:atomshop/style/colors/app_colors.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:atomshop/style/theme/theme_controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final controller = Get.put(LoginController());
  final ThemeController _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppConstants.HorizontelPadding),
          child: Column(
            //  spacing: 20,
            //  mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 0.h,
              ),
              logo(height: 150, width: 150),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     ThemeSwitch()
              //   ],
              // ),
              Text("Login", style: AppTextStyles.headline1),

              SizedBox(
                height: 50.h,
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
              //   const SizedBox(height: 16),
              // Reusable Text Field for Password
              SizedBox(
                height: 20.h,
              ),

              lableText("Password").alignTopLeft(),
              SizedBox(
                height: 5.h,
              ),

              ReusableTextField(
                labelText: 'Password',
                hintText: 'Enter your password',
                // icon: Icons.lock,
                isPassword: true,
                controller: passwordController,
              ),
              //  const SizedBox(height: 16),
              SizedBox(
                height: 5.h,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Navigate to forgot password screen
                    // Implement your Forgot Password logic here
                    // Implement your Sign Up logic here
                    Get.to(() => EmailConfirmation());
                  },
                  child: Text(
                    'Forgot Password?',
                    style: AppTextStyles.bodyText1
                        .copyWith(color: AppColors.secondaryLight),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              //  const SizedBox(height: 24),
              CommonButton(
                  text: "Login",
                  onPressed: () {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    // Perform login logic here
                    debugPrint('Email: $email');
                    debugPrint('Password: $password');
                    controller.login(email, password);
                  }),

              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account ?',
                    style: AppTextStyles.bodyText1.copyWith(
                      color: AppColors.appGreyColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to signup screen using GetX
                      Get.to(() => SignupScreen());
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: AppColors.secondaryLight),
                    ),
                  ),
                ],
              ),
              Spacer(),
              TermsAndCondition(
                text: "login",
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
