import 'package:bitfrog/utils/json_transform_util.dart';
import 'package:bitfrog/utils/object_util.dart';

class SubscribeItemEntity {
  SubscribeItemEntity({
    this.subscribeKey,
    this.subscribeTitle,
    this.icon,
    this.subscribeSwitch,
  });

  SubscribeItemEntity.fromJson(dynamic json) {
    subscribeKey = json['subscribe_key'];
    subscribeTitle = json['subscribe_title'];
    icon = json['icon'];
    subscribeSwitch = JsonTransformUtil.parseNum(json['switch']);
  }

  String? subscribeKey;
  String? subscribeTitle;
  String? icon;
  num? subscribeSwitch;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subscribe_key'] = subscribeKey;
    map['subscribe_title'] = subscribeTitle;
    map['icon'] = icon;
    map['switch'] = subscribeSwitch;
    return map;
  }

  static List<SubscribeItemEntity>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<SubscribeItemEntity> items = [];
    for (Map<String, dynamic> map in mapList) {
      items.add(SubscribeItemEntity.fromJson(map));
    }
    return items;
  }
}
