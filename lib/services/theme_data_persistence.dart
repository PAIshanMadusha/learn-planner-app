import 'package:shared_preferences/shared_preferences.dart';

class ThemeDataPersistence {

  //Store User's Saved Theme in SharedPreferences
  Future<void> storeTheme(bool isDark) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool("isDark", isDark);
  }

  //Load User's Saved Theme from SharedPreferences
  Future<bool> loadTheme() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool("isDark") ?? false;
  }
}