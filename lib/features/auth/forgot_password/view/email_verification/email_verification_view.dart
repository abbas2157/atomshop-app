import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/extenstion/alignment_extension.dart';
import 'package:atomshop/features/auth/forgot_password/controller/forget_password_controller.dart';
import 'package:atomshop/features/auth/forgot_password/view/new_password/new_password_view.dart';
import 'package:atomshop/features/profile/utils/utils.dart';
import 'package:atomshop/style/colors/app_colors.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:pin_code_fields/pin_code_fields.dart';

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({super.key});

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  final TextEditingController otpController = TextEditingController();
  final RxBool isLoading = false.obs;
  RxInt otpTimer = 90.obs;
  RxInt resendTimer = 90.obs;
  Timer? otpCountdown;
  Timer? resendCountdown;
  RxBool isOtpExpired = false.obs;
  final controller = Get.find<ForgetPasswordController>();

  @override
  void initState() {
    super.initState();
    startOtpTimer();
    startResendTimer();
  }

  @override
  void dispose() {
    otpCountdown?.cancel();
    resendCountdown?.cancel();
    super.dispose();
  }

  void startOtpTimer() {
    otpCountdown = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpTimer.value > 0) {
        otpTimer.value--;
      } else {
        isOtpExpired.value = true;
        otpCountdown?.cancel();
      }
    });
  }

  void startResendTimer() {
    resendCountdown = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        resendCountdown?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Forgot Password"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              const SizedBox(height: 20),
              Text("Email Verification", style: AppTextStyles.headline1),
              const SizedBox(height: 10),
              Text(
                "Enter the 4-digit verification code sent to your email.",
                style: AppTextStyles.bodyText1.copyWith(
                  color: AppColors.appGreyColor,
                ),
              ),
              const SizedBox(height: 30),

              /// OTP Input
              Obx(() => PinCodeTextField(
                    mainAxisAlignment: MainAxisAlignment.center,
                    controller: otpController,
                    appContext: context,
                    length: 4,
                    keyboardType: TextInputType.number,
                    textStyle: AppTextStyles.headline3.copyWith(
                      color:
                          isOtpExpired.value ? Colors.red : AppColors.textLight,
                    ),
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      fieldOuterPadding: EdgeInsets.symmetric(horizontal: 10),
                      activeColor: isOtpExpired.value
                          ? Colors.red
                          : AppColors.appGreyColor,
                      selectedColor: AppColors.secondaryLight,
                      inactiveColor: AppColors.appGreyColor,
                    ),
                  )),

              const SizedBox(height: 10),

              /// OTP Expiration Warning
              Obx(() => Text(
                    isOtpExpired.value
                        ? "OTP Expired! Request a new code."
                        : "",
                    style: AppTextStyles.bodyText1.copyWith(
                      color: isOtpExpired.value
                          ? Colors.red
                          : AppColors.appGreyColor,
                    ),
                  ).alignCenter()),

              const SizedBox(height: 20),

              /// Resend Code Button
              Obx(() => TextButton(
                    onPressed: resendTimer.value > 0
                        ? null
                        : () {
                            resendCode();
                          },
                    child: Text(
                      resendTimer.value > 0
                          ? "Resend Code in ${resendTimer.value}s"
                          : "Resend Code",
                      style: AppTextStyles.bodyText1.copyWith(
                        color: resendTimer.value > 0
                            ? AppColors.appGreyColor
                            : AppColors.secondaryLight,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ).alignCenter()),

              const SizedBox(height: 20),

              /// Verify Button
              Obx(() => CommonButton(
                    onPressed: () {
                      if (isOtpExpired.value || isLoading.value) {
                      } else {
                        _verifyOTP();
                      }
                    },
                    text: isLoading.value ? "Processing..." : "Proceed",
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _verifyOTP() async {
    if (isOtpExpired.value) {
      showToastMessage("Your OTP has expired! Please request a new one.");
      return;
    }

    if (otpController.text.length != 4) {
      showToastMessage("Enter a complete 4-digit verification code!");
      return;
    }

    isLoading.value = true;
    bool success = await controller.verifyOTP(otpController.text);
    isLoading.value = false;

    if (success) {
      Get.to(() => NewPasswordView());
    }
  }

  void resendCode() {
    isOtpExpired.value = false;
    otpTimer.value = 90;
    resendTimer.value = 90;

    startOtpTimer();
    startResendTimer();
    showToastMessage("A new OTP has been sent to your email.");
  }
}
