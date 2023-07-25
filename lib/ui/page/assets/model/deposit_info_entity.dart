/// currency : ""
/// address : ""
/// address_memo : ""

class DepositInfoEntity {
  DepositInfoEntity({
      this.currency, 
      this.address, 
      this.addressMemo,});

  DepositInfoEntity.fromJson(dynamic json) {
    currency = json['currency'];
    address = json['address'];
    addressMemo = json['address_memo'];
  }
  String? currency;
  String? address;
  String? addressMemo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currency'] = currency;
    map['address'] = address;
    map['address_memo'] = addressMemo;
    return map;
  }

}