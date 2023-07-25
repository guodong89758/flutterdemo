import 'dart:convert';
import 'dart:io';
import 'package:bitfrog/app/build_config.dart';
import 'package:bitfrog/event/event.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:bitfrog/constant/config.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/net/error_handle.dart';
import 'package:bitfrog/net/intercept.dart';
import 'package:bitfrog/plugin/flutter_pigeon_plugin.dart';
import 'package:bitfrog/utils/aes_utils.dart';

import '../model/base_entity.dart';
import '../utils/log_utils.dart';
import '../utils/toast_util.dart';

typedef NetSuccessCallback<T> = Function(T data);
typedef NetErrorCallback = bool Function(int code, String msg);

abstract class NetWorkApi {
  ///连接超时时间
  static const int _connectTimeout = 25000;

  ///响应超时时间
  static const int _receiveTimeout = 25000;

  ///发送超时时间
  static const int _sendTimeout = 10000;

  Dio? _dio;

  Dio createDio() {
    if (_dio != null) {
      _dio?.options.baseUrl = buildConfig.baseUrl;
      return _dio!;
    }

    final BaseOptions options = BaseOptions(
      connectTimeout: const Duration(milliseconds: _connectTimeout),
      receiveTimeout: const Duration(milliseconds: _receiveTimeout),
      sendTimeout: const Duration(milliseconds: _sendTimeout),
      /// dio默认json解析，这里指定返回UTF8字符串，自己处理解析。（可也以自定义Transformer实现）
      responseType: ResponseType.plain,
      baseUrl: buildConfig.baseUrl,
      // validateStatus: (_) {
      //   // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
      //   return true;
      // },
      // contentType: Headers.formUrlEncodedContentType, // 适用于post form表单提交
      //  contentType: Headers.jsonContentType,
    );
    Dio dio = Dio(options);
    dio.interceptors.addAll([
      HttpHeaderInterceptor(),
      if (!Config.inProduction) LoggingInterceptor()
    ]);
    _dio = dio;
    return dio;
  }

// 数据返回格式统一，统一处理异常
  Future<BaseEntity<T>> _request<T>(String method, String url,
      {Object? data,
      Map<String, dynamic>? params,
      Options? options,
      bool isEncryption = true, //是否加密
      CancelToken? cancelToken}) async {
    final Response<String> response = await createDio().request<String>(
      url,
      data: data,
      queryParameters: params,
      options: _checkOptions(method, options),
      cancelToken: cancelToken,
    );

    try {
      final String result = response.data.toString();

      /// 集成测试无法使用 isolate https://github.com/flutter/flutter/issues/24703
      /// 使用compute条件：数据大于10KB（粗略使用10 * 1024）且当前不是集成测试（后面可能会根据Web环境进行调整）
      /// 主要目的减少不必要的性能开销
      final bool isCompute = !Config.isDriverTest && result.length > 10 * 1024;

      debugPrint('isCompute:$isCompute');

      final Map<String, dynamic> resultMap =
          isCompute ? await compute(parseData, result) : parseData(result);
      if (resultMap['code'] != ExceptionHandle.SUCCESS &&
          resultMap['code'] != ExceptionHandle.SUCCESS_200) {
        return BaseEntity<T>(
            code: resultMap['code'], msg: resultMap['msg'], data: null);
      }
      /// && buildConfig.flavor != Flavor.develop  测试环境返回的接口不用解密
      if (isEncryption && resultMap['data'] is String) {
        String originalData = resultMap['data'];
        String deviceId = FlutterPigeonPlugin.instance.isLogin()
            ? FlutterPigeonPlugin.instance.jpushId ?? ''
            : '';
        String key =
            AESUtils.getKey(deviceId, FlutterPigeonPlugin.instance.getUid());
        String newData = AESUtils.decrypt(key, originalData);
        resultMap['data'] = jsonDecode(newData);
        Log.d(response.requestOptions.path);
        Log.json(json.encode(resultMap));
      }
      return BaseEntity<T>.fromJson(resultMap);
    } catch (e) {
      debugPrint(e.toString());
      return BaseEntity<T>(
          code: ExceptionHandle.PARSE_ERROR,
          msg: S.current.error_server,
          data: null);
    }
  }

