class AlertHistoryEntity {
  AlertHistoryEntity({
      this.count, 
      this.data,});

  AlertHistoryEntity.fromJson(dynamic json) {
    count = json['count'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(History.fromJson(v));
      });
    }
  }
  int? count;
  List<History>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class History {
  History({
      this.id, 
      this.icon,
      this.title,
      this.content, 
      this.type,
      this.appPush,
      this.voicePush, 
      this.voiceStatus, 
      this.voiceStatusDesc,
      this.createTime, 
      this.timestamp,});

  History.fromJson(dynamic json) {
    id = json['id'];
    icon = json['icon'];
    title = json['title'];
    content = json['content'];
    type = json['type'];
    appPush = json['app_push'];
    voicePush = json['voice_push'];
    voiceStatus = json['voice_status'];
    voiceStatusDesc = json['voice_status_desc'];
    createTime = json['create_time'];
    timestamp = json['timestamp'];
  }
  String? id;//提醒历史id
  String? icon;//图标
  String? title;//标题
  String? content;//内容
  String? type;//消息类型
  int? appPush;//是否APP推送，1是0否
  int? voicePush;//是否语音推送，1是0否
  int? voiceStatus;//语音推送状态 0待拨号 1拨号中 2已拨通 3未拨通
  String? voiceStatusDesc;//语音推送状态描述
  String? createTime;//创建时间（格式化过）
  int? timestamp;//创建时间戳
  num? isSubscribe = 0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['icon'] = icon;
    map['title'] = title;
    map['content'] = content;
    map['type'] = type;
    map['app_push'] = appPush;
    map['voice_push'] = voicePush;
    map['voice_status'] = voiceStatus;
    map['voice_status_desc'] = voiceStatusDesc;
    map['create_time'] = createTime;
    map['timestamp'] = timestamp;
    return map;
  }

}