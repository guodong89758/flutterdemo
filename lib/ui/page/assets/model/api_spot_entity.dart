import 'package:bitfrog/utils/json_transform_util.dart';

class ApiSpotEntity {
  ApiSpotEntity({
      this.usdt, 
      this.worth, 
      this.coin, 
      this.assets,});

  ApiSpotEntity.fromJson(dynamic json) {
    usdt = json['usdt'];
    worth = json['worth'];
    coin = json['coin'];
    unpnl = json['unpnl'] != null ? WithdrawAvailable.fromJson(json['unpnl']) : null;
    magin = json['magin'] != null ? WithdrawAvailable.fromJson(json['magin']) : null;
    wallet = json['wallet'] != null ? WithdrawAvailable.fromJson(json['wallet']) : null;
    assets = JsonTransformUtil.transformList(json['assets'])
        .map((e) => Assets.fromJson(e))
        .toList();
  }

  String? usdt;
  String? worth;
  String? coin;
  List<Assets>? assets;
  WithdrawAvailable? unpnl;
  WithdrawAvailable? magin;
  WithdrawAvailable? wallet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['usdt'] = usdt;
    map['worth'] = worth;
    map['coin'] = coin;
    if (assets != null) {
      map['assets'] = assets?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class Assets {
  Assets({
    this.currency,
    this.icon,
    this.coin,
    this.balance,
    this.frozen,
    this.withdrawAvailable,
    this.withdrawAvailableValue,
  });

  Assets.fromJson(dynamic json) {
    currency = json['currency'];
    icon = json['icon'];
    coin = json['coin'];
    balance =
        json['balance'] != null ? Balance.fromJson(json['balance']) : null;
    frozen = json['frozen'] != null ? Frozen.fromJson(json['frozen']) : null;
    final withdrawJson = json['withdraw_available'];
    if (withdrawJson is Map<String, dynamic>) {
      withdrawAvailable = WithdrawAvailable.fromJson(withdrawJson);
    } else {
      withdrawAvailableValue = withdrawJson.toString();
    }
  }

  String? currency;
  String? icon;
  String? coin;
  Balance? balance;
  Frozen? frozen;
  WithdrawAvailable? withdrawAvailable;
  String? withdrawAvailableValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currency'] = currency;
    map['icon'] = icon;
    map['coin'] = coin;
    if (balance != null) {
      map['balance'] = balance?.toJson();
    }
    if (frozen != null) {
      map['frozen'] = frozen?.toJson();
    }
    map['withdraw_available'] = withdrawAvailable;
    return map;
  }

}
class Balance {
  Balance({
    this.amount,
    this.worth,
    this.coin,
    this.usdt,});

  Balance.fromJson(dynamic json) {
    amount = json['amount'];
    worth = json['worth'];
    coin = json['coin'];
    usdt = json['usdt'];
  }
  String? amount;
  String? worth;
  String? coin;
  String? usdt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['worth'] = worth;
    map['coin'] = coin;
    map['usdt'] = usdt;
    return map;
  }

}

class Frozen {
  Frozen({
    this.amount,
    this.worth,
    this.coin,
    this.usdt,});

  Frozen.fromJson(dynamic json) {
    amount = json['amount'];
    worth = json['worth'];
    coin = json['coin'];
    usdt = json['usdt'];
  }
  String? amount;
  String? worth;
  String? coin;
  String? usdt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['worth'] = worth;
    map['coin'] = coin;
    map['usdt'] = usdt;
    return map;
  }

}
class WithdrawAvailable {
  WithdrawAvailable({
    this.amount,
    this.worth,
    this.coin,
    this.usdt,});

  WithdrawAvailable.fromJson(dynamic json) {
    amount = json['amount'];
    worth = json['worth'];
    coin = json['coin'];
    usdt = json['usdt'];
  }
  String? amount;
  String? worth;
  String? coin;
  String? usdt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['worth'] = worth;
    map['coin'] = coin;
    map['usdt'] = usdt;
    return map;
  }

}
