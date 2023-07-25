
class AccessTraderAccountEntity {
  AccessTraderAccountEntity({
    this.ip_white_list,
    this.course_url,
    this.exchangeList,
    this.accountTypeList,
  });

  AccessTraderAccountEntity.fromJson(dynamic json) {
    course_url = json['course_url'];
    ip_white_list = json['ip_white_list'];


    if (json['exchange_list'] != null) {
      exchangeList = [];
      json['exchange_list'].forEach((v) {
        exchangeList?.add(ExchangeEntity.fromJson(v));
      });
    }
    if (json['account_type_list'] != null) {
      accountTypeList = [];
      json['account_type_list'].forEach((v) {
        accountTypeList?.add(AccountTypeEntity.fromJson(v));
      });
    }
  }

  String? ip_white_list;
  String? course_url;
  List<ExchangeEntity>? exchangeList;
  List<AccountTypeEntity>? accountTypeList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ip_white_list'] = ip_white_list;
    map['course_url'] = course_url;


    if (exchangeList != null) {
      map['exchange_list'] = exchangeList?.map((v) => v.toJson()).toList();
    }
    if (accountTypeList != null) {
      map['account_type_list'] = accountTypeList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class AccountTypeEntity {
  AccountTypeEntity(
      {this.title,
        this.accountType,
       });

  AccountTypeEntity.fromJson(dynamic json) {
    title = json['title'];
    accountType = json['account_type'];

  }

  String? title;
  String? accountType;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['account_type'] = accountType;

    return map;
  }
}


class ExchangeEntity {
  ExchangeEntity({
    this.exchange,
    this.exchangeIcon,
    this.title,
    this.tip,
    this.desc,
    this.exchange_uid_course_img,


  });

  ExchangeEntity.fromJson(dynamic json) {
    exchange = json['exchange'];
    exchangeIcon = json['exchange_icon'];
    title = json['title'];
    tip = json['tip'];
    desc = json['desc'];
    exchange_uid_course_img = json['exchange_uid_course_img'];


  }

  String? exchange;
  String? exchangeIcon;
  String? title;
  String? tip;
  String? desc;
  String? exchange_uid_course_img;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['exchange'] = exchange;
    map['exchange_icon'] = exchangeIcon;
    map['title'] = title;
    map['tip'] = tip;
    map['desc'] = desc;
    map['exchange_uid_course_img'] = exchange_uid_course_img;

    return map;
  }
}
