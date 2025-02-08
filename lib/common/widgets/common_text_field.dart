import 'package:atomshop/style/colors/app_colors.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData? icon;
  final bool isPassword;
  final TextEditingController controller;

  ReusableTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.icon,
    required this.isPassword,
    required this.controller,
  });

  bool obsecureText = true; 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.bottom,
          controller: controller,
          obscureText: isPassword,
          cursorColor: Theme.of(context).colorScheme.primary,
          decoration: InputDecoration(
            // labelText: labelText
            hintText: hintText,
      
            hintStyle: AppTextStyles.hintTextStyle,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                  color: AppColors.secondaryLight,
                )),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                  color: Color(0xff1C1B1B),
                )
                // prefixIcon: Icon(icon),
                ),
          )),
    );
  }
}
