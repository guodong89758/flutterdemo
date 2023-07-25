import 'package:bitfrog/ui/page/alert/model/subscribe_item_entity.dart';

class AlertTypeDetailEntity {
  AlertTypeDetailEntity({
    this.type,
    this.title,
    this.setPageDesc,
    this.data,
  });

  AlertTypeDetailEntity.fromJson(dynamic json) {
    type = json['type'];
    title = json['title'];
    setPageDesc = json['set_page_desc'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SubscribeItemEntity.fromJson(v));
      });
    }
  }

  String? type;
  String? title;
  String? setPageDesc;
  List<SubscribeItemEntity>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['title'] = title;
    map['set_page_desc'] = setPageDesc;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
