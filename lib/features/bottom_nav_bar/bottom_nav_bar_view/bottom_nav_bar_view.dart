// Main Page with Bottom Navigation Bar
import 'package:atomshop/common/constants/image_constants.dart';
import 'package:atomshop/features/bottom_nav_bar/bottom_nav_bar_controller/bottom_nav_bar_controller.dart';
import 'package:atomshop/features/cart/cart_view/cart_view.dart';
import 'package:atomshop/features/cart/controller/cart_controller.dart';
import 'package:atomshop/features/categories/view/categories_view.dart';
import 'package:atomshop/features/home/home_view/home_view.dart';
import 'package:atomshop/features/wish_list/controller/wishlist_controller.dart';
import 'package:atomshop/features/wish_list/view/wish_list_view.dart';
import 'package:atomshop/style/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import '../../profile_feature/view/profile_main.dart';

class BottomNavPage extends StatelessWidget {
  BottomNavPage({super.key});
  final BottomNavController _controller = Get.put(BottomNavController());
  final CartController _cartController = Get.put(CartController());
  final WishlistController _wishController = Get.put(WishlistController());

  // List of Pages
  final List<Widget> _pages = [
    MyHomePage(),
    CategoriesView(),
    WishListView(),
    CartView(),
    ProfileMain(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    _cartController.getCount();

    return Scaffold(
      body: Obx(() => _pages[_controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
              color: isDarkMode ? Color(0xFF282828) : Color(0xFFF4F5FD),
            )),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            currentIndex: _controller.currentIndex.value,
            onTap: _controller.changePage,
            // selectedItemColor: Colors.black,
            unselectedItemColor: AppColors.appGreyColor,
            type: BottomNavigationBarType.fixed,
            // selectedLabelStyle: isDarkMode ? TextStyle(color: Colors.white): TextStyle(),
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    color: _controller.currentIndex.value == 0
                        ? AppColors.secondaryDark
                        : null,
                    AppImages.home,
                    height: 24,
                    width: 24,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    color: _controller.currentIndex.value == 1
                        ? AppColors.secondaryDark
                        : null,
                    AppImages.categories,
                    height: 24,
                    width: 24,
                  ),
                  label: "Categories"),
              BottomNavigationBarItem(
                  icon: badges.Badge(
                    // position: badges.BadgePosition.topEnd(top: 0, end: 0),
                    badgeAnimation: badges.BadgeAnimation.slide(),
                    showBadge: _wishController.showWishBadge.value,
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: Colors.red,
                    ),
                    badgeContent: Text(
                      _wishController.wishCount.value.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Image.asset(
                      color: _controller.currentIndex.value == 2
                          ? AppColors.secondaryDark
                          : null,
                      AppImages.whishlist,
                      height: 24,
                      width: 24,
                    ),
                  ),
                  label: "Wishlist"),
              BottomNavigationBarItem(
                  icon: badges.Badge(
                    // position: badges.BadgePosition.topEnd(top: 0, end: 0),
                    badgeAnimation: badges.BadgeAnimation.slide(),
                    showBadge: _cartController.showCartBadge.value,
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: Colors.red,
                    ),
                    badgeContent: Text(
                      _cartController.cartCount.value.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Image.asset(
                      color: _controller.currentIndex.value == 3
                          ? AppColors.secondaryDark
                          : null,
                      AppImages.mycart,
                      height: 24,
                      width: 24,
                    ),
                  ),
                  label: "My Cart"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    color: _controller.currentIndex.value == 4
                        ? AppColors.secondaryDark
                        : null,
                    AppImages.profile,
                    height: 24,
                    width: 24,
                  ),
                  label: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}
