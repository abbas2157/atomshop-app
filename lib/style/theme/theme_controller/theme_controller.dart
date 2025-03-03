import 'package:atomshop/local_storage/local_storage_methods.dart';
import 'package:atomshop/style/theme/app_theme.dart';
import 'package:get/get.dart';


class ThemeController extends GetxController {
  final LocalStorageMethods _storage = LocalStorageMethods.instance;
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTheme(); // Load theme when controller is initialized
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _storage.writeThemeMode(isDarkMode.value);
    Get.changeTheme(isDarkMode.value ? AppThemes.darkTheme : AppThemes.lightTheme);
  }

  void loadTheme() {
    isDarkMode.value = _storage.isThemeModeDark(); // Load saved theme
    Get.changeTheme(isDarkMode.value ? AppThemes.darkTheme : AppThemes.lightTheme);
  }
}


