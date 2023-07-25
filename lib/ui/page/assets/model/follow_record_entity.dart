
class FollowRecordEntity {
  FollowRecordEntity({
    this.count,
    this.data,});

  FollowRecordEntity.fromJson(dynamic json) {
    count = json['count'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(FollowRecord.fromJson(v));
      });
    }
  }
  int? count;
  List<FollowRecord>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class FollowRecord {
  FollowRecord({
      this.planName,
      this.amount,
      this.typeName,
      this.currency,
      this.time});

  FollowRecord.fromJson(dynamic json) {
    planName = json['plan_name'];
    typeName = json['type_name'];
    amount = json['amount'];
    currency = json['currency'];
    time = json['time'];
  }
  String? planName;
  String? typeName;
  String? amount;
  String? currency;
  String? time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['plan_name'] = planName;
    map['type_name'] = typeName;
    map['amount'] = amount;
    map['currency'] = currency;
    map['time'] = time;
    return map;
  }

}