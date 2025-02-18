import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/common/constants/image_constants.dart';
import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/extenstion/padding_extension.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';

class WishListView extends StatelessWidget {
  const WishListView({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.emptyCart,
            height: 200,
            width: 200,
          ),
          Text(
            "Your wishlist is empty",
            style: AppTextStyles.headline1,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Tap heart button to start saving your favorite items.",
            style: AppTextStyles.bodyText1,
            textAlign: TextAlign.center,
          ),
            SizedBox(
            height: 40,
          ),
          CommonButton(text: "Explore Categories", onPressed: () {}),
        ],
      ).paddingHorizontel(AppConstants.HorizontelPadding),
    );
  }
}