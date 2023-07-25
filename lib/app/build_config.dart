import 'package:bitfrog/utils/user_util.dart';

final buildConfig = BuildConfig._internal();

class BuildConfig {
  BuildConfig._internal();

  Flavor flavor = Flavor.production;

  String get baseUrl {
    switch (flavor) {
      case Flavor.production:
        String domain = UserUtil.getCurrentDomain();
        if (domain.isNotEmpty) {
          return domain;
        }
        return "https://bitfrog.api.cc/";
      case Flavor.staging:
        // return "http://wx.dreamingfire.top/";
        return "http://pre-api.cn/";
      case Flavor.develop:
        return "http://test-api.cn/";
    }
  }
}

enum Flavor {
  production,
  staging,
  develop,
}
