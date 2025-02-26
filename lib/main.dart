import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/features/splash_screen/splash_screen_view/splash_screen_view.dart';
import 'package:atomshop/local_storage/prefs.dart';
import 'package:atomshop/routes/route_configs.dart';
import 'package:atomshop/style/theme/app_theme.dart';
import 'package:atomshop/style/theme/theme_controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Prefs.init();
  // Ensure ScreenUtil is initialized before the app starts
  await ScreenUtil.ensureScreenSize();

  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 800), // Your design reference size
      builder: (context, child) {
        return MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  final ThemeController _themeController = Get.put(ThemeController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppRoutes.appRoutes(),
      navigatorKey: AppConstants.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Atom Shop',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode:
          _themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      home: SplashScreen(),
    );
  }
}

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  final ThemeController _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_themeController.isDarkMode.value
          ? Icons.dark_mode
          : Icons.light_mode),
      onPressed: () {
        _themeController.toggleTheme();
        setState(() {});
      },
    );
  }
}
