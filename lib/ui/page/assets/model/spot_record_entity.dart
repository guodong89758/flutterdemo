
import 'package:bitfrog/utils/json_transform_util.dart';

class SpotRecordEntity {
  SpotRecordEntity({
    this.count,
    this.data,});

  SpotRecordEntity.fromJson(dynamic json) {
    count = json['count'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SpotRecord.fromJson(v));
      });
    }
  }
  int? count;
  List<SpotRecord>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class SpotRecord {
  SpotRecord({
      this.currency,
      this.amount,
      this.type,
      this.typeDesc,
      this.created});

  SpotRecord.fromJson(dynamic json) {
    currency = json['currency'];
    amount = json['amount'];
    type = JsonTransformUtil.parseNum(json['type']);
    typeDesc = json['type_desc'];
    created = json['created'];
  }
  String? currency;
  String? amount;
  num? type;
  String? typeDesc;
  String? created;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currency'] = currency;
    map['amount'] = amount;
    map['type'] = type;
    map['type_desc'] = typeDesc;
    map['created'] = created;
    return map;
  }

}