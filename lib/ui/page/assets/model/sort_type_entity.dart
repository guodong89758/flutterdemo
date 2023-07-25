import 'package:bitfrog/utils/object_util.dart';

/// type : 1
/// value : ""

class SortTypeEntity {
  SortTypeEntity({this.type, this.value, this.name});

  SortTypeEntity.fromJson(dynamic json) {
    type = json['type'];
    value = json['value'] is int ? json['value'].toString() : json['value'];
    name = json['name'];
  }

  num? type;
  String? value;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['value'] = value;
    map['name'] = name;
    return map;
  }

  static List<SortTypeEntity>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<SortTypeEntity> items = [];
    for (Map<String, dynamic> map in mapList) {
      items.add(SortTypeEntity.fromJson(map));
    }
    return items;
  }
}
