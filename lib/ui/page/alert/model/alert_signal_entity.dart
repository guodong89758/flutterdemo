import 'package:bitfrog/utils/json_transform_util.dart';

/// count : -42157082
/// data : {"id":-84555861,"voice_status":39159475,"voice_push":-429342,"app_push":32398009,"timestamp":-60655177,"content":"magna mollit deserunt eiusmod","voice_status_desc":"non aliquip officia magna"}

class AlertSignalDataEntity {
  AlertSignalDataEntity({
      num? count,
    List<AlertSignalEntity>? data,}){
    _count = count;
    _data = data;
}

  AlertSignalDataEntity.fromJson(dynamic json) {
    if (json != null) {
      _data = [];
      json.forEach((v) {
        _data?.add(AlertSignalEntity.fromJson(v));
      });
    }
  }
  num? _count;
  List<AlertSignalEntity> ? _data;

  num? get count => _count;
  List<AlertSignalEntity>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : -84555861
/// voice_status : 39159475
/// voice_push : -429342
/// app_push : 32398009
/// timestamp : -60655177
/// content : "magna mollit deserunt eiusmod"
/// voice_status_desc : "non aliquip officia magna"

class AlertSignalEntity {
  AlertSignalEntity({
      num? id, 
      num? voiceStatus, 
      num? voicePush, 
      num? appPush, 
      num? timestamp, 
      String? content,
    String? title,
    String? voiceStatusDesc,}){
    _id = id;
    _voiceStatus = voiceStatus;
    _voicePush = voicePush;
    _appPush = appPush;
    _timestamp = timestamp;
    _content = content;
    _title= title;
    _voiceStatusDesc = voiceStatusDesc;
}

  AlertSignalEntity.fromJson(dynamic json) {
    _id = json['id'];
    _voiceStatus = json['voice_status'];
    _voicePush = json['voice_push'];
    _appPush = json['app_push'];
    _timestamp = JsonTransformUtil.parseNum(json['timestamp']);
    _content = json['content'];
    _title = json['title'];
    _voiceStatusDesc = json['voice_status_desc'];
  }
  num? _id;
  num? _voiceStatus;
  num? _voicePush;
  num? _appPush;
  num? _timestamp;
  String? _content;
  String? _title;
  String? _voiceStatusDesc;

  num? get id => _id;
  num? get voiceStatus => _voiceStatus;
  num? get voicePush => _voicePush;
  num? get appPush => _appPush;
  num? get timestamp => _timestamp;
  String? get content => _content;
  String? get title => _title;
  String? get voiceStatusDesc => _voiceStatusDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['voice_status'] = _voiceStatus;
    map['voice_push'] = _voicePush;
    map['app_push'] = _appPush;
    map['timestamp'] = _timestamp;
    map['content'] = _content;
    map['voice_status_desc'] = _voiceStatusDesc;
    return map;
  }

}