  /// 注意[onSuccess] 和 [onRawDataSuccess] 会同时被调用
  Future<dynamic> requestNetwork<T>(
    Method method,
    String url, {
    NetSuccessCallback<T?>? onSuccess,
    ValueChanged<BaseEntity<T?>>? onRawDataSuccess,
    NetErrorCallback? onError,
    Object? data,
    Map<String, dynamic>? params,
    Options? options,
    bool isEncryption = false, //是否加密
    CancelToken? cancelToken,
    bool showLoading = false, //是否显示加载中状态
         bool showCodeNotSuccess = true, //是否飘窗显示code不为 ExceptionHandle.SUCCESS ExceptionHandle.SUCCESS_200 的提示
  }) async {
    if (showLoading) {
      ToastUtil.showRequest();
    }

    try {
      final result = await _request<T>(
        method.value,
        url,
        data: data,
        params: params,
        options: options,
        cancelToken: cancelToken,
        isEncryption: isEncryption,
      );
      if (showLoading) {
        ToastUtil.cancelToast();
      }
      if (result.code == ExceptionHandle.SUCCESS ||
          result.code == ExceptionHandle.SUCCESS_200) {
        onSuccess?.call(result.data);
        onRawDataSuccess?.call(result);
        return result.data;
      } else {
        // 游客状态需要退出登录
        if(result.code == 1016){
          Event.eventBus.fire(NeedLoginEvent());
        }

        if(showCodeNotSuccess){
          if (result.code == 2021 || result.code == 2022|| result.code == 2001|| result.code == 2002){

          }else{
            if ((result.code ==5002||result.code ==5009)){

            }else{
              ToastUtil.show(result.msg ?? "");
            }
          }

        }

        final NetError error = ExceptionHandle.handleException(
            ApiException(result.code ?? -1, result.msg ?? ""));
        onError?.call(error.code, error.msg);

        return Future.error(error);
      }
    } catch (e) {
      if (showLoading) {
        ToastUtil.cancelToast();
      }

      Log.e('接口onError ${e.toString()}');
      _cancelLogPrint(e, url);
      if (e is DioException &&
              e.type == DioExceptionType.unknown &&
              e.error is SocketException
          // &&
          // !(await FlutterPigeonPlugin.instance.isNetConnection())
          ) {
        _onError(ExceptionHandle.NETWORK_ERROR, S.current.error_net, onError,e);
      } else {
        final NetError error = ExceptionHandle.handleException(e);
        _onError(error.code, error.msg, onError,e);
      }
      return Future.error(e);
    }
  }

  Future<dynamic> requestNetworkA<T>(
    Method method,
    String url, {
    NetSuccessCallback<T?>? onSuccess,
    NetErrorCallback? onError,
    Object? data,
    Map<String, dynamic>? params,
    Options? options,
    bool isEncryption = true, //是否加密
    CancelToken? cancelToken,
  }) {
    return _request(method.value, url,
        data: data,
        params: params,
        options: options,
        cancelToken: cancelToken,
        isEncryption: isEncryption);
  }

  /// 开放的接口，不需要设备 用户信息 返回值格式不一致
  Future<dynamic> requestOpenApi<T>(
    Method method,
    String url, {
    Map<String, dynamic>? params,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final Response<String> response = await createDio().request<String>(
      url,
      data: data,
      queryParameters: params,
      options: _checkOptions(method.value, options),
      cancelToken: cancelToken,
    );

    final String result = response.data.toString();
    final bool isCompute = !Config.isDriverTest && result.length > 10 * 1024;
    return isCompute
        ? await compute(parseOpenData, result)
        : parseOpenData(result);
  }

  void _cancelLogPrint(dynamic e, String url) {
    if (e is DioError && CancelToken.isCancel(e)) {
      Log.e('取消请求接口： $url');
    }
  }

  void _onError(int? code, String msg, NetErrorCallback? onError,dynamic e) {
    if (code == null) {
      code = ExceptionHandle.UNKNOWN;
      msg = S.current.error_unknow;
    }
    Log.e('接口请求异常： code: $code, mag: $msg');

    // bool handleSelf = onError?.call(code, msg) ?? false;
    // if (!handleSelf) {
    //   //接口未处理异常提示时，统一使用toast提示
    //   ToastUtil.show(msg);
    // }

    if (onError == null) {
      if (e is DioError &&
          e.type == DioErrorType.cancel){
          return;
      }
      LogUtil.e("---66:${msg}");

        ToastUtil.show(msg);


    } else {
      onError.call(code, msg);
    }
  }

  Options _checkOptions(String method, Options? options) {
    options ??= Options();
    options.method = method;
    return options;
  }

  static Map<String, dynamic> parseData(String data) {
    return json.decode(data) as Map<String, dynamic>;
  }

  static dynamic parseOpenData(String data) {
    return json.decode(data);
  }
}

enum Method { get, post, put, patch, delete, head }

/// 使用拓展枚举替代 switch判断取值
/// https://zhuanlan.zhihu.com/p/98545689
extension MethodExtension on Method {
  String get value => ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD'][index];
}
