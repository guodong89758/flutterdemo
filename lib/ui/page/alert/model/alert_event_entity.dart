import 'package:bitfrog/utils/json_transform_util.dart';

class AlertEventEntity {
  AlertEventEntity({
    this.count,
    this.data,});

  AlertEventEntity.fromJson(dynamic json) {
    count = json['count'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AlertEvent.fromJson(v));
      });
    }
  }
  int? count;
  List<AlertEvent>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class AlertEvent {
  AlertEvent({
    this.id,
    this.title,
    this.content,
    this.subscribeType,
    this.subscribeKey,
    this.isShowSubscribe,
    this.isSubscribedirectly,
    this.timestamp,this.images,});

  AlertEvent.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    subscribeType = json['subscribe_type'];
    subscribeKey = json['subscribe_key'];
    isShowSubscribe = json['is_show_subscribe'];
    isSubscribedirectly = json['is_subscribe_directly'];
    // images = json['images'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(v);
      });
    }

    timestamp = JsonTransformUtil.parseNum(json['timestamp']);

  }
  int? id;//事件ID
  String? title;//标题
  String? content;//内容
  String? subscribeType;//订阅类型，跳转设置页需要此参数
  String? subscribeKey;//订阅key，当类型只有一个订阅项时此字段不为空
  num? isShowSubscribe;//是否展示订阅按钮 0 不展示 1 展示
  num? isSubscribedirectly;//是否直接订阅 0 否 1 是
  num? timestamp;//时间戳
  num isSubscribe = 0;
  List<dynamic>?  images = [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['content'] = content;
    map['subscribe_type'] = subscribeType;
    map['subscribe_key'] = subscribeKey;
    map['is_show_subscribe'] = isShowSubscribe;
    map['is_subscribe_directly'] = isSubscribedirectly;
    map['timestamp'] = timestamp;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}