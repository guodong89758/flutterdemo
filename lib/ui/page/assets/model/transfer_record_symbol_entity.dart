import 'package:bitfrog/ui/page/transaction/model/ticker_message.dart';
import 'package:bitfrog/utils/object_util.dart';

class TransferChooseSymbolEntity{
  TransferChooseSymbolEntity({
    this.name,
    this.value,
   });

  TransferChooseSymbolEntity.fromJson(dynamic json) {
    name = json['name'];
    value = json['value'];

  }
  String? name;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['value'] = value;
    return map;
  }

  static List<TransferChooseSymbolEntity>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<TransferChooseSymbolEntity> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(TransferChooseSymbolEntity.fromJson(map));
    }
    return items;
  }

}