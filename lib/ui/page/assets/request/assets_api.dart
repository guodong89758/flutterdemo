import 'package:bitfrog/api/apis.dart';
import 'package:bitfrog/net/network_api.dart';
import 'package:dio/dio.dart';

class AssetsApi extends NetWorkApi {
  factory AssetsApi() => _ins();

  static AssetsApi get instance => _ins();

  static AssetsApi? _instance;

  AssetsApi._internal();

  static AssetsApi _ins() {
    _instance ??= AssetsApi._internal();
    return _instance!;
  }

  /// 资金总览
  Future<dynamic> getAssetsInfo(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.financeBalance,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }

  /// 充值-币种下拉列表
  Future<dynamic> getDepositCurrencyList(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.financeDepositCurrencyList,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }

  /// 充值-币种网络+币种须知
  Future<dynamic> getDepositCurrencyChains(String currency,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {'currency': currency};
    return requestNetwork(Method.get, Apis.financeDepositCurrencyChains,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 充值-币种网络+币种须知
  Future<dynamic> getDepositAddress(String currency, String network,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {'currency': currency, 'network': network};
    return requestNetwork(Method.get, Apis.financeDepositAddress,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 提现-币种网络+币种须知
  Future<dynamic> getWithdrawCurrencyChains(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.financeWithdrawNetwork,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }

  ///划转api
  Future<dynamic> getTransferAccountList(
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.transferAccountList,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }



  /// 划转
  Future<dynamic> transferApply(
      String from_type,
      String from_account_id,
      String to_type,
      String to_account_id,
      String currency,
      String amount,
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'from_type': from_type,
      'from_account_id': from_account_id,
      'to_type': to_type,
      'to_account_id': to_account_id,
      'currency': currency.toLowerCase(),
      'amount': amount,

    };
    return requestNetwork(Method.post, Apis.transferApply,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }


  /// 提现
  Future<dynamic> withdrawApply(
      String currency,
      String chain,
      String amount,
      String address,
      String memo,
      String mobile_code,
      String email_code,
      String ga_code,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'currency': currency,
      'chain': chain,
      'amount': amount,
      'address': address,
      'memo': memo,
      'mobile_code': mobile_code,
      'email_code': email_code,
      'ga_code': ga_code,
    };
    return requestNetwork(Method.post, Apis.financeWithdrawApply,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 充提记录
  Future<dynamic> getAssetRecord(String currency, int type, String startTime,
      String endTime, int page, int size,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'currency': currency,
      'type': type,
      'start_time': startTime,
      'end_time': endTime,
      'page': page,
      'size': size,
    };
    return requestNetwork(Method.get, Apis.financeDepositWithdrawHistory,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 资产-提币-撤销提币
  Future<dynamic> cancelWithdraw(String id,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'id': id,
    };
    return requestNetwork(Method.post, Apis.financeCancelWithdraw,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 财务记录-资金账户流水类型
  Future<dynamic> getSpotLedgerType(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.financeSpotLedgerType,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }

  /// 资产-财务记录-资金账户流水
  Future<dynamic> getSpotLedger(
      String currency, String type, String days, int page, int size,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'currency': currency,
      'type': type,
      'days': days,
      'page': page,
      'size': size,
    };
    return requestNetwork(Method.get, Apis.financeSpotLedger,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 资产-财务记录-跟单账户流水类型
  Future<dynamic> getFollowLedgerType(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, Apis.financeFollowLedgerType,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }

  /// 资产-财务记录-跟单账户流水
  Future<dynamic> getFollowLedger(String type, String days, int page, int size,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'type': type,
      'days': days,
      'page': page,
      'size': size,
    };
    return requestNetwork(Method.get, Apis.financeFollowLedger,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  ///  资产总览
  Future<dynamic> getAccountIndex(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, ApisAssets.assetsAccountIndex,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }


  ///  API账户--总资产折合(API账户详情)
  Future<dynamic> getAccountApi(String accountId,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, ApisAssets.assetsAccountApi,
        params: {"account_id": accountId},
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  ///  API账户--现货
  Future<dynamic> getAccountSpot(String id,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, ApisAssets.assetsAccountSpot,
        params: {"account_id": id},
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  ///  API账户--现货
  Future<dynamic> getAccountContract(
      String id,
      {NetSuccessCallback<dynamic>? onSuccess,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    return requestNetwork(Method.get, ApisAssets.assetsAccountContract,
        params: {"account_id":id},
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
    }

  /// 资产-划转记录
  Future<dynamic> getTransferHistory(
      String currency, String days, int page, int size,
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    Map<String, dynamic> params = {
      'currency': currency,
      // 'type': type,//暂时没有type筛选
      'days': days,
      'page': page,
      'size': size,
    };
    return requestNetwork(Method.get, ApisAssets.assetsTransferHistory,
        params: params,
        onSuccess: onSuccess,
        onError: onError,
        cancelToken: cancelToken);
  }

  /// 资产-账户列表
  Future<dynamic> getAccountList(
      {NetSuccessCallback<dynamic>? onSuccess,
      NetErrorCallback? onError,
      CancelToken? cancelToken}) {
    return requestNetwork(Method.get, ApisAssets.assetsAccountList,
        onSuccess: onSuccess, onError: onError, cancelToken: cancelToken);
  }

}

class ApisAssets {
  /// 资产总览
  static const String assetsAccountIndex = '/app/trade/account/index';

  /// API账户--总资产折合(API账户详情)
  static const String assetsAccountApi = '/app/trade/account/api';

  /// API账户--现货
  static const String assetsAccountSpot = '/app/trade/account/spot';

  /// API账户--U本位合约
  static const String assetsAccountContract = '/app/trade/account/contract';
  /// 交易账户列表
  static const String assetsAccountList = '/app/trade/common/accountList';

  /// 划转记录
  static const String assetsTransferHistory = '/app/trade/transfer/history';
}
