import 'package:atomshop/local_storage/prefs.dart';

class LocalStorageMethods {
  LocalStorageMethods._();
  static final instance = LocalStorageMethods._();

  Future<void> writeUserName(String name) async {
    await Prefs.setString("user_name", name);
  }

  String? getUserName() {
    String? name = Prefs.getString("user_name");
    return name;
  }

  Future<void> writeUserId(String id) async {
    await Prefs.setString("user_id", id);
  }

  String? getUserId() {
    String? userID = Prefs.getString("user_id");
    return userID;
  }

  Future<void> writeisFirstTimeOpen(bool value) async {
    await Prefs.setBool("isFirstTimeOpen", value);
  }

  bool? getisFirstTimeOpen() {
    bool? result = Prefs.getBool("isFirstTimeOpen");
    return result;
  }

  Future<void> writeUserApiToken(String id) async {
    await Prefs.setString("api_token", id);
  }

  String? getUserApiToken() {
    String? userID = Prefs.getString("api_token");
    return userID;
  }

  // Add theme preference
  Future<void> writeThemeMode(bool isDarkMode) async {
    await Prefs.setBool("is_dark_mode", isDarkMode);
  }

  bool isThemeModeDark() {
    return Prefs.getBool("is_dark_mode") ?? false; // Default to light mode
  }

  Future<void> clearLocalStorage() async {
    await Prefs.clear();
  }
}
