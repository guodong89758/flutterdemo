
import 'package:bitfrog/utils/log_utils.dart';
import 'package:bitfrog/utils/user_util.dart';

class LanguageManger{

  static const String zh = "zh-CN"; ///中文
  static const String en = "en-US"; ///英文
  static const String ja = "ja-JP"; ///日文
  static const String ko = "ko-KR"; ///韩文
  static const String tr = "tr-TR"; ///土耳其
  static const String zhTW = "zh-TW"; ///中国台湾


 static const String defaultLanguage = LanguageManger.en;  /// 默认的语言

  // static Future<String> getLocalLanguage() async{
  //   String localeStr = await Devicelocale.currentLocale ?? "";
  //   Log.e("系统语言:$localeStr");
  //
  //   List<String> localList = localeStr.split("-");
  //   String localPreStr = "";
  //   if(localList.isNotEmpty){
  //     localPreStr = localList.first;
  //   }
  //
  //   // zh-Hans-CN  zh-Hant-CN
  //
  //   String locale = en;
  //   switch(localPreStr){
  //     case "zh":
  //       locale = zh;
  //       if(localList.length>1){
  //         String localChinese = localList[1];
  //         if(localChinese=="Hans"){
  //           locale = zh;
  //         }else if(localChinese=="Hant"){
  //           locale = zhTW;
  //         }
  //       }
  //       break;
  //     case "en":
  //       locale = en;
  //       break;
  //     case "ja":
  //       locale = ja;
  //       break;
  //     case "tr":
  //       locale = tr;
  //       break;
  //     case "ko":
  //       locale = ko;
  //       break;
  //   }
  //   return locale;
  // }



  factory LanguageManger() => _ins();

  static LanguageManger get instance => _ins();

  static LanguageManger? _instance;

  LanguageManger._internal();

  static LanguageManger _ins() {
    _instance ??= LanguageManger._internal();
    return _instance!;
  }

  String _currentLanguage = "";

  /// 设置系统语言
  setSystemLanguage(String localeStr){

    List<String> localList = localeStr.split("_");
    String localPreStr = "";
    if(localList.isNotEmpty){
      localPreStr = localList.first;
    }

    // zh-Hans-CN  zh-Hant-CN

    String locale = en;
    switch(localPreStr){
      case "zh":
        locale = zh;
        if(localList.length>1){
          String localChinese = localList[1];
          if(localChinese=="Hans"){
            locale = zh;
          }else if(localChinese=="Hant"){
            locale = zhTW;
          }
        }
        break;
      case "en":
        locale = en;
        break;
      case "ja":
        locale = ja;
        break;
      case "tr":
        locale = tr;
        break;
      case "ko":
        locale = ko;
        break;
    }
    Log.e("系统语言:$locale");
    _currentLanguage = locale;

    UserUtil.saveCurrentLanguage(locale);


  }


  /// 获取当前语言
  String get currentLanguage{
    String languageStr = UserUtil.getCurrentLanguage() ?? "";
    if(languageStr.isEmpty){
      languageStr = _currentLanguage;
    }
    if(languageStr.isEmpty){
      return en;
    }
    return languageStr;
  }



}