/// unit : "CNY"
/// balance : {"btc_amount":"0.00349680","unit_amount":"204.92"}
/// spot_list : [{"currency":"USDT","icon":"http://s0.fbit.com/coin/USDT.png","unit_amount":"33.93","withdraw_available":"4.09507728","frozen":"1.00000000","trade_permission":0,"deposit_permission":1,"withdraw_permission":0,"transfer_permission":1}]
/// contract_list : [{"plan_id":"VA9zrOR0Nq","follow_id":"VA9zrPxM0N","plan_name":"V2 联调测试合约带单","master_name":"大白","master_avatar":"http://fbit-saas-oss-test.oss-cn-hongkong.aliyuncs.com/head_img/1659066715_8892.png?x-oss-process=image/resize,h_100","asset_unit":"USDT","account_asset":"5","profit":"0","profit_ratio":"0"},{"plan_id":"v16RA0zdGX","follow_id":"9Z5zqx1o7E","plan_name":"合约跟单测试--0726","master_name":"董哥测试","master_avatar":"http://fbit-saas-oss-test.oss-cn-hongkong.aliyuncs.com/head_img/1653045774701.png?x-oss-process=image/resize,h_100","asset_unit":"USDT","account_asset":"4.37","profit":"-0.59","profit_ratio":"-11.89"}]

class AssetsInfoEntity {
  AssetsInfoEntity({
    this.unit,
    this.balance,
    this.spotList,
    this.contractList,
  });

  AssetsInfoEntity.fromJson(dynamic json) {
    unit = json['unit'];
    balance =
        json['balance'] != null ? Balance.fromJson(json['balance']) : null;
    if (json['spot_list'] != null) {
      spotList = [];
      json['spot_list'].forEach((v) {
        spotList?.add(SpotEntity.fromJson(v));
      });
    }
    if (json['contract_list'] != null) {
      contractList = [];
      json['contract_list'].forEach((v) {
        contractList?.add(ContractEntity.fromJson(v));
      });
    }
  }

  String? unit;
  Balance? balance;
  List<SpotEntity>? spotList;
  List<ContractEntity>? contractList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unit'] = unit;
    if (balance != null) {
      map['balance'] = balance?.toJson();
    }
    if (spotList != null) {
      map['spot_list'] = spotList?.map((v) => v.toJson()).toList();
    }
    if (contractList != null) {
      map['contract_list'] = contractList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// plan_id : "VA9zrOR0Nq"
/// follow_id : "VA9zrPxM0N"
/// plan_name : "V2 联调测试合约带单"
/// master_name : "大白"
/// master_avatar : "http://fbit-saas-oss-test.oss-cn-hongkong.aliyuncs.com/head_img/1659066715_8892.png?x-oss-process=image/resize,h_100"
/// asset_unit : "USDT"
/// account_asset : "5"
/// profit : "0"
/// profit_ratio : "0"

class ContractEntity {
  ContractEntity(
      {this.planId,
      this.followId,
      this.planName,
      this.masterName,
      this.masterAvatar,
      this.assetUnit,
      this.accountAsset,
      this.profit,
      this.profitRatio,
      this.profitUnit});

  ContractEntity.fromJson(dynamic json) {
    planId = json['plan_id'];
    followId = json['follow_id'];
    planName = json['plan_name'];
    masterName = json['master_name'];
    masterAvatar = json['master_avatar'];
    assetUnit = json['asset_unit'];
    accountAsset = json['account_asset'];
    profit = json['profit'];
    profitRatio = json['profit_ratio'];
    profitUnit = json['profit_unit'];
  }

  String? planId;
  String? followId;
  String? planName;
  String? masterName;
  String? masterAvatar;
  String? assetUnit;
  String? accountAsset;
  String? profit;
  String? profitRatio;
  String? profitUnit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['plan_id'] = planId;
    map['follow_id'] = followId;
    map['plan_name'] = planName;
    map['master_name'] = masterName;
    map['master_avatar'] = masterAvatar;
    map['asset_unit'] = assetUnit;
    map['account_asset'] = accountAsset;
    map['profit'] = profit;
    map['profit_ratio'] = profitRatio;
    map['profit_unit'] = profitUnit;
    return map;
  }
}

/// currency : "USDT"
/// icon : "http://s0.fbit.com/coin/USDT.png"
/// unit_amount : "33.93"
/// withdraw_available : "4.09507728"
/// frozen : "1.00000000"
/// trade_permission : 0
/// deposit_permission : 1
/// withdraw_permission : 0
/// transfer_permission : 1

class SpotEntity {
  SpotEntity({
    this.currency,
    this.icon,
    this.unitAmount,
    this.withdrawAvailable,
    this.frozen,
    this.tradePermission,
    this.depositPermission,
    this.withdrawPermission,
    this.transferPermission,
  });

  SpotEntity.fromJson(dynamic json) {
    currency = json['currency'];
    icon = json['icon'];
    unitAmount = json['unit_amount'];
    withdrawAvailable = json['withdraw_available'];
    frozen = json['frozen'];
    tradePermission = json['trade_permission'];
    depositPermission = json['deposit_permission'];
    withdrawPermission = json['withdraw_permission'];
    transferPermission = json['transfer_permission'];
  }

  String? currency;
  String? icon;
  String? unitAmount;
  String? withdrawAvailable;
  String? frozen;
  String? unit;
  num? tradePermission;
  num? depositPermission;
  num? withdrawPermission;
  num? transferPermission;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currency'] = currency;
    map['icon'] = icon;
    map['unit_amount'] = unitAmount;
    map['withdraw_available'] = withdrawAvailable;
    map['frozen'] = frozen;
    map['trade_permission'] = tradePermission;
    map['deposit_permission'] = depositPermission;
    map['withdraw_permission'] = withdrawPermission;
    map['transfer_permission'] = transferPermission;
    return map;
  }
}

/// btc_amount : "0.00349680"
/// unit_amount : "204.92"

class Balance {
  Balance({
    this.btcAmount,
    this.unitAmount,
  });

  Balance.fromJson(dynamic json) {
    btcAmount = json['btc_amount'];
    unitAmount = json['unit_amount'];
  }

  String? btcAmount;
  String? unitAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['btc_amount'] = btcAmount;
    map['unit_amount'] = unitAmount;
    return map;
  }
}
