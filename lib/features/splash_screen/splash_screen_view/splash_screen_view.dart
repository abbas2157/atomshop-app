import 'dart:async';
import 'package:atomshop/common/widgets/logo.dart';
import 'package:atomshop/features/auth/login/login_view/login_view.dart';
import 'package:atomshop/features/bottom_nav_bar/bottom_nav_bar_view/bottom_nav_bar_view.dart';
import 'package:atomshop/features/home/home_view/home_view.dart';
import 'package:atomshop/features/on_board/on_board_view/on_board_view.dart';
import 'package:atomshop/local_storage/local_storage_methods.dart';
import 'package:atomshop/main.dart';
import 'package:atomshop/routes/routeNames.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Fade-in animation for the logo and text
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();

    // Navigate to the main screen after 3 seconds
    Timer(const Duration(seconds: 4), () {
      /// checking if user is logged in
      String? token = LocalStorageMethods.instance.getUserApiToken();
      if (token != null && token.isNotEmpty) {
        // if user is logged in
        Get.offAllNamed(RouteNames.bottomBarScreen);
      } else {
        // if user is not logged in
        bool isFirstTimeOpen =
            LocalStorageMethods.instance.getisFirstTimeOpen() ?? true;
        Get.offAllNamed(isFirstTimeOpen
            ? RouteNames.onboarding
            : RouteNames.bottomBarScreen);
      }
    });
    LocalStorageMethods.instance.writeisFirstTimeOpen(false);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _fadeAnimation,
              child: logo(height: 200, width: 200),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
