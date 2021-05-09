import 'package:shared_preferences/shared_preferences.dart';

class LocalPref extends Pref {
  @override
  Future saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else {
      await prefs.setString(key, value);
    }
  }

  @override
  Future getData<T>(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (T == bool) {
      return prefs.getBool(key) as T;
    } else if (T == String) {
      return prefs.getString(key) as T;
    } else if (T == int) {
      return prefs.getInt(key) as T;
    } else if (T == double) {
      return prefs.getDouble(key) as T;
    }
    return null;
  }
}

abstract class Pref {
  Future saveData(String key, dynamic value);

  Future getData<T>(String key);
}
