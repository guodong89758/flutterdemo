import 'package:bitfrog/utils/json_transform_util.dart';

/// data : [{"title":"exercitation amet sit commodo","image":"Lorem","url":"id minim tempor","target":56977262.820931286,"token":-54688796.930158645,"type":51581138.483721554,"sort":-56772815.774155736}]

class BannerEntity {
  BannerEntity({
      List<BannerModel>? data,}){
    _data = data;
}

  BannerEntity.fromJson(dynamic json) {
    if (json != null) {
      _data = [];
      json.forEach((v) {
        _data?.add(BannerModel.fromJson(v));
      });
    }
  }
  List<BannerModel>? _data;

  List<BannerModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// title : "exercitation amet sit commodo"
/// image : "Lorem"
/// url : "id minim tempor"
/// target : 56977262.820931286
/// token : -54688796.930158645
/// type : 51581138.483721554
/// sort : -56772815.774155736

class BannerModel {
  BannerModel({
      String? title, 
      String? image, 
      String? url,
    num? target,
    num? token,
    num? type,
    num? sort,}){
    _title = title;
    _image = image;
    _url = url;
    _target = target;
    _token = token;
    _type = type;
    _sort = sort;
}

  BannerModel.fromJson(dynamic json) {
    _title = json['title'];
    _image = json['image'];
    _url = json['url'];
    _target = JsonTransformUtil.parseNum(json['target']);
    _token = JsonTransformUtil.parseNum(json['token']);
    _type = JsonTransformUtil.parseNum(json['type']);
    _sort = JsonTransformUtil.parseNum(json['sort']);
  }
  String? _title;
  String? _image;
  String? _url;
  num? _target;
  num? _token;
  num? _type;
  num? _sort;

  String? get title => _title;
  String? get image => _image;
  String? get url => _url;
  num? get target => _target;
  num? get token => _token;
  num? get type => _type;
  num? get sort => _sort;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['image'] = _image;
    map['url'] = _url;
    map['target'] = _target;
    map['token'] = _token;
    map['type'] = _type;
    map['sort'] = _sort;
    return map;
  }

}