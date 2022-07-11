// 🎯 Dart imports:
import 'dart:async';

// 📦 Package imports:
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch/shared_preferences/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  static late SharedPreferences _sharedPreference;

  // initialization
  static Future init() async =>
      _sharedPreference = await SharedPreferences.getInstance();

  // stop watch time:---------------------------------------------------

  static Future saveStopWatch(int value) async {
    await _sharedPreference.setInt(Preferences.stopWatchTimeInSeconds, value);
  }

  static int? get getStopWatchInSeconds {
    return _sharedPreference.getInt(Preferences.stopWatchTimeInSeconds) ?? 0;
  }

  // other:---------------------------------------------------

  static bool checkKey(String key) => _sharedPreference.containsKey(key);
  static Future<bool> removeKey(String key) async =>
      await _sharedPreference.remove(key);
  static Future reset() async {
    await init();
    _sharedPreference.clear();
  }
}
