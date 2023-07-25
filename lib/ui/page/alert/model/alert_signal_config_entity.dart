import 'package:bitfrog/utils/json_transform_util.dart';

/// terms : [{"key":15,"title":"15min"},{"key":60,"title":"1H"},{"key":240,"title":"4H"},{"key":1440,"title":"24H"}]
/// indicators : [{"id":1,"name":"KDJ","icon":"http://hyd-analysis.oss-cn-hangzhou.aliyuncs.com/202212271804509ade145a.png","intro":"KDJ指标中文名叫随机指标，是一种相当新颖、实用的技术分析指标，它起先用于期货市场的分析，后被广泛用于股市的中短期趋势分析，是期货和股票市场上最常用的技术分析工具。","conditions":[{"id":2,"name":"突破KDJ下轨","params":[]}]},{"id":3,"name":"BOLL","icon":"http://hyd-analysis.oss-cn-hangzhou.aliyun\nflutter: FLUTTER-LOG e | cs.com/2022122718555918aba231.png","intro":"BOLL指标属于大趋势类指标，系统会为您发出预警。","conditions":[{"id":3,"name":"突破布林带上轨","params":[]},{"id":4,"name":"突破布林带下轨","params":[{"name":"abk","value":20}]}]},{"id":11,"name":"TD","icon":"","intro":"TD指标是个好东西","conditions":[{"id":5,"name":"超买","params":[{"name":"慢线周期","value":"12"}]}]}]

class AlertSignalConfigEntity {
  AlertSignalConfigEntity({
      List<Terms>? terms, 
      List<Indicators>? indicators,}){
    _terms = terms;
    _indicators = indicators;
}

  AlertSignalConfigEntity.fromJson(dynamic json) {
    if (json['terms'] != null) {
      _terms = [];
      json['terms'].forEach((v) {
        _terms?.add(Terms.fromJson(v));
      });
    }
    if (json['indicators'] != null) {
      _indicators = [];
      json['indicators'].forEach((v) {
        _indicators?.add(Indicators.fromJson(v));
      });
    }
  }
  List<Terms>? _terms;
  List<Indicators>? _indicators;

  List<Terms>? get terms => _terms;
  List<Indicators>? get indicators => _indicators;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_terms != null) {
      map['terms'] = _terms?.map((v) => v.toJson()).toList();
    }
    if (_indicators != null) {
      map['indicators'] = _indicators?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// name : "KDJ"
/// icon : "http://hyd-analysis.oss-cn-hangzhou.aliyuncs.com/202212271804509ade145a.png"
/// intro : "KDJ指标中文名叫随机指标，是一种相当新颖、实用的技术分析指标，它起先用于期货市场的分析，后被广泛用于股市的中短期趋势分析，是期货和股票市场上最常用的技术分析工具。"
/// conditions : [{"id":2,"name":"突破KDJ下轨","params":[]}]

class Indicators {
  Indicators({
      num? id, 
      String? name, 
      String? icon, 
      String? intro, 
      List<Conditions>? conditions,}){
    _id = id;
    _name = name;
    _icon = icon;
    _intro = intro;
    _conditions = conditions;
}

  Indicators.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _icon = json['icon'];
    _intro = json['intro'];
    if (json['conditions'] != null) {
      _conditions = [];
      json['conditions'].forEach((v) {
        _conditions?.add(Conditions.fromJson(v));
      });
    }
  }
  num? _id;
  String? _name;
  String? _icon;
  String? _intro;
  List<Conditions>? _conditions;

  num? get id => _id;
  String? get name => _name;
  String? get icon => _icon;
  String? get intro => _intro;
  List<Conditions>? get conditions => _conditions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['icon'] = _icon;
    map['intro'] = _intro;
    if (_conditions != null) {
      map['conditions'] = _conditions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 2
/// name : "突破KDJ下轨"
/// params : []

class Conditions {
  Conditions({
      num? id, 
      String? name, 
      List<Params>? params,}){
    _id = id;
    _name = name;
    _params = params;
}

  Conditions.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    if (json['params'] != null) {
      _params = [];
      json['params'].forEach((v) {
        _params?.add(Params.fromJson(v));
      });
    }
  }
  num? _id;
  String? _name;
  List<Params>? _params;
  bool checked = false;

  num? get id => _id;
  String? get name => _name;
  List<Params>? get params => _params;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    if (_params != null) {
      map['params'] = _params?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// key : 15
/// title : "15min"

class Terms {
  Terms({
      num? key, 
      String? title,}){
    _key = key;
    _title = title;
}

  Terms.fromJson(dynamic json) {
    _key = json['key'];
    _title = json['title'];
  }
  num? _key;
  String? _title;

  num? get key => _key;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = _key;
    map['title'] = _title;
    return map;
  }

}

class Params {
  Params({
    String? name,
    num? value,}){
    _name = name;
    _value = value;
  }

  Params.fromJson(dynamic json) {
    _name = json['name'];
    _value = JsonTransformUtil.parseNum(json['value']);
  }
  String? _name;
  num? _value;

  String? get name => _name;
  num? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['value'] = _value;
    return map;
  }

}