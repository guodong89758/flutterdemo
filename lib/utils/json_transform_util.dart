class JsonTransformUtil {
  JsonTransformUtil._();

  static List<dynamic> transformList(dynamic json) =>
      (json is List<dynamic>) ? json : [];

  static List<dynamic> transformListByKey(
    dynamic json, {
    required String listKey,
  }) {
    if (json is Map<String, dynamic>) {
      return transformList(json[listKey]);
    } else {
      return [];
    }
  }

  static T? parseObj<T>(dynamic json, T Function(dynamic json) parse) {
    if (json == null) {
      return null;
    } else {
      return parse.call(json);
    }
  }

  static int? parseInt(dynamic value) {
    return parseNum(value)?.toInt();
  }

  static num? parseNum(dynamic value) {
    if (value is String) {
      return num.tryParse(value);
    } else if (value is num) {
      return value;
    } else {
      return null;
    }
  }

  /// 用于需要确保num不为空情况下的解析，若数据存在问题会抛出异常
  static num parseNumNotNull(dynamic value) {
    if (value is num) {
      return value;
    }
    return num.parse(value.toString());
  }

  static int? parseColor(dynamic value) {
    if (value is String) {
      final color = value.replaceAll('#', '');
      return int.parse('0xff$color');
    } else if (value is num) {
      return value.toInt();
    } else {
      return null;
    }
  }
}
