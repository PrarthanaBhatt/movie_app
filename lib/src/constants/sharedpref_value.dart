import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefValue {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences?> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static Future<void> setPrefValue(String keyValue, dynamic value) async {
    switch (value.runtimeType) {
      case bool:
        _prefs!.setBool(keyValue, value);
        break;
      case String:
        _prefs!.setString(keyValue, value);
        break;
      case double:
        _prefs!.setDouble(keyValue, value);
        break;
    }
  }

  static Future<dynamic> getPrefValue(String keyValue, dynamic value) async {
    switch (value) {
      case bool:
        return _prefs!.getBool(keyValue);
      case String:
        return _prefs!.getString(keyValue);
      case double:
        return _prefs!.getDouble(keyValue);
    }
  }
}
