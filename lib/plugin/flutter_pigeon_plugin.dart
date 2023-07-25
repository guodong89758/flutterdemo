import 'dart:convert';
import 'dart:io';

import 'package:bitfrog/api/native_api.dart';
import 'package:bitfrog/app/build_config.dart';
import 'package:bitfrog/constant/config.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/logic/link_manger.dart';
import 'package:bitfrog/logic/strong_remind_manger.dart';
import 'package:bitfrog/model/push_entity.dart';
import 'package:bitfrog/model/user_info_entity.dart';
import 'package:bitfrog/utils/audio_play_util.dart';
import 'package:bitfrog/utils/device_util.dart';
import 'package:bitfrog/utils/log_utils.dart';
import 'package:bitfrog/utils/sp_util.dart';
import 'package:bitfrog/utils/user_util.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class FlutterPigeonPlugin extends NativeFlutterApi {
  static final NativeAppApi _appApi = NativeAppApi();

  factory FlutterPigeonPlugin() => _getInstance();

  static FlutterPigeonPlugin get instance => _getInstance();

  static FlutterPigeonPlugin? _instance = null;

  static FlutterPigeonPlugin _getInstance() {
    _instance ??= FlutterPigeonPlugin._internal();
    NativeFlutterApi.setup(_instance);
    return _instance!;
  }

  FlutterPigeonPlugin._internal();

  initConfig() async {
    initRoutePath = "/";
    bitfrogDomain = "https://bitfrog.liuning.cc/";

    /// 正式
    bitfrogDomain = buildConfig.baseUrl;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.packageName;
    deviceId = await DeviceUtil.deviceId();
    market = "";
    version = packageInfo.version;
    model = await DeviceUtil.systemName();
    systemVersion = await DeviceUtil.systemVersion();
    String? token = UserUtil.getUserToken();
    userToken = token;

    String? uid = UserUtil.getUserUid();
    userInfo = UserInfo(uid: uid);

  }

  /// 初始化域名
  String? initRoutePath;

  /// bitfrog域名
  String? bitfrogDomain;

  /// 应用包名或bundleid
  String? appName;

  /// 设备唯一ID
  String? deviceId;

  /// 应用渠道
  String? market;

  /// 应用版本
  String? version;

  /// 设备型号
  String? model;

  /// 系统版本
  String? systemVersion;

  // /// APP选择的语言
  // String? language;

  /// 用户token
  String? userToken;

  /// 设备ua
  String? userAgent;

  /// 推送ID
  String? jpushId;

  /// APP下载地址
  String? downloadUrl;

  /// 分享域名
  String? shareDomainName;

  /// 设备类型
  int? deviceType;//0、其他 1、小米 2、华为 3、oppo 4、vivo

  /// 用户信息
  UserInfo? userInfo;

  void getDeviceType() async {
    deviceType = await _appApi.getDeviceType();
  }

  String getUid() {
    if (userInfo == null) {
      return '';
    }
    return userInfo?.uid ?? '';
  }

  /// 判断是否登录
  bool isLogin() {
    String? userToken = UserUtil.getUserToken();
    return userToken != null && userToken.isNotEmpty;
  }

  /// 显示常驻通知栏通知
  Future<void> startDaemonService(String state) async {
    var notifyService = SpUtil.getBool(Config.keySwitchNotifyService) ?? false;
    if(!notifyService){
      return;
    }
    var status = await Permission.notification.status;
    if (!status.isGranted) {
      return;
    }
    await _appApi.startDaemonService(S.current.notify_set_text_1, state);
  }

  /// 关闭常驻通知栏通知
  Future<void> stopDaemonService() async {
    await _appApi.stopDaemonService();
  }

  /// 跳转各手机设置页
  Future<void> gotoSetView(int deviceType, int action) async {
    await _appApi.gotoSetView(deviceType, action);
  }

  /// 显示强提醒浮窗
  Future<void> showAlertFloat() async {
    await _appApi.showAlertFloat(S.current.alert_time, S.current.base_month,
        S.current.base_day1, S.current.action_ignore, S.current.action_check);
    AudioPlayUtil.instance.playAlert();
  }

  @override
  void dismissAlertFloat() {
    Log.d("dismissAlertFloat");
    AudioPlayUtil.instance.stop();
  }

  @override
  int getMessageCount() {
    int count = StrongRemindManger.instance.pushEntityList.length;
    Log.d("message count $count");
    return count;
  }

  @override
  String getNextMessage() {
    Log.d("getNextMessage");
    if (StrongRemindManger.instance.pushEntityList.isEmpty) {
      return '';
    }
    PushEntity message = StrongRemindManger.instance.pushEntityList.removeAt(0);
    return jsonEncode(message.toJson());
  }

  @override
  String getNewMessage() {
    Log.d("getNewMessage");
    if (StrongRemindManger.instance.pushEntityList.isEmpty) {
      return '';
    }
    PushEntity message = StrongRemindManger.instance.pushEntityList[0];
    return jsonEncode(message.toJson());
  }

  @override
  void removeNewMessage() {
    Log.d("removeNewMessage");
    if (StrongRemindManger.instance.pushEntityList.isEmpty) {
      return;
    }
    StrongRemindManger.instance.pushEntityList.removeAt(0);
  }

  @override
  void linkView(String url) {
    LinkManger.schemeJumpUrl(url);
  }

  @override
  void stopAudioPlayer() {
    AudioPlayUtil.instance.stop();
  }
}
