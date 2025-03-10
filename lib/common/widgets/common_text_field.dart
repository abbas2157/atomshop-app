import 'package:atomshop/style/colors/app_colors.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';

class ReusableTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final IconData? icon;
  final bool isPassword;
  final TextEditingController controller;

  const ReusableTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.icon,
    required this.isPassword,
    required this.controller,
  });

  @override
  State<ReusableTextField> createState() => _ReusableTextFieldState();
}

class _ReusableTextFieldState extends State<ReusableTextField> {
  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
          textAlignVertical: TextAlignVertical.bottom,
          controller: widget.controller,
          obscureText: widget.isPassword&& obsecureText,
          cursorColor: Theme.of(context).colorScheme.primary,
          decoration: InputDecoration(
            suffixIcon: widget.isPassword ? InkWell(
              onTap: () {
                setState(() {
                  obsecureText = !obsecureText;
                });
              },
              child: Icon(
                obsecureText
                    ? Icons.visibility_off
                    : Icons.visibility, // 👈 Updated Icons
                color:
                    Colors.grey.shade600, // 👈 Light grey color for better UI
              ),
            ): null,
            // labelText: labelText
            hintText: widget.hintText,

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
