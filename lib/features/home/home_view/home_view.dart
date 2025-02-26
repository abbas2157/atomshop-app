import 'package:atomshop/features/categories/categories_controller/categories_controller.dart';
import 'package:atomshop/features/featured_products/view/featured_products_widget.dart';
import 'package:atomshop/features/home/widget/slider_widget.dart';
import 'package:atomshop/features/profile_feature/view/profile_main.dart';
import 'package:atomshop/main.dart';
import 'package:atomshop/style/colors/app_colors.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../bottom_nav_bar/bottom_nav_bar_controller/bottom_nav_bar_controller.dart';

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
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Sliver AppBar
            SliverAppBar(
              floating: true,
              pinned: false,
              elevation: 0,
              backgroundColor: Colors.transparent,
              forceMaterialTransparency: true,
              title: Row(
                children: [
                  Text("AtomShop", style: AppTextStyles.headline1),
                  ThemeSwitch(),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileMain()));
                    },
                    icon: const Icon(Icons.person),
                  ),

                  //const CircleAvatar(child: Icon(Icons.person)),
                ],
              ),
            ),

            // Carousel
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child:
                    const HomePageSliderWidget(), // Use the dynamic slider here
              ),
            ),

            // Categories Section
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Categories", style: AppTextStyles.headline2),
                    TextButton(
                      onPressed: () {
                        _bottomNavController.changePage(1);
                      },
                      child: Text(
                        "View All",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.secondaryLight,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Categories Grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: Obx(() {
                if (_categoriesController.isLoading.value) {
                  return SliverToBoxAdapter(child: _buildShimmerGrid());
                }
                if (_categoriesController.errorMessage.isNotEmpty) {
                  return SliverToBoxAdapter(
                      child: Center(
                          child:
                              Text(_categoriesController.errorMessage.value)));
                }
                return SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final category = _categoriesController.categories[index];
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDarkMode
                                ? AppColors.appGreyColor
                                : Color(0xffF4F5FD),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              category.categoryPicture ?? "",
                              height: 40,
                              width: 40,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.image_not_supported, size: 40),
                            ),
                            SizedBox(height: 5),
                            SizedBox(
                              width: 60, // Adjust width to prevent overflow
                              child: Text(
                                category.title ?? "",
                                style: TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: _categoriesController.categories.length > 4
                        ? 4
                        : _categoriesController.categories.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                );
              }),
            ),

            // Latest Products Section
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Featured Products", style: AppTextStyles.headline2),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: Text(
                    //     "See All",
                    //     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    //         color: AppColors.secondaryLight,
                    //         fontWeight: FontWeight.w600),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              sliver: SliverToBoxAdapter(
                child: FeaturedProductsWidget(),
              ),
            ),
          ],
        ),
      ),
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
