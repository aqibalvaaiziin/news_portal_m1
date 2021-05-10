import 'package:shared_preferences/shared_preferences.dart';

class PreferencesData {
  Future setIsLoggedIn(bool isLoggedIn) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool("isLoggedIn", isLoggedIn);
  }

  Future setIsUserHasTopic(bool isHasTopic) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool("isHasTopic", isHasTopic);
  }

  Future setUserToken(String token) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("token", token);
  }

  Future setUserData(String name, String email) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("name", name);
    sp.setString("email", email);
  }

  Future setIsAlreadyOpenOnboarding(bool isdone) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool("isAlreadyOpenOnboarding", isdone);
  }

  Future setUserId(int userId) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt("userId", userId);
  }
}
