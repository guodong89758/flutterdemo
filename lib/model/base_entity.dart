import '../utils/object_util.dart';

class BaseEntity<T> {
  int? code;
  String? msg;
  T? data;

  BaseEntity({this.code, this.msg, this.data});

  BaseEntity.fromJson(Map<String, dynamic> jsonMap) {
    code = jsonMap["code"];
    msg = jsonMap["msg"];
    if (jsonMap.containsKey('data') && !ObjectUtil.isEmpty(jsonMap['data'])) {
      data = generateOBJ<T>(jsonMap['data']);
    }
  }

  T? generateOBJ<T>(json) {
    if (json == null) {
      return null;
    } else if (T.toString() == 'String') {
      return json.toString() as T;
    } else {
      return json as T;
    }
  }
}
