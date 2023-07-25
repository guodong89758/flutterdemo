import 'package:bitfrog/model/base_entity.dart';
import 'package:dio/dio.dart';
import 'package:bitfrog/api/apis.dart';

import '../net/network_api.dart';

class BitFrogApi extends NetWorkApi {
  factory BitFrogApi() => _ins();

  static BitFrogApi get instance => _ins();

  static BitFrogApi? _instance;

  BitFrogApi._internal();

  static BitFrogApi _ins() {
    _instance ??= BitFrogApi._internal();
    return _instance!;
  }

  /// App配置项下发
  Future<dynamic> getAppConfig(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
        bool showLoading = false, //是否显示加载中状态
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.commonConfigIndex,
        onSuccess: onSuccess,
        onError: onError,
        showLoading: showLoading,
        cancelToken: cancelToken);
  }
  /// 消息是否已读
  Future<dynamic> getMessageRedPointStatus(
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        bool showLoading = false, //是否显示加载中状态
        CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.messageRedPointStatus,
        onSuccess: onSuccess,
        onError: onError,
        showLoading: showLoading,
        cancelToken: cancelToken);
  }

  /// 消息已读
  Future<dynamic> getMessageRedPointDisappear(
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        bool showLoading = false, //是否显示加载中状态
        CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.messageRedPointDisappear,
        onSuccess: onSuccess,
        onError: onError,
        showLoading: showLoading,
        cancelToken: cancelToken);
  }



  /// App是否升级
  Future<dynamic> getInfoUpgrade(
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        bool showLoading = false, //是否显示加载中状态
        CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.infoUpgrade,
        onSuccess: onSuccess,
        onError: onError,
        showLoading: showLoading,
        cancelToken: cancelToken);
  }

  /// 获取消息列表
  Future<dynamic> getMessageList(int type, int page, int page_size,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'type': type, //1 跟单 2 资金 3 实盘 6 系统
      'page': page,
      'page_size': page_size
    };
    return requestNetwork(Method.get, Apis.MESSAGE_LIST,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 获取提醒列表
  Future<dynamic> getAlertConfigList(int user_data,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = user_data == 1
        ? {
            'user_data': user_data, //不传此参数只下发列表，传此参数将下发用户每个类型的设置数量
          }
        : {};
    return requestNetwork(Method.get, Apis.ALERT_CONFIG_LIST,
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
    return requestNetwork(Method.get, Apis.ALERT_SUBSCRIBE_ITEMS,
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
    return requestNetwork(Method.post, Apis.ALERT_UPDATE_VOICE_REMIND_SWITCH,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 获取用户设置的价格提醒
  Future<dynamic> getAlertPriceCurrent(String symbol_key,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = symbol_key.isNotEmpty
        ? {
            'symbol_key': symbol_key, //传此参数则只获取某个交易对的数据
          }
        : {};
    return requestNetwork(Method.get, Apis.ALERT_PRICE_TRIGGER_ITEMS,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 获取价格提醒历史
  Future<dynamic> getAlertPriceHistory(int size,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = size > 0
        ? {
            'size': size, //下发多少条数据，默认最近10条
          }
        : {};
    return requestNetwork(Method.get, Apis.ALERT_PRICE_TRIGGER_HISTORY,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 获取交易对列表
  Future<dynamic> getSymbols({
    required String keyword,
    required int page,
    required int size,
    NetSuccessCallback<dynamic>? onSuccess,
    NetErrorCallback? onError,
    CancelToken? cancelToken,
  }) {
    Map<String, dynamic> params = {
      'keyword': keyword,
      'page': page,
      'size': size,
    };
    return requestNetwork(Method.get, Apis.ALERT_SYMBOL_SEARCH,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 获取交易对价格
  Future<dynamic> getSymbolPrice(int symbol_id,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'symbol_id': symbol_id,
    };
    return requestNetwork(Method.get, Apis.ALERT_SYMBOL_PRICE,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 获取价格提醒支持的提醒方式
  Future<dynamic> getPriceChannels(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.ALERT_PRICE_CHANNELS,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }

  /// 新增价格提醒
  /// symbol_id 交易对ID
  /// over_price 上涨触发价
  /// less_price 下跌触发价
  /// is_repeat 是否重复提醒 1重复 0不重复，默认不重复
  /// app_push 是否app提醒，1提醒 0不提醒
  /// voice_push 是否语音提醒，1提醒 0不提醒
  Future<dynamic> addPriceAlert(int symbol_id, String over_price,
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
    return requestNetwork(Method.post, Apis.ALERT_PRICE_TRIGGER_SET,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 删除价格提醒
  Future<dynamic> deletePriceAlert(int id,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'id': id,
    };
    return requestNetwork(Method.get, Apis.ALERT_PRICE_DELETE_TRIGGER,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 获取急涨急跌交易对
  Future<dynamic> getSharpSymbol(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.ALERT_PRICE_EXCEPTION_SYMBOL,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }

  /// 设置急涨急跌交易对
  Future<dynamic> setSharpPrice(String symbol_key, int symbolSwitch,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'symbol_key': symbol_key, //交易对
      'switch': symbolSwitch, //状态 1 开启 0关闭
    };
    return requestNetwork(Method.post, Apis.ALERT_PRICE_EXCEPTION_MONITOR_SET,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 获取某个指标下的可设置提醒交易对
  Future<dynamic> getAlertIndex(String type,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'type': type, //指标type
    };
    return requestNetwork(Method.get, Apis.ALERT_INDICATOR_SYMBOLS,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 设置指标提醒
  Future<dynamic> setAlertIndex(
      String type, String symbol_key, int period, int periodSwitch,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'type': type, //指标ID
      'symbol_key': symbol_key, //交易对key
      'period': period, //周期key
      'switch': periodSwitch, //状态 1 开启 0关闭
    };
    return requestNetwork(Method.post, Apis.ALERT_INDICATOR_SET,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 历史提醒列表
  Future<dynamic> getAlertHistory(String type, int page, int page_size,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'type': type, //行情预警类型
      'page': page,
      'page_size': page_size
    };
    return requestNetwork(Method.get, Apis.ALERT_MARKET_HISTORY,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 历史提醒详情
  Future<dynamic> getAlertDetail(String id,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'id': id, //提醒ID
    };
    return requestNetwork(Method.get, Apis.ALERT_DETAIL,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }
  /// 事件详情
  Future<dynamic> getAlertEventDetail(String id,
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'event_id': id, //提醒ID
    };
    return requestNetwork(Method.get, Apis.ALERT_EVENT_DETAIL,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }
  ///  /// 公告详情
    Future<dynamic> getAlertNoticeDetail(String id,
        {NetSuccessCallback<dynamic>? onSuccess,
          NetErrorCallback? onError,
          CancelToken? cancelToken}) {
      Map<String, dynamic> params = {
        'notice_id': id, //提醒ID
      };
      return requestNetwork(Method.get, Apis.ALERT_NOTICE_DETAIL,
          params: params,
          onSuccess: onSuccess,
          onError: onError,
          cancelToken: cancelToken);
    }


  /// 获取加数据设置数据
  Future<dynamic> setVoiceRechargeConfig(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.VOICE_DEPOSIT_CONFIG,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }

  /// 获取加数据详情
  Future<dynamic> getVoiceRechargeDetails(String id,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'ledger_id': id, //提醒ID
    };
    return requestNetwork(Method.get, Apis.VOICE_DETAILS,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 获取加数据数量
  Future<dynamic> getVoiceCount(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.VOICE_AMOUNT,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }

  /// 获取现货金额
  Future<dynamic> getVoiceSport(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.VOICE_SPORT,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }

  /// 获取绑定方式
  Future<dynamic> getVoiceAuthInfo(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.VOICE_AUTHINFO,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }

  /// 加数据历史列表
  Future<dynamic> getVoiceHistory(int page, int page_size,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {'page': page, 'page_size': page_size};
    return requestNetwork(Method.get, Apis.VOICE_DEPOSIT_RECORD,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 语音信息
  Future<dynamic> getVoiceTestShowNumber(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.voiceTestShowNumber,
        showLoading: true,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }

  /// 语音测试
  Future<dynamic> getVoiceTest(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.post, Apis.voiceTest,
        showLoading: true,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }

  /// 获取计价单位
  Future<dynamic> getcurrencyList(
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.currencyList,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }



/// 推送设置
Future<dynamic> getCurrencysetUnit(String unit,
    {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
  Map<String, dynamic> params = {
    'unit': unit,
  };
  return requestNetwork(Method.post, Apis.currencysetUnit,
      params: params,
      onSuccess: onSuccess,
      onError: onError,
      cancelToken: cancelToken);
}

  /// 推送测试
  Future<dynamic> pushTest(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.post, Apis.alarmUserPushTest,
        showLoading: true, onSuccess: (data) {}, onError: (code, msg) {
      return false;
    }, cancelToken: cancelToken);
  }

  /// 获取推送设置配置
  Future<dynamic> getPushConfig(
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.alarmUserConfig,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 推送设置
  Future<dynamic> setPushConfig(int isApp, int isPhone, int isNightNotDisturb,
      {String? sound,NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        bool showLoading = false,
        CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'is_app': isApp,
      'is_phone': isPhone,
      'is_night_not_disturb': isNightNotDisturb,
    };
    if(sound!=null){
      params["sound"] = sound;
    }
    return requestNetwork(Method.post, Apis.alarmUserSetConfig,
        params: params,
        onSuccess: onSuccess,
        showLoading: showLoading,
        onError: onError,
        cancelToken: cancelToken);
  }


  /// 多空观点列表
  Future<dynamic> getOpinionList(int page, int pageSize,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {'page': page, 'page_size': pageSize};
    return requestNetwork(Method.get, Apis.communityOpinion,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 多空观点点赞/取消点赞
  Future<dynamic> communityOpinionLike(int pointId,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {"point_id": pointId};
    return requestNetwork(Method.get, Apis.communityOpinionLike,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        showLoading: true,
        cancelToken: cancelToken);
  }

  /// 多空观点每天汇总
  Future<dynamic> getOpinionDateSummary(String date,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {'date': date};
    return requestNetwork(Method.get, Apis.communityOpinionDateSummary,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 交易所公告分类
  Future<dynamic> getNoticeClassify(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.communityNoticeClassify,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }

  /// 交易所公告列表
  Future<dynamic> getNoticeList(String exchange, int page, int pageSize,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'exchange': exchange,
      'current_page': page,
      'per_page': pageSize
    };
    return requestNetwork(Method.get, Apis.communityNotice,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 新的动态消息列表
  Future<dynamic> getNewDynamicList(int page, int pageSize,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {'page': page, 'page_size': pageSize};
    return requestNetwork(Method.get, Apis.communityNewDynamic,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 新的动态消息提示数量
  Future<dynamic> getNewDynamicNotice(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.communityNewDynamicNotice,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }

  /// 新的公告
  Future<dynamic> getCommunityNotice(String type,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {'type': type};
    return requestNetwork(Method.get, Apis.communityNewNotice,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 广场列表
  Future<dynamic> getSquareList(int? menuId, int page, int pageSize,
      {String? uid,NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'current_page': page,
      'per_page': pageSize
    };
    if(menuId!=null){
      params['menu_id'] = menuId;
    }
    if(uid!=null){
      params['uid'] = uid;
    }
    return requestNetwork(Method.get, Apis.communitySquareList,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 帖子详情
  Future<dynamic> getSquarePostDetail(String postId,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      "id": postId,
    };
    return requestNetwork(Method.get, Apis.communitySquareDetail,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 帖子点赞/取消点赞
  Future<dynamic> communityPostLike(int idPost,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {"id": idPost};
    return requestNetwork(Method.get, Apis.communitySetLike,
        params: params,
        onSuccess: onSuccess,
        showLoading: true,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 帖子删除
  Future<dynamic> communityPostDelete(int idPost,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {"id": idPost};
    return requestNetwork(Method.get, Apis.communitySquarePostDelete,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        showLoading: true,
        cancelToken: cancelToken);
  }

  /// 评论列表
  Future<dynamic> communitySquareCommentList(
      String idPost, int page, int pageSize,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      "id": idPost,
      'current_page': page,
      'per_page': pageSize
    };
    return requestNetwork(Method.get, Apis.communitySquareCommentList,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 发表评论
  Future<dynamic> commentPublish(
      int analysisId, String commentId, String content,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    // content = Uri.encodeComponent(content);
    Map<String, dynamic> params = {
      "analysis_id": analysisId,
      'content': content
    };
    if (commentId.isNotEmpty) {
      params['comment_id'] = commentId;
    }

    return requestNetwork(Method.post, Apis.communitySquareComment,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        showLoading: true,
        cancelToken: cancelToken);
  }

  /// 删除评论
  Future<dynamic> commentDelete(String commentId,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {"id": commentId};
    return requestNetwork(Method.post, Apis.communitySquareCommentDelete,
        params: params,
        onSuccess: onSuccess,
        showLoading: true,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 评论回复列表
  Future<dynamic> getSquareCommentReplayList(
      String idPost, int page, int pageSize,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      "id": idPost,
      'current_page': page,
      'per_page': pageSize
    };
    return requestNetwork(Method.get, Apis.communitySquareCommentReplayList,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 用户关注
  Future<dynamic> communitySquareUserFollow(String followId,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {"follow_uid": followId};
    return requestNetwork(Method.post, Apis.communitySquareUserFollow,
        params: params,
        onSuccess: onSuccess,
        showLoading: true,
        onError: onError,
        cancelToken: cancelToken);
  }
  /// 推特搜索
  Future<dynamic> communityTwitterSearch(String keyword,
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    Map<String, dynamic> params = {"keyword": keyword};
    return requestNetwork(Method.get, Apis.twitterSearch,
        params: params,
        onSuccess: onSuccess,
        showLoading: false,
        onError: onError,
        cancelToken: cancelToken);
  }


  /// 用户关注取消
  Future<dynamic> communitySquareUserFollowCancel(String followId,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {"follow_uid": followId};
    return requestNetwork(Method.post, Apis.communitySquareUserFollowCancel,
        params: params,
        onSuccess: onSuccess,
        showLoading: true,
        onError: onError,
        cancelToken: cancelToken);
  }
  /// 推特关注自主关注
  Future<dynamic> communityTwitterFollow(String external_account,
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    Map<String, dynamic> params = {'external_account':external_account};
    return requestNetwork(Method.post, Apis.twitterFollow,
        params: params,
        onSuccess: onSuccess,
        showLoading: true,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 推特设置推送
  Future<dynamic> communityTwitterUpdateConfig(String push_status,
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    Map<String, dynamic> params = {"subscribe_switch": push_status};
    return requestNetwork(Method.post, Apis.twitterUpdateConfig,
        params: params,
        onSuccess: onSuccess,
        showLoading: true,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 帖子投诉
  Future<dynamic> communitySquarePostReport(int postId,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {"analysis_id": postId};
    return requestNetwork(Method.get, Apis.communitySquarePostReport,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        showLoading: true,
        cancelToken: cancelToken);
  }

  /// 用户拉黑
  Future<dynamic> communitySquareUserBlack(String uid,
      {bool blackCancel = false,
      NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {"uid": uid};
    if (blackCancel) {
      params['unset'] = '1';
    }
    return requestNetwork(Method.get, Apis.communitySquareUserBlack,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        showLoading: true,
        cancelToken: cancelToken);
  }

  /// 上传图片
  Future<dynamic> uploadImage(Object fileData, String type,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {"type": type};
    return requestNetworkA(Method.post, Apis.uploadImage,
        params: params,
        data: fileData,
        options: Options(
            headers: {'Content-Type': 'multipart/form-data'},
            sendTimeout: const Duration(milliseconds: 1000000000)),
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 发布动态
  Future<dynamic> publishCommunityDynamic(
      String content, List<String> imageList,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    String images = '';
    if (imageList.isNotEmpty) {
      for (int i = 0; i < imageList.length; i++) {
        if (i == 0) {
          images = imageList[i];
        } else {
          images = "$images,${imageList[i]}";
        }
      }
    }
    // content = Uri.encodeComponent(content);
    Map<String, dynamic> params = images.isEmpty
        ? {"content": content}
        : {"content": content, "images": images};
    return requestNetwork(Method.post, Apis.publishDynamic,
        // params: params,
        onSuccess: onSuccess,
        data: params,
        showLoading: true,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 拉黑列表列表
  Future<dynamic> getBlackList(int page, int pageSize,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {'page': page, 'size': pageSize};
    return requestNetwork(Method.get, Apis.blackList,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 账户活动列表
  Future<dynamic> getAccountActive(int page, int size,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'page': page,
      'size': size,
    };
    return requestNetwork(Method.get, Apis.userAcountActive,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }
  /// tradingConfigHistory
  Future<dynamic> getTradingConfigHistory(int page, int size,
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'page': page,
      'size': size,
    };
    return requestNetwork(Method.get, Apis.tradingConfigHistory,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }


  /// 关注列表
  Future<dynamic> getFollowList(int page, int size,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'page': page,
      'size': size,
    };
    return requestNetwork(Method.get, Apis.userFollowList,
        params: params,
        showLoading:false,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// tradingView
  Future<dynamic> getTardingViewConfig(
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {

    return requestNetwork(Method.get, Apis.tradingConfig,
        showLoading: false,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }
  /// Trading推送设置
  Future<dynamic> setTradingSetTrigger(int appPush, int alertPush, int voicePush,
      {NetSuccessCallback<dynamic>? onSuccess,

        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'app_push': appPush,
      'alert_push': alertPush,
      'voice_push': voicePush,
    };
    return requestNetwork(Method.post, Apis.tradingSetTrigger,
        params: params,
        showLoading:true,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }
  /// twitterList列表
  Future<dynamic> getTwitterList(
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {

    return requestNetwork(Method.get, Apis.twitterList,
        showLoading:false,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }
  /// 划转币种
  Future<dynamic> transferCurrenciesList(String id,String type,
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'account_id': id,
      'account_type': type,

    };
    return requestNetwork(Method.get, Apis.transferCurrencies,
        showLoading: false,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken,params: params);
  }


  ///------------------登录注册-------------
  ///获取极验信息
  Future<dynamic> getGeetest(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.geetest,
        onSuccess: onSuccess,
        onError: onError,
        showLoading: true,
        cancelToken: cancelToken);
  }

  ///获取地区信息
  Future<dynamic> getAreaCode(String? type,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {

    return requestNetwork(Method.get, Apis.countryCode,
        onSuccess: onSuccess,
        onError: onError,
        params: (type != null && type.isNotEmpty) ? {"type": type} : null,
        cancelToken: cancelToken);
  }

  /// 账号密码登录
  Future<dynamic> loginAccountPsd(Map<String, dynamic> params,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.post, Apis.loginAccount,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        showLoading: true,
        cancelToken: cancelToken);
  }

  /// 获取验证码
  Future<dynamic> getVerificationCode(
      Map<String, dynamic> params, {
        NetSuccessCallback<dynamic>? onSuccess,
        NetSuccessCallback<BaseEntity>? onRawDataSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken,
      }) {
    return requestNetwork(Method.get, Apis.verification,
        params: params,
        onSuccess: onSuccess,
        onRawDataSuccess: onRawDataSuccess,
        showLoading: true,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 登录后获取验证码
  Future<dynamic> getAothIofnVerificationCode(Map<String, dynamic> params,
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    return requestNetwork(Method.post, Apis.userauthInfoCode,
        params: params,
        onSuccess: onSuccess,
        showLoading: true,
        onError: onError,
        cancelToken: cancelToken);
  }




  /// 获取用户信息
  Future<dynamic> getUserInfo(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.userInfo,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }

  /// 获取鉴权信息
  Future<dynamic> getUserAuthInfo(
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.userAuthInfo,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }

  /// 修改用户信息
  Future<dynamic> editUserInfo(Map<String, dynamic> params,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.post, Apis.userInfoEdit,
        onSuccess: onSuccess,
        params: params,
        showLoading: true,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 重置密码 验证旧密码
  Future<dynamic> restPsdVerificationOld(Map<String, dynamic> params,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.post, Apis.comparePassword,
        onSuccess: onSuccess,
        params: params,
        showLoading: true,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 注销用户
  Future<dynamic> logoffUser(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.post, Apis.logoffUser,
        onSuccess: onSuccess,
        onError: onError,
        showLoading: true,
        cancelToken: cancelToken);
  }

  /// 通用请求
  Future<dynamic> requestCommon(String url,
      {Map<String, dynamic>? params,
      bool showLoading = true,
      Method method = Method.get,
      NetSuccessCallback<dynamic>? onSuccess,
        bool showCodeNotSuccess = true,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(method, url,
        onSuccess: onSuccess,
        params: params,
        showCodeNotSuccess: showCodeNotSuccess,
        onError: onError,
        showLoading: showLoading,
        cancelToken: cancelToken);
  }

  /// 获取下发域名
  Future<dynamic> getDomains(
      String url,
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    return requestNetwork(Method.get, url,
        onSuccess: onSuccess,
        onError: onError,
        showLoading: true,
        cancelToken: cancelToken);
  }


}
