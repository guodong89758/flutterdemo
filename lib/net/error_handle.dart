import 'dart:io';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:bitfrog/constant/config.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/plugin/flutter_pigeon_plugin.dart';

class ExceptionHandle {
  static const int SUCCESS = 0;
  static const int SUCCESS_200 = 200;

  ///HTTP 状态码
  static const int UNAUTHORIZED = 401;
  static const int FORBIDDEN = 403;
  static const int NOT_FOUND = 404;
  static const int REQUEST_TIMEOUT = 408;
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int BAD_GATEWAY = 502;
  static const int SERVICE_UNAVAILABLE = 503;
  static const int GATEWAY_TIMEOUT = 504;

  ///网络错误
  static const int NETWORK_ERROR = -1000;

  ///解析错误
  static const int PARSE_ERROR = -1001;

  ///协议错误
  static const int HTTP_ERROR = -1002;

  ///证书错误
  static const int SSL_ERROR = -1003;

  ///连接超时
  static const int CONNECT_TIMEOUT = -1004;

  ///响应超时
  static const int RECEIVE_TIMEOUT = -1005;

  ///发送超时
  static const int SEND_TIMEOUT = -1006;

  ///网络请求取消
  static const int CANCEL = -1007;

  ///未知错误
  static const int UNKNOWN = -1008;

  //APP业务错误码
  static const int ERROR_TOKEN_OVERDUE = 14; //需要登录
  static const int ERROR_NEED_LOGIN = 1016; //需要登录

  static NetError handleException(dynamic error) {
    debugPrint(error.toString());
    if (error is DioException) {
      int errorCode = UNKNOWN;
      String errorMsg = error.message ?? '';
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          errorCode = CONNECT_TIMEOUT;
          errorMsg = S.current.error_connect_timeout;
          break;
        case DioExceptionType.receiveTimeout:
          errorCode = RECEIVE_TIMEOUT;
          errorMsg = S.current.error_server;
          break;
        case DioExceptionType.sendTimeout:
          errorCode = SEND_TIMEOUT;
          errorMsg = S.current.error_connect_timeout;
          break;
        case DioExceptionType.badResponse:
          errorCode = HTTP_ERROR;
          errorMsg = S.current.error_server;
          break;
        case DioExceptionType.cancel:
          errorCode = CANCEL;
          errorMsg = '';
          // errorMsg = !Config.inProduction ? "请求已被取消，请重新请求" : '';
          break;
        case DioExceptionType.unknown:
          errorCode = UNKNOWN;
          errorMsg = S.current.error_unknow;
          return _handleException(error.error);
      }
      return NetError(errorCode, errorMsg);
    } else {
      return _handleException(error);
    }
  }

  static NetError _handleException(dynamic error) {
    int errorCode = UNKNOWN;
    String errorMsg = '';

    if (error is ApiException) {
      errorCode = error.code;
      errorMsg = error.msg;
      if (errorCode == ERROR_NEED_LOGIN || errorCode == ERROR_TOKEN_OVERDUE) {
        //token过期，需要登录
        // FlutterPigeonPlugin.instance.tokenOverdue();
      }
    } else if (error is HttpException || error is SocketException) {
      errorCode = HTTP_ERROR;
      errorMsg = S.current.error_server;
    } else if (error is CertificateException) {
      errorCode = SSL_ERROR;
      errorMsg = S.current.error_ssl;
    } else if (error is FormatException) {
      errorCode = PARSE_ERROR;
      errorMsg = S.current.error_parse;
    } else {
      errorCode = UNKNOWN;
      errorMsg = S.current.error_unknow;
    }

    return NetError(errorCode, errorMsg);
  }
}

class NetError {
  NetError(this.code, this.msg);

  int code;
  String msg;
}

class ApiException implements Exception {
  ApiException(this.code, this.msg);

  int code;
  String msg;
}
