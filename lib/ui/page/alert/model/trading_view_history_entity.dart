import 'package:bitfrog/utils/json_transform_util.dart';

class TradingHistoryEventEntity {
  TradingHistoryEventEntity({
    this.count,
    this.data,});

  TradingHistoryEventEntity.fromJson(dynamic json) {
    count = json['count'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(HistoryEvent.fromJson(v));
      });
    }
  }
  int? count;
  List<HistoryEvent>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class HistoryEvent {
  HistoryEvent({
    this.id,
    this.title,
    this.content,
    this.app_push,
    this.alert_push,
    this.voice_push,
    this.voice_status,
    this.voice_status_desc,
    this.timestamp});

  HistoryEvent.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    timestamp = JsonTransformUtil.parseNum(json['timestamp']);
    app_push = JsonTransformUtil.parseNum(json['app_push']);
    voice_push = JsonTransformUtil.parseNum(json['voice_push']);
    voice_push = JsonTransformUtil.parseNum(json['voice_push']);
    voice_status = JsonTransformUtil.parseNum(json['voice_status']);

    voice_status_desc = json['voice_status_desc'];

  }
  String? id;//事件ID
  String? title;//标题
  String? content;//内容
  num? timestamp;//时间戳
  num isSubscribe = 0;

  num? app_push;
  num? alert_push;//订阅类型，跳转设置页需要此参数
  num? voice_push;//订阅key，当类型只有一个订阅项时此字段不为空
  num? voice_status;//是否展示订阅按钮 0 不展示 1 展示
  String? voice_status_desc;//是否展示订阅按钮 0 不展示 1 展示



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['content'] = content;
    map['timestamp'] = timestamp;


    map['app_push'] = app_push;
    map['alert_push'] = alert_push;
    map['voice_push'] = voice_push;
    map['voice_status'] = voice_status;
    map['voice_status_desc'] =   voice_status_desc;


    return map;
  }

}