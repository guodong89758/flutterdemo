class AssertsAccountIndexEntity {
  AssertsAccountIndexEntity({
      this.unit, 
      this.balanceBtc, 
      this.balance, 
      this.spotBalance, 
      this.contractFollowBalance, 
      this.voiceBalance, 
      this.list,});

  AssertsAccountIndexEntity.fromJson(dynamic json) {
    unit = json['unit'];
    balanceBtc = json['balance_btc'];
    balance = json['balance'];
    spotBalance = json['spot_balance'];
    contractFollowBalance = json['contract_follow_balance'];
    voiceBalance = json['voice_balance']?.toString();
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list?.add(ApiAccountEntity.fromJson(v));
      });
    }
  }
  String? unit;
  String? balanceBtc;
  String? balance;
  String? spotBalance;
  String? contractFollowBalance;
  String? voiceBalance;
  List<ApiAccountEntity>? list;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unit'] = unit;
    map['balance_btc'] = balanceBtc;
    map['balance'] = balance;
    map['spot_balance'] = spotBalance;
    map['contract_follow_balance'] = contractFollowBalance;
    map['voice_balance'] = voiceBalance;
    if (list != null) {
      map['list'] = list?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ApiAccountEntity {
  ApiAccountEntity({
    this.id,
    this.exchange,
    this.icon,
    this.type,
    this.name,
    this.value,});

  ApiAccountEntity.fromJson(dynamic json) {
    id = json['id'];
    exchange = json['exchange'];
    icon = json['icon'];
    type = json['type'];
    name = json['name'];
    value = json['value'];
  }
  String? id;
  String? exchange;
  String? icon;
  String? type;
  String? name;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['exchange'] = exchange;
    map['icon'] = icon;
    map['type'] = type;
    map['name'] = name;
    map['value'] = value;
    return map;
  }

}