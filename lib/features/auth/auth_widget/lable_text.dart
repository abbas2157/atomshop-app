import 'package:atomshop/extenstion/alignment_extension.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';

Widget lableText(String label){
   return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: label,
          style: AppTextStyles.bodyText1,
        ),
        TextSpan(
          text: " *",
          style:AppTextStyles.bodyText1.copyWith(color: Colors.red),
        ),
      ],
    ),
  ).alignTopLeft();
}