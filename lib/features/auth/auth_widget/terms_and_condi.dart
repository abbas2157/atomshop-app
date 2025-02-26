import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({
    super.key,
    required this.text
  });
  final String text ;
  @override
  Widget build(BuildContext context) {
        final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style:AppTextStyles.bodyText1,
        children: <TextSpan>[
          TextSpan(
            text:
                "By $text , you agree to our ",style: AppTextStyles.bodyText1.copyWith(color: textColor)
          ),
          TextSpan(
            text: "Privacy Policy",style:AppTextStyles.bodyText1.copyWith(color: Color(0xff1F8BDA)),
          ),
           TextSpan(
            text:
                " and ",style: AppTextStyles.bodyText1.copyWith(color: textColor)
          ),
            TextSpan(
            text: "Terms & Conditions.",style: AppTextStyles.bodyText1.copyWith(color: Color(0xff1F8BDA)),
          ),
        ],
      ),
    ).paddingAll(10);
  }
}

