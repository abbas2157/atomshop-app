import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/common/widgets/logo.dart';
import 'package:atomshop/extenstion/alignment_extension.dart';
import 'package:atomshop/extenstion/padding_extension.dart';
import 'package:atomshop/features/categories/categories_controller/categories_controller.dart';
import 'package:atomshop/features/categories/view/category_products_view.dart';
import 'package:atomshop/features/featured_products/view/featured_products_widget.dart';
import 'package:atomshop/features/home/widget/slider_widget.dart';
import 'package:atomshop/features/language/controller/language_controller.dart';
import 'package:atomshop/features/language/view/change_language_view.dart';
import 'package:atomshop/features/promotions/view/promotions_view.dart';
import 'package:atomshop/features/search/view/searh_view.dart';
import 'package:atomshop/features/search/widgets/textfield.dart';
import 'package:atomshop/features/top_rated_products/view/top_rated_products_widget.dart';
import 'package:atomshop/style/colors/app_colors.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:shimmer/shimmer.dart';
import '../../bottom_nav_bar/bottom_nav_bar_controller/bottom_nav_bar_controller.dart';
import '../../brands/view/brands_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController();
  final CategoriesController _categoriesController =
      Get.put(CategoriesController());
  final BottomNavController _bottomNavController =
      Get.put(BottomNavController());
  final LanguageController _languageController = Get.put(LanguageController());

  @override
  void initState() {
    super.initState();
    _categoriesController.fetchCategories(); // Fetch categories from API
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: logo(width: 80),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1), // Height of the border
          child: Container(
            color: Colors.grey.shade300, // Border color
            height: 1, // Thickness of the border
          ),
        ),
        // title: Text("AtomShop", style: AppTextStyles.headline1),
        actions: [
          Obx(
            () => IconButton(
              icon: Row(
                children: [
                  Text(
                    _languageController.confirmedLanguage.value ==
                            Language.English
                        ? "English"
                        : "اردو",
                    style: AppTextStyles.bodyText1
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
              onPressed: () {
                Get.to(() => ChangeLanguageView());
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              SearchTextField(
                onTap: () {
                  Get.to(() => SearchView());
                },
                readOnly: true,
                controller: TextEditingController(),
              ).paddingHorizontel(AppConstants.HorizontelPadding),
              SizedBox(
                height: 10.h,
              ),
              const HomePageSliderWidget(),
              SizedBox(
                height: 10.h,
              ),
              //  _buildTagAndSeeAllButton(context),

              // Categories Grid

              _homePageCategories(isDarkMode)
                  .paddingHorizontel(AppConstants.HorizontelPadding),

              // Latest Products Section
              Text("Featured Products", style: AppTextStyles.headline3)
                  .alignTopLeft()
                  .paddingHorizontel(AppConstants.HorizontelPadding),
              SizedBox(
                height: 5.h,
              ),
              FeaturedProductsWidget()
                  .paddingHorizontel(AppConstants.HorizontelPadding),
              SizedBox(
                height: 10.h,
              ),
              //// promotions
              PromotionsView(),
              SizedBox(
                height: 10.h,
              ),
              Text("Top Rated Products", style: AppTextStyles.headline3)
                  .alignTopLeft()
                  .paddingHorizontel(AppConstants.HorizontelPadding),
              SizedBox(
                height: 5.h,
              ),

              /// top rated products section
              TopRatedProductsWidget()
                  .paddingHorizontel(AppConstants.HorizontelPadding),
              SizedBox(
                height: 10.h,
              ),
              Text("Brands", style: AppTextStyles.headline3)
                  .alignTopLeft()
                  .paddingHorizontel(AppConstants.HorizontelPadding),
              SizedBox(
                height: 5.h,
              ),
              BrandsView(),
              SizedBox(
                height: 20.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  Obx _homePageCategories(bool isDarkMode) {
    return Obx(
      () {
        if (_categoriesController.isLoading.value) {
          return _buildShimmerGrid();
        }
        if (_categoriesController.errorMessage.isNotEmpty) {
          return Center(child: Text(_categoriesController.errorMessage.value));
        }
        return SizedBox(
          height: Get.height * 0.15, // Responsive height (15% of screen height)
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // padding: EdgeInsets.symmetric(
            //     horizontal: Get.width * 0.03), // Responsive padding
            // itemCount: _categoriesController.categories.length > 4
            //     ? 4
            //     : _categoriesController.categories.length,
            itemCount: _categoriesController.categories.length,
            itemBuilder: (context, index) {
              final category = _categoriesController.categories[index];

              return InkWell(
                onTap: () {
                  Get.to(() => CategoryProductsView(
                      id: category.id.toString(),
                      name: category.title.toString()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: Colors.white,
                      elevation:
                          0, // Slightly stronger shadow for a richer look
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppConstants.fieldsBorderRadius), // Rounded corners
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(Get.width *
                            0.03), // Responsive padding inside the card
                        child: Image.network(
                          category.picture ?? "",
                          height: Get.height *
                              0.07, // Bigger image (7% of screen height)
                          width: Get.height *
                              0.07, // Keeping width equal to height
                          fit: BoxFit.cover, // Ensures image scales properly
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported,
                                  size: 50, color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(
                        height:
                            Get.height * 0.007), // Spacing between image & text
                    SizedBox(
                      width: Get.width *
                          0.2, // Responsive width to prevent text overflow
                      child: Text(
                        category.title ?? "",
                        style: TextStyle(
                          fontSize: Get.width * 0.035, // Responsive font size
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  /// Shimmer Effect for GridView
  Widget _buildShimmerGrid() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: 4, // Show 4 shimmer placeholders
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
