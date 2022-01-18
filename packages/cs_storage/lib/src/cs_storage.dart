import 'package:shared_preferences/shared_preferences.dart';

/// {@template cs_coder}
/// Cscoder for local storage of the app using key and value
/// {@endtemplate}
class CsStorage {
  CsStorage({this.prefs});

  final SharedPreferences? prefs;

  Object? read(String key) async {
    final pref = prefs;
    return pref!.get(key);
  }

  Future<String?> readString(String key) async {
    final pref = prefs;
    return pref!.getString(key);
  }

  Future<void> saveString({String? key, String? value}) async {
    final pref = prefs;
    pref!.setString(key!, value!);
  }

  Future<void> saveBool({String? key, bool? value}) async {
    final pref = prefs;
    pref!.setBool(key!, value!);
  }

  Future<bool> clear({String? key, String? value}) async {
    final pref = prefs;
    return pref!.clear();
  }

  Future<bool> remove(String key) async {
    final pref = prefs;
    return pref!.remove(key);
  }

  Future<bool> check(String key) async {
    final pref = prefs;
    return pref!.containsKey(key);
  }
}
