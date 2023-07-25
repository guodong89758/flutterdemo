import 'package:bitfrog/utils/object_util.dart';

class SymbolCurrencyEntity {
  SymbolCurrencyEntity({
    this.data,
    this.code,});

  SymbolCurrencyEntity.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SymbolCurrency.fromJson(v));
      });
    }
    code = json['code'];
  }
  static List<SymbolCurrency>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<SymbolCurrency> items = [];
    for (Map<String, dynamic> map in mapList) {
      items.add(SymbolCurrency.fromJson(map));
    }
    return items;
  }

  List<SymbolCurrency>? data;
  int? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['code'] = code;
    return map;
  }

}

class SymbolCurrency {
  SymbolCurrency({
    this.currency,
    this.icon,
    this.coin,
    this.balance,
    this.frozen,this.withdrawAvailable});

  SymbolCurrency.fromJson(dynamic json) {
    balance =
    json['balance'] != null ? Balance.fromJson(json['balance']) : null;
    frozen=  json['frozen'] != null ? Frozen.fromJson(json['frozen']) : null;
    withdrawAvailable=  json['withdraw_available'] != null ? WithdrawAvailable.fromJson(json['withdraw_available']) : null;
    currency = json['currency'];
    icon = json['icon'];
    coin= json['coin'];

  }

  String? currency;
  String? icon;
  String? coin;



  Balance? balance;
  Frozen? frozen;
  WithdrawAvailable? withdrawAvailable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (balance != null) {
      map['balance'] = balance?.toJson();
    }
    if (frozen != null) {
      map['frozen'] = frozen?.toJson();
    }
    if (withdrawAvailable != null) {
      map['withdraw_available'] = withdrawAvailable?.toJson();
    }

    map['currency'] = currency;
    map['icon'] = icon;
    map['coin'] = coin;


    return map;
  }

}
class Balance {
  Balance({
    this.amount,
    this.worth,
    this.usdt,

  });

  Balance.fromJson(dynamic json) {
    amount = json['amount'];
    worth = json['worth'];
    usdt = json['usdt'];

  }
  // "amount":"10",
  // "worth":"300",
  // "usdt":"300"
  String? amount;
  String? worth;
  String? usdt;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['worth'] = worth;
    map['usdt'] = usdt;

    return map;
  }
}
class Frozen {
  Frozen({
    this.amount,
    this.worth,
    this.usdt,
  });

  Frozen.fromJson(dynamic json) {
    amount = json['amount'];
    worth = json['worth'];
    usdt = json['usdt'];
  }

  String? amount;
  String? worth;
  String? usdt;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['worth'] = worth;
    map['usdt'] = usdt;

    return map;
  }
}
class WithdrawAvailable {
  WithdrawAvailable({
    this.amount,
    this.worth,
    this.usdt,

  });

  WithdrawAvailable.fromJson(dynamic json) {
    amount = json['amount'];
    worth = json['worth'];
    usdt = json['usdt'];

  }

  String? amount;
  String? worth;
  String? usdt;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['worth'] = worth;
    map['usdt'] = usdt;

    return map;
  }
}