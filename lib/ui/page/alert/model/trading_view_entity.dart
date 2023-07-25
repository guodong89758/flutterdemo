import 'package:bitfrog/utils/json_transform_util.dart';
import 'package:bitfrog/utils/object_util.dart';

class TradingConfigEntity {
  TradingConfigEntity(
      {this.web_hook_url,
        this.alertPush,
        this.voicePush,
        this.appPush});

  TradingConfigEntity.fromJson(dynamic json) {
    web_hook_url = json['web_hook_url'];
    alertPush = JsonTransformUtil.parseNum(json['alert_push']);
    voicePush = JsonTransformUtil.parseNum(json['voice_push']);
    appPush =
        JsonTransformUtil.parseNum(json['app_push']);
  }

  String? web_hook_url; //提醒类型
  num? appPush; //当前订阅数，大于0时展示已订阅
  num? alertPush; //是否推荐，0 不推荐 1 推荐
  num? voicePush; //是否可以直接订阅
  bool? checked = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['web_hook_url'] = web_hook_url;
    map['app_push'] = appPush;
    map['voice_push'] = voicePush;
    map['alert_push'] = alertPush;
    return map;
  }

  // static List<AlertTypeEntity>? fromJsonList(List<dynamic> mapList) {
  //   if (ObjectUtil.isEmptyList(mapList)) {
  //     return null;
  //   }
  //
  //   List<AlertTypeEntity> items = [];
  //   for (Map<String, dynamic> map in mapList) {
  //     items.add(AlertTypeEntity.fromJson(map));
  //   }
  //   return items;
  // }
}
