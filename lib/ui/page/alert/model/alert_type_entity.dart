import 'package:bitfrog/utils/json_transform_util.dart';
import 'package:bitfrog/utils/object_util.dart';

class AlertTypeEntity {
  AlertTypeEntity(
      {this.type,
      this.title,
      this.desc,
      this.subscribeKey,
      this.setCnt,
      this.isRecommend,
      this.isSubscribeDirectly});

  AlertTypeEntity.fromJson(dynamic json) {
    type = json['type'];
    title = json['title'];
    desc = json['desc'];
    subscribeKey = json['subscribe_key'];
    setCnt = JsonTransformUtil.parseNum(json['set_cnt']);
    isRecommend = JsonTransformUtil.parseNum(json['is_recommend']);
    isSubscribeDirectly =
        JsonTransformUtil.parseNum(json['is_subscribe_directly']);
  }

  String? type; //提醒类型
  String? title; //标题
  String? desc; //提醒类型描述
  String? subscribeKey; //订阅key，直接订阅时使用
  num? setCnt; //当前订阅数，大于0时展示已订阅
  num? isRecommend; //是否推荐，0 不推荐 1 推荐
  num? isSubscribeDirectly; //是否可以直接订阅
  bool? checked = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['title'] = title;
    map['desc'] = desc;
    map['subscribe_key'] = subscribeKey;
    map['set_cnt'] = setCnt;
    map['is_recommend'] = isRecommend;
    map['is_subscribe_directly'] = isSubscribeDirectly;
    return map;
  }

  static List<AlertTypeEntity>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<AlertTypeEntity> items = [];
    for (Map<String, dynamic> map in mapList) {
      items.add(AlertTypeEntity.fromJson(map));
    }
    return items;
  }
}
