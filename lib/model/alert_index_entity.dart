import 'package:bitfrog/utils/object_util.dart';

class AlertIndexEntity {
  AlertIndexEntity({
    this.exchange_icon,
    this.symbolTitle,
    this.symbolKey,
    this.periods,
  });

  AlertIndexEntity.fromJson(dynamic json) {
    exchange_icon = json['exchange_icon'];
    symbolTitle = json['symbol_title'];
    symbolKey = json['symbol_key'];
    if (json['periods'] != null) {
      periods = [];
      json['periods'].forEach((v) {
        periods?.add(Period.fromJson(v));
      });
    }
  }

  String? exchange_icon;
  String? symbolTitle;
  String? symbolKey;
  List<Period>? periods;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['exchange_icon'] = exchange_icon;
    map['symbol_title'] = symbolTitle;
    map['symbol_key'] = symbolKey;
    if (periods != null) {
      map['periods'] = periods?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  static List<AlertIndexEntity>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<AlertIndexEntity> items = [];
    for (Map<String, dynamic> map in mapList) {
      items.add(AlertIndexEntity.fromJson(map));
    }
    return items;
  }
}

class Period {
  Period({
    this.title,
    this.key,
    this.periodSwitch,
  });

  Period.fromJson(dynamic json) {
    title = json['title'];
    key = json['key'];
    periodSwitch = json['switch'];
  }

  String? title;
  int? key;
  int? periodSwitch;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['key'] = key;
    map['switch'] = periodSwitch;
    return map;
  }
}
