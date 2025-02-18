// Main Page with Bottom Navigation Bar
import 'package:atomshop/common/constants/image_constants.dart';
import 'package:atomshop/features/bottom_nav_bar/bottom_nav_bar_controller/bottom_nav_bar_controller.dart';
import 'package:atomshop/features/categories/view/categories_view.dart';
import 'package:atomshop/features/home/home_view/home_view.dart';
import 'package:atomshop/features/product_detail/myCart/my_cart_screen.dart';
import 'package:atomshop/style/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavPage extends StatelessWidget {
  BottomNavPage({super.key});
  final BottomNavController _controller = Get.put(BottomNavController());

  // List of Pages
  final List<Widget> _pages = [
    MyHomePage(),
    CategoriesView(),
    CartScreen(),
    OrdersPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                  icon: Image.asset(
                    color: _controller.currentIndex.value == 2
                        ? AppColors.secondaryDark
                        : null,
                    AppImages.mycart,
                    height: 24,
                    width: 24,
                  ),
                  label: "My Cart"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    color: _controller.currentIndex.value == 3
                        ? AppColors.secondaryDark
                        : null,
                    AppImages.whishlist,
                    height: 24,
                    width: 24,
                  ),
                  label: "Wishlist"),
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

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Cart Page"));
  }
}

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Orders Page"));
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Profile Page"));
  }
}
