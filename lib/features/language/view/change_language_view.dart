// ignore_for_file: deprecated_member_use

import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/common/widgets/logo.dart';
import 'package:atomshop/extenstion/alignment_extension.dart';
import 'package:atomshop/extenstion/padding_extension.dart';
import 'package:atomshop/features/language/controller/language_controller.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class ChangeLanguageView extends StatelessWidget {
  const ChangeLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController controller = Get.put(LanguageController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.cancel_outlined),
              ),
            ),
            logo(height: 200, width: 200),
            Text(
              "Welcome",
              style: AppTextStyles.headline1,
            ),
            const SizedBox(height: 10),
            Text(
              "Please select language",
              style: AppTextStyles.bodyText1.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // Attractive Language Selection in Row
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: Language.values.map((lang) {
                    bool isSelected = controller.selectedLanguage.value == lang;
                    return GestureDetector(
                      onTap: () => controller.selectLanguage(lang),
                      child: Container(
                        width: 140,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        //   margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.green : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: isSelected ? Colors.green : Colors.grey,
                              width: 2),
                          boxShadow: [
                            if (isSelected)
                              BoxShadow(
                                color: Colors.green.withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              lang == Language.English
                                  ? Icons.language
                                  : Icons.translate,
                              color: isSelected ? Colors.white : Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              lang == Language.English ? "English" : "اردو",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ).paddingHorizontel(AppConstants.HorizontelPadding + 10)),

            const SizedBox(height: 50),

            // Apply language only when pressing "Continue"
            CommonButton(
              text: "Continue",
              onPressed: () {
                controller.applyLanguage();
                Get.back();
              },
            ).paddingHorizontel(AppConstants.HorizontelPadding + 10),

            const SizedBox(height: 20),

            // Display selected language
          ],
        ),
      ),
    );
  }
}
