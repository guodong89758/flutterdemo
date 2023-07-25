import 'package:bitfrog/constant/langue.dart';
import 'package:bitfrog/res/image_zh.dart';
import 'package:bitfrog/utils/user_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/res/base_image.dart';
import 'package:bitfrog/res/image_en.dart';


class LocaleProvider extends ChangeNotifier {
  // 获取当前用户的APP语言配置Locale类，如果为null，则语言跟随系统语言
  Locale? getLocale() {

    if(_locale.isEmpty){
      _locale = UserUtil.getCurrentLanguage() ?? "";
    }
    if (_locale.isEmpty){
      // return const Locale('en', 'US');
      return null;
    }
    // var t = _locale.split("_");
    // return Locale(t[0], t.length > 1 ? t[1] : null);
    // return const Locale('zh', 'CN');
    switch (locale) {
      case LanguageManger.zh:
        return const Locale('zh', 'CN');
      case LanguageManger.zhTW:
        return const Locale('zh', 'TW');
      case LanguageManger.en:
        return const Locale('en', 'US');
      case LanguageManger.ja:
        return const Locale('ja', 'JP');
      case LanguageManger.ko:
        return const Locale('ko', 'KR');
      case LanguageManger.tr:
        return const Locale('tr', 'TR');
      default:
        return const Locale('en', 'US');
    }
  }

  String _locale;

  LocaleProvider(this._locale);

  // 获取当前Locale的字符串表示
  String get locale => _locale;

  // 用户改变APP语言后，通知依赖项更新，新语言会立即生效
  set locale(String locale) {
    if (_locale != locale) {
      _locale = locale;
      // SpUtil.putString(Config.KEY_APP_LOCALE, _locale);
      notifyListeners();
    }
  }

  BaseImage getImageRes() {
    switch (locale) {
      case LanguageManger.zh:
        return ImageZH();
      default:
        return ImageEN();
    }
  }

}
