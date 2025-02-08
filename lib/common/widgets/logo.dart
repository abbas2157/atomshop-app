import 'package:atomshop/common/constants/image_constants.dart';
import 'package:flutter/material.dart';

Widget logo ({double? height, double? width}){
  return Image.asset(AppImages.logo, height: height ?? 100, width: width ?? 100);
}
