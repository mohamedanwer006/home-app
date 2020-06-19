import 'package:shared_preferences/shared_preferences.dart';

class PrefServices {
  SharedPreferences prefs;

  initPrefs() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
  }

  Future<String> _loadFromPrefs(String key) async {
    await initPrefs();
    var token = prefs.getString(key) ?? true;
    return token;
  }

  setToken(String token) async {
    await initPrefs();
    prefs.setString('token', token);
  }

  Future<String> getToken() {
    return _loadFromPrefs('token');
  }

  removToken() async {
    await initPrefs();
    prefs.remove('token');
  }

  ///save user data in sharedPreferences
  saveUserData(String user) async {
    await initPrefs();
    prefs.setString('user', user);
  }

  ///get user data
  Future<String> getUserData() {
    return _loadFromPrefs('user');
  }

  ///remove user data
  removUser() async {
    await initPrefs();
    prefs.remove('user');
  }

  ///save user Credentials
  saveCredentials(String credentials) async {
    await initPrefs();
    prefs.setString('credentials', credentials);
  }

  ///renove user Credentials
  removeCredentials() async {
    await initPrefs();
    prefs.remove('credentials');
  }

  ///get user Credentials
  Future<String> getCredentials() async {
    await initPrefs();
    return _loadFromPrefs('credentials');
  }
}
