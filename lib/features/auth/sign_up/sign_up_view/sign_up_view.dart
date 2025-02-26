import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/common/widgets/common_text_field.dart';
import 'package:atomshop/common/widgets/logo.dart';
import 'package:atomshop/features/auth/auth_widget/lable_text.dart';
import 'package:atomshop/features/auth/auth_widget/terms_and_condi.dart';
import 'package:atomshop/features/auth/sign_up/sign_up_controller/sign_up_controller.dart';
import 'package:atomshop/main.dart';
import 'package:atomshop/style/colors/app_colors.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: AppConstants.HorizontelPadding),
        child: SingleChildScrollView(
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            //  crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              logo(height: 150, width: 150),
              Text("Signup", style: AppTextStyles.headline1),
              SizedBox(
                height: 20.h,
              ),
              lableText("Full Name"),
              SizedBox(
                height: 5.h,
              ),
              ReusableTextField(
                labelText: 'Name',
                hintText: 'Enter your name',
                isPassword: false,
                controller: nameController,
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
                height: 20.h,
              ),
              lableText("Password"),
              SizedBox(
                height: 5.h,
              ),
              ReusableTextField(
                labelText: 'Password',
                hintText: 'Enter your password',
                icon: Icons.lock,
                isPassword: true,
                controller: passwordController,
              ),
              SizedBox(
                height: 20.h,
              ),
              lableText("Confirm Password"),
              SizedBox(
                height: 5.h,
              ),
              ReusableTextField(
                labelText: 'Confirm Password',
                hintText: 'Re-enter your password',
                icon: Icons.lock,
                isPassword: true,
                controller: confirmPasswordController,
              ),
              SizedBox(height: 30.h),
              CommonButton(
                  text: "Create Account",
                  onPressed: () {
                    final name = nameController.text.trim();
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    final confirmPassword =
                        confirmPasswordController.text.trim();

                    if (name.isEmpty ||
                        email.isEmpty ||
                        password.isEmpty ||
                        confirmPassword.isEmpty) {
                      _showErrorDialog(context, 'All fields are required!');
                      return;
                    }

                    if (password.length < 6) {
                      _showErrorDialog(context,
                          'Password must be at least 6 characters long!');
                      return;
                    }

                    if (password != confirmPassword) {
                      _showErrorDialog(context, 'Passwords do not match!');
                      return;
                    }

                    // Perform signup logic here
                    debugPrint('Name: $name');
                    debugPrint('Email: $email');
                    debugPrint('Password: $password');
                    controller.signup(name, email, password, confirmPassword);
                  }),
               SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: AppTextStyles.bodyText1.copyWith(
                      color: AppColors.appGreyColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to signup screen using GetX
                      Get.back();
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: AppColors.secondaryLight),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              TermsAndCondition(
                text: "signup",
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

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
