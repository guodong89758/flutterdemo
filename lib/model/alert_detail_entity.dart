import 'package:bitfrog/utils/json_transform_util.dart';

class AlertDetailEntity {
  AlertDetailEntity({
      this.type,
      this.title,
      this.content,
      this.createTime, 
      this.bottomTips1, 
      this.bottomTips2, 
      this.qrCodeUrl, this.images,});

  AlertDetailEntity.fromJson(dynamic json) {
    type = json['type'];
    title = json['title'];
    content = json['content'];
    createTime = json['create_time'];
    bottomTips1 = json['bottom_tips_1'];
    bottomTips2 = json['bottom_tips_2'];
    qrCodeUrl = json['qr_code_url'];
    timestamp = JsonTransformUtil.parseNum(json['timestamp']);
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(v);
      });
    }
  }
  String? type;
  String? title;
  String? content;
  String? createTime;
  String? bottomTips1;
  String? bottomTips2;
  String? qrCodeUrl;
  num? timestamp;
  // List<dynamic>?  images = ["https://img1.baidu.com/it/u=413643897,2296924942&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1685638800&t=2b06ffbb4f37b3c5a70b0f9220cca01c","https://img0.baidu.com/it/u=3425868493,3104015061&fm=253&app=120&size=w931&n=0&f=JPEG&fmt=auto?sec=1685638800&t=0f0dae6aa4a86203177a74a29dced35b"];
  List<dynamic>?  images =[];
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['title'] = title;
    map['content'] = content;
    map['create_time'] = createTime;
    map['bottom_tips_1'] = bottomTips1;
    map['bottom_tips_2'] = bottomTips2;
    map['qr_code_url'] = qrCodeUrl;

    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}