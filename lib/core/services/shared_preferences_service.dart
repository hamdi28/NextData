import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {

  static SharedPreferencesService? _instance;

  static SharedPreferences? _preferences;

  static Future<SharedPreferencesService> getInstance() async {

    if (_instance == null) {
      _instance = SharedPreferencesService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance!;
  }


  ///load from shared preference
  dynamic getFromDisk(String key) {
    String uniqueKey = key;
    var value = _preferences?.get(uniqueKey);
    return value;
  }

  ///save to shared preferences with generic types (Accepting : String,Bool,Int,Double,List<String>)
  void saveModelToDisk<T>(String key , T content) {
    String uniqueKey = key;
    if (content is String) {

      _preferences?.setString(uniqueKey, content);
    }
    if (content is bool) {
      _preferences?.setBool(uniqueKey, content);
    }
    if (content is int) {
      _preferences?.setInt(uniqueKey, content);
    }
    if (content is double) {
      _preferences?.setDouble(uniqueKey, content);
    }
    if (content is List<String>) {
      _preferences?.setStringList(uniqueKey, content);
    }
  }


  ///Clear all shared preferences
  clearDisk() => _preferences!.clear();
}
