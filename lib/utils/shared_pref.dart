import 'package:shared_preferences/shared_preferences.dart';

class SPTool {
  Future<String> getStringForkey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  setStringForKey(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<bool> getBoolForkey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  setBoolForKey(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  // 工厂模式 : 单例公开访问点
  factory SPTool() => _instance;
  static final SPTool _instance = SPTool._internal();
  static SPTool get instance => _instance;
  // 私有的命名构造函数
  SPTool._internal();
}
