import 'package:bitfrog/utils/json_transform_util.dart';

///包装fluro路由传参
class Parameters {
  Map<String, dynamic> _map = {};

  _setValue(var k, var v) => _map[k] = v;

  _getValue(String k) {
    if (_map.containsKey(k)) {
      return _map[k];
    }
    //throw Exception("parameter:（$k）不存在，请检查");
  }

  putInt(String k, int v) => _setValue(k, v);

  putDouble(String k, double v) => _setValue(k, v);

  putString(String k, String v) => _setValue(k, v);

  putBool(String k, bool v) => _setValue(k, v);

  putList<V>(String k, List<V> v) => _setValue(k, v);

  putObj<O>(String k, O v) => _setValue(k, v);

  putMap<K, V>(String k, Map<K, V> v) => _setValue(k, v);

  int? getInt(String k) => _getValue(k) as int?;

  double? getDouble(String k) => _getValue(k) as double?;

  String? getString(String k) => _getValue(k) as String?;

  bool? getBool(String k) => _getValue(k) as bool?;

  O? getObj<O>(String k) => _getValue(k) as O?;

  List? getList(String k) => _getValue(k) as List?;

  Map? getMap(String k) => _getValue(k) as Map?;

  // 安全的 避免类型转换错误
  int? getSafeInt(String k) => JsonTransformUtil.parseNum(_getValue(k))?.toInt();

  List? getSafeList(String k) => JsonTransformUtil.transformList(_getValue(k));

  @override
  String toString() {
    return 'Parameters{_map: ${_map.toString()}';
  }
}
