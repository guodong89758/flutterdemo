import 'package:bitfrog/api/bitfrog_api.dart';
import 'package:bitfrog/model/app_confg_entity.dart';

/// App配置项下发管理
class AppConfigManager {
  factory AppConfigManager() => _ins();

  static AppConfigManager get instance => _ins();

  static AppConfigManager? _instance;

  AppConfigEntity? appConfig;

  AppConfigManager._internal();

  static AppConfigManager _ins() {
    _instance ??= AppConfigManager._internal();
    return _instance!;
  }

  bool checkAppConfig() {
    if (appConfig == null) {
      getAppConfigFromServer();
      return false;
    }
    return true;
  }

  void getAppConfigFromServer() {
    BitFrogApi.instance.getAppConfig(onSuccess: (dynamic) {
      appConfig = AppConfigEntity.fromJson(dynamic);


    });
  }

   Future<AppConfigEntity?> getAppConfig({bool showLoading = true}) async {
    if(appConfig!=null){
      return appConfig;
    }
    try {
      var res = await BitFrogApi.instance.getAppConfig(showLoading: showLoading);
      appConfig = AppConfigEntity.fromJson(res);
      return appConfig;
    } catch (e) {
     return null;
    }
  }

  /// 置空之后从新下载
  recover(){
    appConfig = null;
  }



}
