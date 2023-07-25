import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/constant/config.dart';
import 'package:bitfrog/utils/sp_util.dart';

import '../res/colors.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => <String>['system', 'light', 'dark'][index];
}

class ThemeProvider extends ChangeNotifier {
  void syncTheme() {
    final String theme = SpUtil.getString(Config.KEY_APP_THEME) ?? '';
    if (theme.isNotEmpty && theme != ThemeMode.system.value) {
      notifyListeners();
    }
  }

  void changeTheme(ThemeMode themeMode) {
    SpUtil.putString(Config.KEY_APP_THEME, themeMode.value);
    notifyListeners();
  }

  ThemeMode getThemeMode() {
    final String theme =
        SpUtil.getString(Config.KEY_APP_THEME, defValue: 'light')!;
    switch (theme) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  ThemeData getThemeData({bool isDarkMode = false}) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colours.app_main,
      // colorScheme: ColorScheme.fromSwatch().copyWith(
      //   brightness: isDarkMode ? Brightness.dark : Brightness.light,
      //   secondary: Colours.app_main,
      // ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      // 页面背景色
      scaffoldBackgroundColor: Colors.white,
      // 主要用于Material背景色
      canvasColor: Colors.white,
    );
  }
}
