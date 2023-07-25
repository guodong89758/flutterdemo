import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceUtil {
  static bool get isDesktop => !isWeb && (isWindows || isLinux || isMacOS);

  static bool get isMobile => isAndroid || isIOS;

  static bool get isWeb => kIsWeb;

  static bool get isWindows =>
      (defaultTargetPlatform == TargetPlatform.windows);

  static bool get isLinux => (defaultTargetPlatform == TargetPlatform.linux);

  static bool get isMacOS => (defaultTargetPlatform == TargetPlatform.macOS);

  static bool get isAndroid =>
      (defaultTargetPlatform == TargetPlatform.android);

  static bool get isFuchsia =>
      (defaultTargetPlatform == TargetPlatform.fuchsia);

  static bool get isIOS => (defaultTargetPlatform == TargetPlatform.iOS);

//  static bool get isWindows => Platform.isWindows;
//  static bool get isLinux => Platform.isLinux;
//  static bool get isMacOS => Platform.isMacOS;
//  static bool get isAndroid => Platform.isAndroid;
//  static bool get isFuchsia => Platform.isFuchsia;
//  static bool get isIOS => Platform.isIOS;

  static Future<String?> deviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.model; // unique ID on Android
    }
  }

  static Future<String?> systemName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.systemName; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.model; // unique ID on Android
    }
  }

  static Future<String?> systemVersion() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.systemVersion; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.version.release; // unique ID on Android
    }
  }

  static Future<String?> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }

  static Future<String?> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}

enum Devices {
  xiaomi,
  huawei,
  oppo,
  vivo
}
