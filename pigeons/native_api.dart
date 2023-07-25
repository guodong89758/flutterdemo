import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class NativeAppApi {
  /// 显示强提醒悬浮窗
  void showAlertFloat(String strAlertTime, String strBaseMonth, String strBaseDay, String strActionIgnore, String strActionCheck);
  /// 显示常驻通知栏
  void startDaemonService(String content, String state);
  /// 关闭常驻通知栏
  void stopDaemonService();
  /// 获取手机类型 0、其他 1、小米 2、华为 3、oppo 4、vivo
  int getDeviceType();
  /// 跳转各手机设置页
  void gotoSetView(int deviceType, int action);


  // bool

  void installApk(String path);

}

@FlutterApi()
abstract class NativeFlutterApi {
  /// 获取强提醒消息数量
  int getMessageCount();

  /// 关闭强提醒浮窗
  void dismissAlertFloat();

  /// 关闭强提醒铃声
  void stopAudioPlayer();

  /// 获取下一条强提醒消息
  String getNextMessage();

  /// 获取最新一条强提醒消息
  String getNewMessage();

  /// 删除最新一条强提醒消息
  void removeNewMessage();

  /// 内链跳转
  void linkView(String url);
}
