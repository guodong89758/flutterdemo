import 'package:bitfrog/utils/object_util.dart';

/// tab : ""
/// name : ""

class AlertTab {
  AlertTab({
      this.tab, 
      this.name,});

  AlertTab.fromJson(dynamic json) {
    tab = json['tab'];
    name = json['name'];
  }
  int? tab;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tab'] = tab;
    map['name'] = name;
    return map;
  }

  static List<AlertTab>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<AlertTab> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(AlertTab.fromJson(map));
    }
    return items;
  }

}