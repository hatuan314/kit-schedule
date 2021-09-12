import 'package:flutter/cupertino.dart';
import 'package:schedule/common/constants/key_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelect extends ChangeNotifier {
  static Locale? locale;
  static bool isEnglish = true;

  Future<void> changeLanguage(bool isEng) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isEnglish = isEng;
    await prefs.setBool(KeyConstants.language, isEng);
    if (isEnglish) {
      locale = Locale('en');
    } else {
      locale = Locale('vi');
    }
    notifyListeners();
  }
}
