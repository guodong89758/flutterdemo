import 'package:bitfrog/ui/page/assets/model/asset_currency_entity.dart';
import 'package:bitfrog/utils/json_transform_util.dart';

class WithdrawInfoEntity {
  WithdrawInfoEntity({
      this.enable, 
      this.isMobile, 
      this.isEmail, 
      this.isGa, 
      this.enableMsg,
      this.list,});

  WithdrawInfoEntity.fromJson(dynamic json) {
    enable = JsonTransformUtil.parseNum(json['enable']);
    isMobile = JsonTransformUtil.parseNum(json['is_mobile']);
    isEmail = JsonTransformUtil.parseNum(json['is_email']);
    isGa = JsonTransformUtil.parseNum(json['is_ga']);
    enableMsg = json['enable_msg'];
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list?.add(AssetCurrencyEntity.fromJson(v));
      });
    }
  }
  num? enable;
  num? isMobile;
  num? isEmail;
  num? isGa;
  String? enableMsg;
  List<AssetCurrencyEntity>? list;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enable'] = enable;
    map['is_mobile'] = isMobile;
    map['is_email'] = isEmail;
    map['is_ga'] = isGa;
    map['enable_msg'] = enableMsg;
    if (list != null) {
      map['list'] = list?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}