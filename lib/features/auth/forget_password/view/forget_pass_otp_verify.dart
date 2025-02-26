import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/extenstion/alignment_extension.dart';
import 'package:atomshop/extenstion/padding_extension.dart';
import 'package:atomshop/features/auth/forget_password/controller/forget_password_controller.dart';
import 'package:atomshop/features/auth/forget_password/widgets/forget_password_widget.dart';
import 'package:atomshop/features/profile/utils/utils.dart';
import 'package:atomshop/style/colors/app_colors.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgetPassOtpVerify extends StatelessWidget {
  ForgetPassOtpVerify(
      {super.key, required this.uuid, required this.email, required this.otp});
  final String uuid;
  final String otp;
  final String email;
  final TextEditingController otpController = TextEditingController();
  final controller = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: forgetPasswordFlowAppBar(title: 'Forgot Password', step: '02'),
      body: Column(
        children: [
          Divider(), //
          SizedBox(
            height: 10.h,
          ),
          Column(
            children: [
              Text(
                "Email Verification",
                style: AppTextStyles.headline2,
              ).alignTopLeft(),
              SizedBox(
                height: 10.h,
              ),
              Text.rich(
                TextSpan(
                    text: "Enter the 4-digit verification code send to ",
                    style: AppTextStyles.bodyText1.copyWith(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: "$email.",
                        style: AppTextStyles.bodyText1
                            .copyWith(color: AppColors.secondaryLight),
                      )
                    ]),
              ).alignTopLeft(),
              SizedBox(
                height: 30.h,
              ),
              PinCodeTextField(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                appContext: context,

                pastedTextStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                length: 4,
                obscureText: true,
                obscuringCharacter: '*',
                // obscuringWidget: const FlutterLogo(
                //   size: 24,
                // ),
                // obscuringWidget: Text("*"),
                blinkWhenObscuring: true,
                animationType: AnimationType.scale,
                autoFocus: true,
                pinTheme: PinTheme(
                  //  errorBorderColor: Colors.black,
                  selectedFillColor: Colors.white,
                  activeColor: AppColors.secondaryDark,
                  selectedColor: AppColors.secondaryDark,
                  inactiveColor: Colors.grey,
                  inactiveFillColor: Colors.white,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeFillColor: Colors.white,
                ),
                cursorColor: Colors.black,
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                // errorAnimationController: errorController,
                controller: otpController,
                keyboardType: TextInputType.number,
                boxShadows: const [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
                onCompleted: (v) async {},
                onTap: () {
                  // print("Pressed");
                },
                onChanged: (value) {},

                beforeTextPaste: (text) {
                  //  debugPrint("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {},
                child: Text("Resend Code",
                    style: AppTextStyles.bodyText1.copyWith(
                      color: AppColors.secondaryDark,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(
                () => CommonButton(
                    text: controller.isLoading.value
                        ? "Processing..."
                        : "Proceed",
                    onPressed: () async {
                      await controller.verifyOTP(uuid, otpController.text);
                    }),
              ),
              SizedBox(
                height: 50,
              ),
              TextButton(
                  onPressed: () {
                    showToastMessage(otp, gravity: ToastGravity.TOP);
                  },
                  child: Text("tap to see otp"))
            ],
          ).paddingHorizontel(AppConstants.HorizontelPadding),
        ],
      ),
    );
  }
}
