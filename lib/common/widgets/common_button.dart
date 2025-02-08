import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? icon;

  const CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity, // Full width button
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          // backgroundColor: theme.primaryColor, // Adapt button color to theme
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,style: AppTextStyles.buttonText,
              // style: theme.textTheme, // Get button text style from theme
            ),
            if (icon != null) ...[
              const SizedBox(width: 8), // Space between text & icon
              icon!,
            ],
          ],
        ),
      ),
    );
  }
}
