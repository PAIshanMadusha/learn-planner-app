import 'package:flutter/material.dart';
import 'package:learn_planner/services/theme_data_persistence.dart';
import 'package:learn_planner/utils/themes_mode_data.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeProvider() {
    _loadTheme();
  }

  ThemeData _themeData = ThemesModeData().lightMode;

  final ThemeDataPersistence _themeDataPersistence = ThemeDataPersistence();

  //Getter
  ThemeData get getThemeData => _themeData;

  //Setter
  set setThemeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  //Load the Theme from SharedPreferences
  Future<void> _loadTheme() async {
    bool isDark = await _themeDataPersistence.loadTheme();
    setThemeData =
        isDark ? ThemesModeData().darkMode : ThemesModeData().lightMode;
  }

  //Toggle Theme
  Future<void> toggleTheme(bool isDark) async {
    setThemeData =
        isDark ? ThemesModeData().darkMode : ThemesModeData().lightMode;

    await _themeDataPersistence.storeTheme(isDark);
    notifyListeners();
  }
}
