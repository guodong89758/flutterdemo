
import 'package:bitfrog/utils/json_transform_util.dart';

class TransferRecordEntity {
  TransferRecordEntity({
    this.count,
    this.data,});

  TransferRecordEntity.fromJson(dynamic json) {
    count = json['count'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TransferRecord.fromJson(v));
      });
    }
  }
  int? count;
  List<TransferRecord>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TransferRecord {
  TransferRecord({
      this.currency,
      this.amount,
      this.desc,
      this.state,
      this.created});

  TransferRecord.fromJson(dynamic json) {
    currency = json['currency'];
    amount = json['amount'];
    desc = json['desc'];
    state = json['state'];
    created = json['created'];
  }
  String? currency;
  String? amount;
  String? desc;
  String? state;
  String? created;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currency'] = currency;
    map['amount'] = amount;
    map['desc'] = desc;
    map['state'] = state;
    map['created'] = created;
    return map;
  }

}