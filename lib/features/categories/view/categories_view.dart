import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/extenstion/alignment_extension.dart';
import 'package:atomshop/extenstion/padding_extension.dart';
import 'package:atomshop/features/categories/model/category_model.dart';
import 'package:atomshop/style/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Column(
        children: [
          Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ).alignTopLeft(),
          SizedBox(
            height: 10,
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(), // Prevents scrolling conflict
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items per row
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2, // Adjust height-to-width ratio
            ),
            itemCount: categories.length, // Replace with your product list
            itemBuilder: (context, index) {
              final category = categories[index]; // Get product item
              return Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        isDarkMode ? AppColors.appGreyColor : Color(0xffF4F5FD),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      category.image,
                      height: 40,
                      width: 40,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(category.name)
                  ],
                ),
              );
            },
          ),
        ],
      ).paddingHorizontel(AppConstants.HorizontelPadding),
    );
  }
}
