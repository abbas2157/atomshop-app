import 'package:get/get.dart';

class LanguageController extends GetxController {
  Rx<Language> selectedLanguage = Language.English.obs; // Temporary selection
  Rx<Language> confirmedLanguage = Language.English.obs; // Applied language

  void selectLanguage(Language language) {
    selectedLanguage.value = language;
  }

  void applyLanguage() {
    confirmedLanguage.value = selectedLanguage.value;
  }
}

enum Language {
  // ignore: constant_identifier_names
  English,
  // ignore: constant_identifier_names
  Urdu,
}
