

import 'package:atomshop/features/auth/login/login_view/login_view.dart';
import 'package:atomshop/features/bottom_nav_bar/bottom_nav_bar_view/bottom_nav_bar_view.dart';
import 'package:atomshop/features/splash_screen/splash_screen_view/splash_screen_view.dart';
import 'package:atomshop/routes/routeNames.dart';
import 'package:get/get.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteNames.splashScreen,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: RouteNames.login,
          page: () => LoginScreen(),
        ),
           GetPage(
          name: RouteNames.bottomBarScreen,
          page: () => BottomNavPage(),
        ),
       
      ];
}
