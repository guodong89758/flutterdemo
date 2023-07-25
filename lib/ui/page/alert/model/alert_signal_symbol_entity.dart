import 'package:bitfrog/model/symbol_entity.dart';
class AlertSignalSymbolEntity {
  AlertSignalSymbolEntity({
    this.data,
    this.count,});

  AlertSignalSymbolEntity.fromJson(dynamic json) {
    if (json != null) {
      data = [];
      json.forEach((v) {
        data?.add(BFSymbol.fromJson(v));
      });
    }
  }
  List<BFSymbol>? data;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['count'] = count;
    return map;
  }
}