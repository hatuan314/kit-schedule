import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalPreference {
  SharedPreferences sharedPreferences;

  LocalPreference() {
    init();
  }

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> saveStringDataToLocal(
          {@required String key, @required String value}) async =>
      await sharedPreferences.setString(key, value);

  String getStringDataFromLocal({@required String key}) {
    // SharedPreferences prf = await SharedPreferences.getInstance();
    String result = sharedPreferences.getString(key);
    if (result != null)
      return result;
    else
      return null;
  }
}
