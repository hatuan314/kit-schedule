import 'package:shared_preferences/shared_preferences.dart';

class ShareService {
  static final ShareService _singleton = new ShareService._internal();

  factory ShareService() {
    return _singleton;
  }

  ShareService._internal();

  bool _isSave = false;

  Future<bool> getIsSaveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this._isSave = prefs.getBool('data');
    return this._isSave;
  }

  Future setIsSaveData(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('data', value);
    this._isSave = value;
  }
}
