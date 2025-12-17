import 'package:shared_preferences/shared_preferences.dart';

class EmployerSession {
  EmployerSession._();

  static const key = 'is_employer_mode';

  static Future<void> setMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<bool> isEmployer() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }
}

