import 'package:bitfrog/utils/json_transform_util.dart';
import 'package:common_utils/common_utils.dart';

/// currency : "USDT"
/// full_name : "TetherUS"
/// icon : "http://s0.fbit.com/coin/USDT.png"
/// chains : [{"network":"TRX","name":"Tron (TRC20)","withdraw_enable":1,"withdraw_min":"10.000000000000000000","withdraw_fee":"1.30000000","withdraw_desc":"<span>1.最小提币数量为：<span style=\"color: #E12525\">10USDT</span><br/>2.为了保证资金安全，我们会对提币进行人工审核，处理的时间节点分别是香港时间：10:00，16:00，23:00<br/>3. 修改登录密码后24小时内禁止提币</span>"}]
/// balance : "0.2107811"

class AssetCurrencyEntity {
  AssetCurrencyEntity({
      this.currency, 
      this.fullName, 
      this.icon, 
      this.chains, 
      this.balance,});

  AssetCurrencyEntity.fromJson(dynamic json) {
    currency = json['currency'];
    fullName = json['full_name'];
    icon = json['icon'];
    if (json['chains'] != null) {
      chains = [];
      json['chains'].forEach((v) {
        chains?.add(Chains.fromJson(v));
      });
    }
    balance = json['balance'];
  }
  String? currency;
  String? fullName;
  String? icon;
  List<Chains>? chains;
  String? balance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currency'] = currency;
    map['full_name'] = fullName;
    map['icon'] = icon;
    if (chains != null) {
      map['chains'] = chains?.map((v) => v.toJson()).toList();
    }
    map['balance'] = balance;
    return map;
  }

  static List<AssetCurrencyEntity>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<AssetCurrencyEntity> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(AssetCurrencyEntity.fromJson(map));
    }
    return items;
  }

}

/// network : "TRX"
/// name : "Tron (TRC20)"
/// withdraw_enable : 1
/// withdraw_min : "10.000000000000000000"
/// withdraw_fee : "1.30000000"
/// withdraw_desc : "<span>1.最小提币数量为：<span style=\"color: #E12525\">10USDT</span><br/>2.为了保证资金安全，我们会对提币进行人工审核，处理的时间节点分别是香港时间：10:00，16:00，23:00<br/>3. 修改登录密码后24小时内禁止提币</span>"

class Chains {
  Chains({
      this.network, 
      this.name,
      this.memo,
      this.depositEnable,
      this.depositMin,
      this.depositDesc,
      this.withdrawEnable,
      this.withdrawMin, 
      this.withdrawFee, 
      this.withdrawDesc,});

  Chains.fromJson(dynamic json) {
    network = json['network'];
    name = json['name'];
    memo = json['memo'];
    depositEnable = JsonTransformUtil.parseNum(json['deposit_enable']);
    depositMin = json['deposit_min'];
    depositDesc = json['deposit_desc'];
    withdrawEnable = JsonTransformUtil.parseNum(json['withdraw_enable']);
    withdrawMin = json['withdraw_min'];
    withdrawFee = json['withdraw_fee'];
    withdrawDesc = json['withdraw_desc'];
  }
  String? network;
  String? name;
  String? memo;
  num? depositEnable;
  String? depositMin;
  String? depositDesc;
  num? withdrawEnable;
  String? withdrawMin;
  String? withdrawFee;
  String? withdrawDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['network'] = network;
    map['name'] = name;
    map['memo'] = memo;
    map['deposit_enable'] = depositEnable;
    map['deposit_min'] = depositMin;
    map['deposit_desc'] = depositDesc;
    map['withdraw_enable'] = withdrawEnable;
    map['withdraw_min'] = withdrawMin;
    map['withdraw_fee'] = withdrawFee;
    map['withdraw_desc'] = withdrawDesc;
    return map;
  }

  static List<Chains>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<Chains> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(Chains.fromJson(map));
    }
    return items;
  }

}