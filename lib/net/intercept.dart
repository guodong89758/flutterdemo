import 'dart:io';

import 'package:bitfrog/app/build_config.dart';
import 'package:bitfrog/constant/langue.dart';
import 'package:bitfrog/utils/user_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../plugin/flutter_pigeon_plugin.dart';
import '../utils/log_utils.dart';
import 'error_handle.dart';

class HttpHeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // FlutterPigeonPlugin.instance.getAppData();
    String token = FlutterPigeonPlugin.instance.userToken ?? '';

    options.headers['app-name'] = FlutterPigeonPlugin.instance.appName ?? '';
    options.headers['device-id'] = FlutterPigeonPlugin.instance.deviceId ?? '';
    options.headers['app-system'] = defaultTargetPlatform.name;
    options.headers['app-market'] = FlutterPigeonPlugin.instance.market ?? '';
    options.headers['app-version'] = FlutterPigeonPlugin.instance.version ?? '';
    options.headers['app-uuid'] = FlutterPigeonPlugin.instance.deviceId ?? '';
    options.headers['device-name'] = FlutterPigeonPlugin.instance.model ?? '';
    options.headers['device-system-version'] =
        FlutterPigeonPlugin.instance.systemVersion ?? '';
    options.headers['language'] = LanguageManger.instance.currentLanguage;
    options.headers['authorization'] = token.isEmpty ? '' : 'Bearer $token';
    options.headers['bf-app-token'] = token;
    options.headers['currency'] = UserUtil.getUserValuation() ?? 'USD';

    options.headers['user-agent'] =
        FlutterPigeonPlugin.instance.userAgent ?? '';
    if (buildConfig.flavor == Flavor.develop) {
      options.headers['HTTP_NOT_ENCODE_RESPONSE'] = '1';
    }
    options.headers['bf-jpush-id'] = FlutterPigeonPlugin.instance.jpushId ?? '';
    if (Platform.isIOS) {
      options.headers['SOURCE'] = "appstore";
    }
    super.onRequest(options, handler);
  }
}

class LoggingInterceptor extends Interceptor {
  late DateTime _startTime;
  late DateTime _endTime;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _startTime = DateTime.now();
    Log.d('----------Start----------');
    if (options.queryParameters.isEmpty) {
      Log.d('RequestUrl: ${options.baseUrl}${options.path}');
    } else {
      Log.d(
          'RequestUrl: ${options.baseUrl}${options.path}?${Transformer.urlEncodeMap(options.queryParameters)}');
    }
    Log.d('RequestMethod: ${options.method}');
    Log.d('RequestHeaders:${options.headers}');
    Log.d('RequestContentType: ${options.contentType}');
    Log.d(
        'RequestParams: ${Transformer.urlEncodeMap(options.queryParameters)}');
    // Log.d('RequestData: ${options.data.toString()}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    _endTime = DateTime.now();
    final int duration = _endTime.difference(_startTime).inMilliseconds;
    if (response.statusCode == ExceptionHandle.SUCCESS ||
        response.statusCode == ExceptionHandle.SUCCESS_200) {
      Log.d('ResponseCode: ${response.statusCode}');
    } else {
      Log.e('ResponseCode: ${response.statusCode}');
    }
    // 输出结果
    Log.json("${response.requestOptions.path}\n${response.data.toString()}");
    Log.d('----------End: $duration 毫秒----------');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Log.d('----------Error-----------');
    super.onError(err, handler);
  }
}
