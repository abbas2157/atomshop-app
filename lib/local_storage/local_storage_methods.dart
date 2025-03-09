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

  Future<void> writeUserEmail(String mail) async {
    await Prefs.setString("user_email", mail);
  }

  String? getUserEmail() {
    String? name = Prefs.getString("user_email");
    return name;
  }

  Future<void> writeUserId(String id) async {
    await Prefs.setString("user_id", id);
  }

  String? getUserId() {
    String? userID = Prefs.getString("user_id");
    return userID;
  }

  Future<void> writeUserUUID(String id) async {
    await Prefs.setString("user_uuid", id);
  }

  String? getUserUUID() {
    String? userID = Prefs.getString("user_uuid");
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

  /////// search
  static const String _recentSearchesKey = "recent_searches";

  // Search History
  Future<void> saveRecentSearch(String query) async {
    List<String> searches = getRecentSearches();
    searches.remove(query); // Avoid duplicates
    searches.insert(0, query); // Add to top

    if (searches.length > 10) {
      searches = searches.sublist(0, 10); // Keep only 10 items
    }

    await Prefs.setStringList(_recentSearchesKey, searches);
  }

  List<String> getRecentSearches() =>
      Prefs.getStringList(_recentSearchesKey) ?? [];

  Future<void> clearRecentSearch(String query) async {
    List<String> searches = getRecentSearches();
    searches.remove(query);
    await Prefs.setStringList(_recentSearchesKey, searches);
  }

  Future<void> clearAllRecentSearches() async =>
      await Prefs.remove(_recentSearchesKey);
}
