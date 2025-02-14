import 'package:shared_preferences/shared_preferences.dart';
import 'package:shops_manager_offline/core/constants.dart';

Future<bool> isLoggedIn() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getBool('isLoggedIn') ?? false;
}

Future<bool> isAdmin() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isAdmin') ?? false;
}

Future<int> getUserId() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getInt(idKey)!;
}

Future<void> storeUserData(
    {required bool logged, required int id, required bool isAdmin}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', logged);
  prefs.setInt('id', id);
  prefs.setBool('isAdmin', isAdmin);
}
