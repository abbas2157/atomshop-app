import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static TextStyle headline1 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle headline2 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle headline3 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle normal = TextStyle(
  
  );
  static TextStyle hintTextStyle = TextStyle(color: Color(0xFFC0C0C0));

  static TextStyle bodyText1 = TextStyle(
    fontSize: 16,
  );

  static const TextStyle buttonText =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white);

  static TextStyle onBoardTitle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle onBoardDetails = TextStyle(
      fontSize: 14.sp, fontWeight: FontWeight.normal, color: Color(0xFFA2A2A6));
}
