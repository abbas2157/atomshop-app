import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/common/constants/image_constants.dart';
import 'package:atomshop/common/widgets/build_svg_asset_image.dart';
import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/common/widgets/common_container.dart';
import 'package:atomshop/common/widgets/logo.dart';
import 'package:atomshop/features/auth/login/login_view/login_view.dart';
import 'package:atomshop/features/bottom_nav_bar/bottom_nav_bar_view/bottom_nav_bar_view.dart';
import 'package:atomshop/features/on_board/on_board_strings.dart';
import 'package:atomshop/local_storage/local_storage_methods.dart';
import 'package:atomshop/main.dart';
import 'package:atomshop/routes/routeNames.dart';
import 'package:atomshop/style/colors/app_colors.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:atomshop/style/theme/theme_controller/theme_controller.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({super.key});

  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

class _OnBoardViewState extends State<OnBoardView> {
  final PageController _pageController = PageController(initialPage: 0);

  final List<Widget> _pages = [
    Page(
      image: AppImages.intro1,
      title: title1,
      detail: detail1,
    ),
    Page(
      image: AppImages.intro2,
      title: title2,
      detail: detail2,
    ),
    Page(
      image: AppImages.intro3,
      title: title3,
      detail: detail3,
    ),
  ];

  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppConstants.HorizontelPadding),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _activePage = page;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _pages[index % _pages.length];
                  },
                ),
              ),
              ThemeSwitch(),
              CommonButton(
                text: _activePage != 2 ? "Next" : "Get Started ",
                onPressed: () {
                  if (_activePage != 2) {
                    _pageController.animateToPage(_activePage + 1,
                        duration: Duration(seconds: 1), curve: Curves.ease);
                    _activePage = _activePage + 1;
                    setState(() {});
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavPage(),
                        ));
                  }
                },
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              DotsIndicator(
                decorator: DotsDecorator(activeColor: AppColors.secondaryLight),
                dotsCount: _pages.length,
                position: _activePage,
              ),
              SizedBox(
                height: 50.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Page extends StatelessWidget {
  const Page({
    super.key,
    required this.image,
    required this.detail,
    required this.title,
    this.showSkipButton = true,
  });

  final String title;
  final String detail;
  final String image;
  final bool showSkipButton;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        CustomContainer(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  logo(),
                  if (showSkipButton)
                    TextButton(
                        onPressed: () {
                          Get.offAllNamed(RouteNames.bottomBarScreen);
                        },
                        child: Text("Skip for now",
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: AppColors.secondaryLight,
                            ) // Ensure proper text styling
                            )),
                ],
              ),
              buildAssetImage(image),
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          title,
          style: AppTextStyles.onBoardTitle,
          textAlign: TextAlign.center, // Use theme styling
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          detail,
          style: AppTextStyles.onBoardDetails,
          textAlign: TextAlign.center, // Use theme styling
// Use theme styling
        ),
      ],
    );
  }
}
