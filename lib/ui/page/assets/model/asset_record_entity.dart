import 'package:bitfrog/utils/json_transform_util.dart';

/// id : ""
/// currency : ""
/// chain : ""
/// amount : ""
/// fee : ""
/// state : 0
/// state_desc : ""
/// address : ""
/// txid : ""
/// created : ""
/// time : ""
class AssetRecordEntity {
  AssetRecordEntity({
    this.count,
    this.data,});

  AssetRecordEntity.fromJson(dynamic json) {
    count = json['count'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(RecordEntity.fromJson(v));
      });
    }
  }
  int? count;
  List<RecordEntity>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class RecordEntity {
  RecordEntity({
      this.id, 
      this.currency, 
      this.chain, 
      this.amount, 
      this.fee, 
      this.state, 
      this.stateDesc, 
      this.address, 
      this.txid, 
      this.created, 
      this.time,});

  RecordEntity.fromJson(dynamic json) {
    id = json['id'];
    currency = json['currency'];
    chain = json['chain'];
    amount = json['amount'];
    fee = json['fee'];
    state = JsonTransformUtil.parseNum(json['state']);
    stateDesc = json['state_desc'];
    address = json['address'];
    txid = json['txid'];
    created = json['created'];
    time = json['time'];
  }
  String? id;
  String? currency;
  String? chain;
  String? amount;
  String? fee;
  num? state;
  String? stateDesc;
  String? address;
  String? txid;
  String? created;
  String? time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['currency'] = currency;
    map['chain'] = chain;
    map['amount'] = amount;
    map['fee'] = fee;
    map['state'] = state;
    map['state_desc'] = stateDesc;
    map['address'] = address;
    map['txid'] = txid;
    map['created'] = created;
    map['time'] = time;
    return map;
  }

}