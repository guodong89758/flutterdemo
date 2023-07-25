
import 'package:bitfrog/net/network_api.dart';
import 'package:dio/dio.dart';

class AlertApi extends NetWorkApi {
  factory AlertApi() => _ins();

  static AlertApi get instance => _ins();

  static AlertApi? _instance;

  AlertApi._internal();

  static AlertApi _ins() {
    _instance ??= AlertApi._internal();
    return _instance!;
  }


  /// 指标请求
  Future<dynamic> request(String url,
      {Map<String, dynamic>? params,
      Method method = Method.get,
      NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      bool showLoading = false, //是否显示加载中状态
      bool showCodeNotSuccess = true,
      CancelToken? cancelToken}) {
    return requestNetwork(method, url,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        showLoading: showLoading,
        showCodeNotSuccess: showCodeNotSuccess);
    }

  /// 标签下发
  Future<dynamic> getNotifyCommonTab(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, ApisAlerts.notifyCommonTab,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }

  /// 提醒类型列表
  Future<dynamic> getNotifyTypes(int tab,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      "tab": tab,
    };
    return requestNetwork(Method.get, ApisAlerts.notifyTypes,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 提醒事件列表
  Future<dynamic> getNotifyEvents(int page, int size,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      "page": page,
      "size": size,
    };
    return requestNetwork(Method.get, ApisAlerts.notifyCommonEvents,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 设置(取消)提醒
  Future<dynamic> subcribeSwitch(
      String type, String subscribeKey, int subscribeSwitch,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      "type": type,
      "subscribe_key": subscribeKey,
      "switch": subscribeSwitch,
    };
    return requestNetwork(Method.post, ApisAlerts.subcribeSwitch,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 异动播报（价格提醒、信号预警不用此接口）
  Future<dynamic> getSubscribeEvents(String type, int page, int size,
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      "type": type,
      "page": page,
      "size": size,
    };
    return requestNetwork(Method.get, ApisAlerts.subscribeEvents,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 提醒类型设置项下发
  Future<dynamic> getSubscribeItems(String type,
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      "type": type,
    };
    return requestNetwork(Method.get, ApisAlerts.subscribeItems,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 获取用户设置的价格提醒
  Future<dynamic> getTriggerItems(String symbolKey,
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      "symbol_key": symbolKey,
    };
    return requestNetwork(Method.get, ApisAlerts.triggerItems,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 获取价格提醒历史
  Future<dynamic> getTriggerHistory({
    required int size,
    required int page,
    NetSuccessCallback<dynamic>? onSuccess,
    NetErrorCallback? onError,
    CancelToken? cancelToken,
  }) {
    Map<String, dynamic> params = {'page': page, 'size': size};
    return requestNetwork(Method.get, ApisAlerts.triggerHistory,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 删除价格提醒
  Future<dynamic> deleteTrigger(
    int id, {
    NetSuccessCallback<dynamic>? onSuccess,
    NetErrorCallback? onError,
    CancelToken? cancelToken,
  }) {
    Map<String, dynamic> params = {"id": id};
    return requestNetwork(
      Method.get,
      ApisAlerts.deleteTrigger,
      params: params,
      onSuccess: onSuccess,
      onError: onError,
      showLoading: true,
      cancelToken: cancelToken,
    );
  }

  /// 新增价格提醒
  /// symbol_id 交易对ID
  /// over_price 上涨触发价
  /// less_price 下跌触发价
  /// is_repeat 是否重复提醒 1重复 0不重复，默认不重复
  /// app_push 是否app提醒，1提醒 0不提醒
  /// voice_push 是否语音提醒，1提醒 0不提醒
  Future<dynamic> triggerSet(int symbol_id, String over_price,
      String less_price, int is_repeat, int app_push, int voice_push,
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'symbol_id': symbol_id,
      'over_price': over_price,
      'less_price': less_price,
      'is_repeat': is_repeat,
      'app_push': app_push,
      'voice_push': voice_push,
    };
    return requestNetwork(Method.post, ApisAlerts.triggerSet,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 历史提醒列表
  Future<dynamic> getAlertHistory(String type, int page, int size,
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'type': type, //行情预警类型
      'page': page,
      'size': size
    };
    return requestNetwork(Method.get, ApisAlerts.marketHistory,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 获取已经设置的提醒项【电话提醒列表页面】
  Future<dynamic> getPhoneAlert(String type,
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    Map<String, dynamic> params = type.isNotEmpty
        ? {
      'type': type, //提醒大类的类型|传此参数则只下发此大类下的已设置过的提醒项
    }
        : {};
    return requestNetwork(Method.get, ApisAlerts.voiceSubscribeList,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 设置电话提醒状态【开启&关闭】
  Future<dynamic> updateVoiceAlert(int id, int phoneSwitch,
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'id': id, //提醒ID
      'switch': phoneSwitch, //提醒ID
    };
    return requestNetwork(Method.post, ApisAlerts.voiceSwitch,
        params: params,
        onSuccess: onSuccess,
        onError: onError);
  }

}


class ApisAlerts {

  /// 指标订阅列表
  static const String alertIndicatorSubscribeList = '/app/notify/indicator/subscribeList';
  ///指标交易对搜索
  static const String alertIndicatorSymbolSearch = '/app/notify/indicator/symbolSearch';
  ///指标信息下发
  static const String alertIndicatorConfig = '/app/notify/indicator/config';
  ///新建指标
  static const String alertIndicatorSetTrigger = '/app/notify/indicator/setTrigger';
  ///删除指标提醒
  static const String alertIndicatorDelTrigger = '/app/notify/indicator/delTrigger';
  ///指标提醒异动播报
  static const String alertIndicatorHistory = '/app/notify/indicator/history';

  /// 标签下发
  static const String notifyCommonTab = '/app/notify/common/tab';

  /// 提醒类型列表
  static const String notifyTypes = '/app/notify/subscribe/notifyTypes';

  /// 提醒事件列表
  static const String notifyCommonEvents = '/app/notify/common/events';

  /// 设置(取消)提醒
  static const String subcribeSwitch = '/app/notify/subscribe/switch';

  /// 异动播报（价格提醒、信号预警不用此接口）
  static const String subscribeEvents = '/app/notify/subscribe/events';

  /// 提醒类型设置项下发
  static const String subscribeItems = '/app/notify/subscribe/subscribeItems';

  /// 获取用户设置的价格提醒
  static const String triggerItems = '/app/notify/price/triggerItems';

  /// 获取价格提醒历史
  static const String triggerHistory = '/app/notify/price/triggerHistory';

  /// 删除价格提醒
  static const String deleteTrigger = '/app/notify/price/deleteTrigger';

  /// 新增价格提醒
  static const String triggerSet = '/app/notify/price/triggerSet';

  /// 行情提醒历史
  static const String marketHistory = '/app/notify/subscribe/marketHistory';

  /// 获取已经设置的提醒项【电话提醒列表页面】
  static const String voiceSubscribeList = '/app/notify/voice/subscribeList';

  /// 设置语音提醒开关
  static const String voiceSwitch = '/app/notify/voice/switch';

}
