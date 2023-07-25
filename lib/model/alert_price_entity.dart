import 'package:bitfrog/utils/object_util.dart';

class AlertPriceEntity {
  AlertPriceEntity({
      this.id,
      this.symbolKey,
      this.symbolTitle,
      this.exchangeIcon,
      this.exchangeTitle,
      this.items,});

  AlertPriceEntity.fromJson(dynamic json) {
    id = json['id'];
    symbolKey = json['symbol_key'];
    symbolTitle = json['symbol_title'];
    exchangeIcon = json['exchange_icon'];
    exchangeTitle = json['exchange_title'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(PriceItem.fromJson(v));
      });
    }
  }
  int? id;
  String? symbolKey;
  String? symbolTitle;
  String? exchangeIcon;
  String? exchangeTitle;
  List<PriceItem>? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['symbol_key'] = symbolKey;
    map['symbol_title'] = symbolTitle;
    map['exchange_icon'] = exchangeIcon;
    map['exchange_title'] = exchangeTitle;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  static List<AlertPriceEntity>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<AlertPriceEntity> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(AlertPriceEntity.fromJson(map));
    }
    return items;
  }

}

class PriceItem {
  PriceItem({
      this.id,
      this.direction,
      this.price,
      this.app_push,
      this.voice_push,
      this.isRepeat,
      this.expireDate,});

  PriceItem.fromJson(dynamic json) {
    id = json['id'];
    direction = json['direction'];
    price = json['price'];
    app_push = json['app_push'];
    voice_push = json['voice_push'];
    isRepeat = json['is_repeat'];
    expireDate = json['expire_date'];
  }

  int? id;
  String? direction;
  String? price;
  int? app_push;
  int? voice_push;
  int? isRepeat;
  String? expireDate;

  bool get isRise => direction == 'rise';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['direction'] = direction;
    map['price'] = price;
    map['app_push'] = app_push;
    map['voice_push'] = voice_push;
    map['is_repeat'] = isRepeat;
    map['expire_date'] = expireDate;
    return map;
  }

  static List<PriceItem>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<PriceItem> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(PriceItem.fromJson(map));
    }
    return items;
  }

}