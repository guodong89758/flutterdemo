import 'package:bitfrog/utils/object_util.dart';

class AlertConfigEntity {
  AlertConfigEntity({
      this.type, 
      this.title,
      this.desc, 
      this.set_cnt,
      this.set_page_desc,
      this.icon,});

  AlertConfigEntity.fromJson(dynamic json) {
    type = json['type'];
    title = json['title'];
    desc = json['desc'];
    set_cnt = json['set_cnt'];
    set_page_desc = json['set_page_desc'];
    icon = json['icon'];
  }
  String? type;
  String? title;
  String? desc;
  num? set_cnt;
  String? set_page_desc;
  String? icon;
  num? isSubscribe = 0;
  bool? checked = false;
  bool? hot = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['title'] = title;
    map['desc'] = desc;
    map['set_cnt'] = set_cnt;
    map['set_page_desc'] = set_page_desc;
    map['icon'] = icon;
    return map;
  }

  static List<AlertConfigEntity>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<AlertConfigEntity> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(AlertConfigEntity.fromJson(map));
    }
    return items;
  }
}