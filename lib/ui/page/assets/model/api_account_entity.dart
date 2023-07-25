class ApiAccountEntity {
  ApiAccountEntity({
      this.btc, 
      this.total, 
      this.totalUnit, 
      this.exchange, 
      this.accountType, 
      this.createdAt,});

  ApiAccountEntity.fromJson(dynamic json) {
    btc = json['btc'];
    total = json['total'];
    totalUnit = json['total_unit'];
    exchange = json['exchange'];
    accountType = json['account_type'];
    createdAt = json['created_at'];
  }
  String? btc;
  String? total;
  String? totalUnit;
  String? exchange;
  String? accountType;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['btc'] = btc;
    map['total'] = total;
    map['total_unit'] = totalUnit;
    map['exchange'] = exchange;
    map['account_type'] = accountType;
    map['created_at'] = createdAt;
    return map;
  }

}