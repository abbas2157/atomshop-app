import 'package:atomshop/style/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final BoxDecoration? darkBoxDecoration;
  final BoxDecoration? lightBoxDecoration;

  const CustomContainer(
      {super.key,
      required this.child,
      this.darkBoxDecoration,
      this.lightBoxDecoration});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return darkBoxDecoration != null && lightBoxDecoration != null
        ? Container(
            decoration: isDarkMode ? darkBoxDecoration : lightBoxDecoration,
          )
        : Container(
            // padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Color(0xFF212322)
                  : AppColors.secondoryColorWithOpacity, // Background color
              borderRadius: BorderRadius.circular(32),
            ),
            child: child,
          );
  }
}
