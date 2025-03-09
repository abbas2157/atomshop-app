import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/common/widgets/common_text_field.dart';
import 'package:atomshop/features/auth/change_password/controller/change_pass_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  final ChangePasswordController controller = Get.put(ChangePasswordController());

  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Password"),backgroundColor: Colors.transparent,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              /// **Current Password**
              ReusableTextField(
                labelText: "Current Password",
                hintText: "Enter your current password",
                isPassword: true,
                controller: controller.currentPasswordController,
              ),
              const SizedBox(height: 16),

              /// **New Password**
              ReusableTextField(
                labelText: "New Password",
                hintText: "Enter your new password",
                isPassword: true,
                controller: controller.newPasswordController,
              ),
              const SizedBox(height: 16),

              /// **Confirm New Password**
              ReusableTextField(
                labelText: "Confirm New Password",
                hintText: "Re-enter your new password",
                isPassword: true,
                controller: controller.confirmPasswordController,
              ),
              const SizedBox(height: 24),

              /// **Change Password Button**
              Obx(() => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : CommonButton(
                      text: "Change Password",
                      onPressed: controller.changePassword,
                    )),
            ],
          ),
        ),
      ),
    );
  }
}