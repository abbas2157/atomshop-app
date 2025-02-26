import 'package:atomshop/extenstion/padding_extension.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';

Row buildStepWidget(String step) {
  return Row(
    children: [
      Text("$step/", style: AppTextStyles.bodyText1),
      Text("03", style: AppTextStyles.bodyText1.copyWith(color: Colors.grey)),
    ],
  );
}

AppBar forgetPasswordFlowAppBar({required String title, required String step}) {
  return AppBar(
    centerTitle: false,
    backgroundColor: Colors.transparent,
    title: Text(
      title,
      style: AppTextStyles.bodyText1,
    ),
    actions: [
      buildStepWidget(step).paddingRight(10),
    ],
  );
}
