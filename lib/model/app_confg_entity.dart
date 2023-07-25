/// telegram_url : "https://t.me/+E4RcZEhc9bY0OTc1"
/// facebook_url : "https://www.facebook.com/profile.php?id=100082111118415"
/// twitter_url : "https://twitter.com/frogbit2"
/// service : "https://bitfrog.zendesk.com/hc/zh-tw/articles/5469469404701-%E7%94%A8%E6%88%B6%E5%8D%94%E8%AD%B0"
/// agreement : "https://bitfrog.zendesk.com/hc/zh-tw/articles/5468696039453-%E9%9A%B1%E7%A7%81%E5%8D%94%E8%AD%B0"
/// help : "https://bitfrog.zendesk.com/hc/en-hk"
/// apply_master_url : "http://test.myaqi.cn/zh-CN/applyTrader/h5"
/// follow_course : "https://bitfrog.zendesk.com/hc/zh-tw/articles/7146361823645-%E8%B7%9F%E5%96%AE%E6%93%8D%E4%BD%9C%E6%8C%87%E5%8D%97-APP-"
/// apply_plan_url : "http://test.myaqi.cn/zh-CN/createProject/h5"
/// api_access_url : "http://test.myaqi.cn/zh-CN/useApi/h5"
/// master_problem_url : "https://bitfrog.zendesk.com/hc/zh-tw/articles/6918084545181-%E5%B8%B6%E5%96%AE%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A0%85"
/// bitforg_web_host : "http://test.myaqi.cn"
/// alarm_agreement_url : "https://bitfrog.zendesk.com/hc/zh-tw/articles/6654174059293-%E8%AA%9E%E9%9F%B3%E6%8F%90%E9%86%92%E6%9C%8D%E5%8B%99%E5%8D%94%E8%AD%B0"
/// download_url : "http://a221208.vomee.top/?refer=sogpog"
/// join_community_url : "https://t.me/+E4RcZEhc9bY0OTc1"
/// device_test_url : "http://test.myaqi.cn/zh-CN/networkTest_h5"
/// voice_show_number : "+86057156368329"
/// share_domain_name : "BitFrog.io"
/// home_button_list	object []
/// 必须
/// 个人中心需要展示的button列表[【v2.5新增】
/// item 类型: object
//
/// key	string
/// 必须
/// button唯一标识
/// icon	string
///必须
/// button的icon地址
///title	string
/// 必须
/// button标题
/// url	string
/// 必须
/// button跳转地址
/// status	string
/// 必须
/// 状态(服务端用，客户端不用管)
/// token	string
/// 必须
/// 是否携带token，1是0否

class AppConfigEntity {
  AppConfigEntity({
      this.telegramUrl, 
      this.facebookUrl, 
      this.twitterUrl, 
      this.service, 
      this.agreement, 
      this.help, 
      this.applyMasterUrl, 
      this.followCourse, 
      this.applyPlanUrl, 
      this.apiAccessUrl, 
      this.masterProblemUrl, 
      this.bitforgWebHost, 
      this.alarmAgreementUrl, 
      this.downloadUrl,
      this.hostName,
      this.joinCommunityUrl, 
      this.deviceTestUrl, 
      this.voiceShowNumber, 
      this.shareDomainName,this.invitationurl,this.usertvcourseurl,});

  AppConfigEntity.fromJson(dynamic json) {
    telegramUrl = json['telegram_url'];
    facebookUrl = json['facebook_url'];
    twitterUrl = json['twitter_url'];
    service = json['service'];
    agreement = json['agreement'];
    help = json['help'];
    applyMasterUrl = json['apply_master_url'];
    followCourse = json['follow_course'];
    applyPlanUrl = json['apply_plan_url'];
    apiAccessUrl = json['api_access_url'];
    masterProblemUrl = json['master_problem_url'];
    bitforgWebHost = json['bitforg_web_host'];
    alarmAgreementUrl = json['alarm_agreement_url'];
    downloadUrl = json['download_url'];
    hostName = json['host_name'];
    joinCommunityUrl = json['join_community_url'];
    deviceTestUrl = json['device_test_url'];
    voiceShowNumber = json['voice_show_number'];
    shareDomainName = json['share_domain_name'];
    onlineService = json['online_service'];
    invitationurl = json['invitation_url'];
    usertvcourseurl = json['user_tv_course_url'];
    areaCode = json['area_code'];
    areaCodeRegister = json['area_code_register'];

    if (json['home_button_list'] != null) {
      homebuttonlist = [];
      json['home_button_list'].forEach((v) {
        homebuttonlist?.add(HomeButton.fromJson(v));
      });
    }


  }
  String? telegramUrl;
  String? facebookUrl;
  String? twitterUrl;
  String? service;
  String? agreement;
  String? help;
  String? applyMasterUrl;
  String? followCourse;
  String? applyPlanUrl;
  String? apiAccessUrl;
  String? masterProblemUrl;
  String? bitforgWebHost;
  String? alarmAgreementUrl;
  String? downloadUrl;
  String? hostName;
  String? joinCommunityUrl;
  String? deviceTestUrl;
  String? voiceShowNumber;
  String? shareDomainName;
  String? onlineService;
  String? invitationurl;
  String? usertvcourseurl;
  // List<HomeButton> homebuttonlist =[];
  List<HomeButton>? homebuttonlist;
  String? areaCode;
  String? areaCodeRegister;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['telegram_url'] = telegramUrl;
    map['facebook_url'] = facebookUrl;
    map['twitter_url'] = twitterUrl;
    map['service'] = service;
    map['agreement'] = agreement;
    map['help'] = help;
    map['apply_master_url'] = applyMasterUrl;
    map['follow_course'] = followCourse;
    map['apply_plan_url'] = applyPlanUrl;
    map['api_access_url'] = apiAccessUrl;
    map['master_problem_url'] = masterProblemUrl;
    map['bitforg_web_host'] = bitforgWebHost;
    map['alarm_agreement_url'] = alarmAgreementUrl;
    map['download_url'] = downloadUrl;
    map['join_community_url'] = joinCommunityUrl;
    map['device_test_url'] = deviceTestUrl;
    map['voice_show_number'] = voiceShowNumber;
    map['share_domain_name'] = shareDomainName;
    map['online_service'] = onlineService;
    map['invitation_url'] = invitationurl;
     map['user_tv_course_url'] =  usertvcourseurl;
    if (homebuttonlist != null) {
      map['home_button_list'] = homebuttonlist?.map((v) => v.toJson()).toList();
    }

    return map;
  }

}
class HomeButton {
  HomeButton({
    this.key,
    this.icon,
    this.title,
    this.url,
    this.status,
    this.token,

  });



  HomeButton.fromJson(dynamic json) {
    key = json['key'];
    icon = json['icon'];
    url = json['url'];
    title = json['title'];
    status = json['status'];
    token = json['token'];

  }

  String? key;
  String? icon;
  String? title;
  String? url;
  int? status;
  int? token	;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = key;
    map['icon'] = icon;
    map['url'] = url;
    map['title'] = title;
    map['status'] = status;
    map['token'] = token;

    return map;
  }
}
