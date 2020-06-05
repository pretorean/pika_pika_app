import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

///
///SharedPrefs/NSUserDefaults helper
///todo make universal, di, storage helper
///
class PreferencesHelper {
  Future<T> get<T>(String key, [T defaultValue]) async {
    final sp = await SharedPreferences.getInstance();
    var result = (sp != null) ? await sp.get(key) : null;

    return result ?? defaultValue;
  }

  Future set(String key, Object value) async {
    final _sp = await SharedPreferences.getInstance();
    if (value.runtimeType == String) {
      await _sp.setString(key, value);
    } else if (value.runtimeType == int) {
      await _sp.setInt(key, value);
    } else if (value.runtimeType == double) {
      await _sp.setDouble(key, value);
    } else if (value.runtimeType == bool) {
      await _sp.setBool(key, value);
    } else {
      throw Exception('Does not support type ${value.runtimeType} yet.');
    }
  }

  Future<bool> remove(String key) async {
    final sp = await SharedPreferences.getInstance();
    return await sp.remove(key);
  }
}
