import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/common/widgets/common_text_field.dart';
import 'package:atomshop/features/auth/auth_widget/lable_text.dart';
import 'package:atomshop/features/auth/forgot_password/controller/forget_password_controller.dart';
import 'package:atomshop/features/auth/forgot_password/view/password_created/password_created_view.dart';
import 'package:atomshop/features/auth/login/login_view/login_view.dart';
import 'package:atomshop/features/profile/utils/utils.dart';
import 'package:atomshop/style/colors/app_colors.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({super.key});

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final ForgetPasswordController controller = Get.find();
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;

  void _resetPassword() async {
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      showToastMessage("Please enter your new password.");
      return;
    }

    if (password.length < 8) {
      showToastMessage("Password must be at least 8 characters long.");
      return;
    }

    if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$')
        .hasMatch(password)) {
      showToastMessage(
          "Password must include at least one letter and one number.");
      return;
    }

    if (password != confirmPassword) {
      showToastMessage("Passwords do not match.");
      return;
    }

    isLoading.value = true;
    bool success = await controller.setNewPassword(password);
    isLoading.value = false;

    if (success) {
      showToastMessage("Password has been reset successfully!");
      Get.offAll(() => PasswordCreatedView()); // Redirect to login screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Set New Password"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text("Create a New Password", style: AppTextStyles.headline1),
              const SizedBox(height: 10),
              Text(
                "Your new password should be strong and unique.",
                style: AppTextStyles.bodyText1
                    .copyWith(color: AppColors.appGreyColor),
              ),
              const SizedBox(height: 30),

              /// Password Input
           ReusableTextField(
                    controller: passwordController,
                    labelText: 'New Password',
                    hintText: 'New Password',
                    isPassword: true,
                  ),

              const SizedBox(height: 20),

              /// Confirm Password Input
              ReusableTextField(
                    controller: confirmPasswordController,
                    labelText: 'Confirm Password',
                    hintText: 'Confirm Password',
                    isPassword: true,
                  ),

              const SizedBox(height: 40),

              /// Reset Password Button
              Obx(() => CommonButton(
                    onPressed: () {
                      if (!isLoading.value) {
                        _resetPassword();
                      }
                    },
                    text: isLoading.value ? "Processing..." : "Reset Password",
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
