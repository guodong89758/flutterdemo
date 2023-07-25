
import 'package:bitfrog/utils/object_util.dart';

class AssetAccountEntity {
  AssetAccountEntity({
    this.id,
    this.type,
    this.exchange,
    this.icon,
    this.name,
    this.asset,
    this.assetSpot,
    this.assetContract,
    this.unit,});

  AssetAccountEntity.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    exchange = json['exchange'];
    icon = json['icon'];
    name = json['name'];
    asset = json['asset'];
    assetSpot = json['asset_spot'];
    assetContract = json['asset_contract'];
    unit = json['unit'];
  }
  String? id;
  String? type;
  String? exchange;
  String? icon;
  String? name;
  String? asset;
  String? assetSpot;
  String? assetContract;
  String? unit;
  bool checked = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['exchange'] = exchange;
    map['icon'] = icon;
    map['name'] = name;
    map['asset'] = asset;
    map['asset_spot'] = assetSpot;
    map['asset_contract'] = assetContract;
    map['unit'] = unit;

    return map;
  }

  static List<AssetAccountEntity>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<AssetAccountEntity> items = [];
    for (Map<String, dynamic> map in mapList) {
      items.add(AssetAccountEntity.fromJson(map));
    }
    return items;
  }
}
