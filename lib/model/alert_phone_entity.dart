class AlertPhoneEntity {
  AlertPhoneEntity({
    this.userMobile,
    this.voiceAmount,
    this.subscribes,
  });

  AlertPhoneEntity.fromJson(dynamic json) {
    userMobile = json['user_mobile'];
    voiceAmount = json['voice_amount'];
    if (json['subscribes'] != null) {
      subscribes = [];
      json['subscribes'].forEach((v) {
        subscribes?.add(PhoneType.fromJson(v));
      });
    }
  }

  String? userMobile;
  int? voiceAmount;
  List<PhoneType>? subscribes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_mobile'] = userMobile;
    map['voice_amount'] = voiceAmount;
    if (subscribes != null) {
      map['subscribes'] = subscribes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class PhoneType {
  PhoneType({
    this.type,
    this.title,
    this.icon,
    this.desc,
    this.items,
  });

  PhoneType.fromJson(dynamic json) {
    type = json['type'];
    title = json['title'];
    icon = json['icon'];
    desc = json['desc'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(PhoneItem.fromJson(v));
      });
    }
  }

  String? type;
  String? title;
  String? icon;
  String? desc;
  List<PhoneItem>? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['title'] = title;
    map['icon'] = icon;
    map['desc'] = desc;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class PhoneItem {
  PhoneItem({
    this.id,
    this.title,
    this.content,
    this.phoneSwitch,
    this.isRepeat,
  });

  PhoneItem.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    phoneSwitch = json['switch'];
    isRepeat = json['is_repeat'];
  }

  int? id;
  String? title;
  String? content;
  int? phoneSwitch;
  int? isRepeat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['content'] = content;
    map['switch'] = phoneSwitch;
    map['is_repeat'] = isRepeat;
    return map;
  }
}
