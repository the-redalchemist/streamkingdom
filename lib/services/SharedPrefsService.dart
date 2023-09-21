//preferences
import 'package:shared_preferences/shared_preferences.dart';

class SavePreference {
  // to set the mode
  Future<void> setTheme(bool theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', theme);
  }

// to get the mode
  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('darkMode') ?? false;
  }

  Future<List<String>?> getOrderListActive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('orderListActive');
  }

  Future<void> setOrderListActive(List<String> orderList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('orderListActive', orderList);
  }

  Future<List<String>?> getOrderListInactive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('orderListInactive');
  }

  Future<void> setOrderListInactive(List<String> orderList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('orderListInactive', orderList);
  }
}