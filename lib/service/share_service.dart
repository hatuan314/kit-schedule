import 'package:shared_preferences/shared_preferences.dart';

class ShareService {
  static final ShareService _singleton = new ShareService._internal();

  factory ShareService() {
    return _singleton;
  }

  ShareService._internal();

  bool? _isSave = false;

  Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? '';
    return username;
  }

  Future<bool> setUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString('username', username);
  }

  Future<bool?> getIsSaveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this._isSave = prefs.getBool('data');
    return this._isSave;
  }

  Future setIsSaveData(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('data', value);
    this._isSave = value;
  }

  Future<bool?> getHasNoti() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasNoti = prefs.getBool('noti') ?? false;
    return hasNoti;
  }

  Future setHasNoti(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('noti', value);
  }

  Future<bool> getIsFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstRun = prefs.getBool('isFirstRun') ??true;
    return  isFirstRun;
  }

  Future setIsFirstRun(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirstRun', value);
  }
}
