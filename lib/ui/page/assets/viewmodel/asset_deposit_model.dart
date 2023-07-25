import 'dart:async';

import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/ui/page/assets/model/asset_currency_entity.dart';
import 'package:bitfrog/ui/page/assets/model/deposit_info_entity.dart';
import 'package:bitfrog/ui/page/assets/request/assets_api.dart';
import 'package:bitfrog/utils/object_util.dart';

class AssetDepositModel extends ViewStateModel {
  DepositInfoEntity? infoData;
  List<AssetCurrencyEntity>? currencyList = [];
  List<Chains>? chainList = [];
  AssetCurrencyEntity? selectCurrency;
  Chains? selectChain;

  AssetDepositModel() : super(viewState: ViewState.first);

  @override
  void dispose() {
    super.dispose();
  }

  void listenEvent() {}

  /// 获取充值地址信息
  Future getDepositAddress(String currency, String network) {
    return AssetsApi.instance.getDepositAddress(currency, network,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      infoData = DepositInfoEntity.fromJson(data);
      setSuccess();
    }, onError: (code, msg) {
      setError(code, message: msg);
      return false;
    });
  }

  /// 充值-币种下拉列表
  Future getDepositCurrencyList() {
    return AssetsApi.instance.getDepositCurrencyList(
        cancelToken: cancelToken,
        onSuccess: (dynamic data) {
          List<AssetCurrencyEntity> currencyData =
              data == null ? [] : AssetCurrencyEntity.fromJsonList(data) ?? [];
          currencyList?.clear();
          currencyList?.addAll(currencyData);
          if (!ObjectUtil.isEmptyList(currencyList)) {
            selectCurrency = currencyList?[0];
            getDepositCurrencyChains(selectCurrency?.currency ?? 'USDT');
          }
        },
        onError: (code, msg) {
          setError(code, message: msg);
          return false;
        });
  }

  /// 充值-币种网络+币种须知
  Future getDepositCurrencyChains(String currency) {
    return AssetsApi.instance.getDepositCurrencyChains(currency,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      List<Chains> chainData =
          data == null ? [] : Chains.fromJsonList(data) ?? [];
      chainList?.clear();
      chainList?.addAll(chainData);
      if (!ObjectUtil.isEmptyList(chainList)) {
        selectChain = chainList?[0];
        getDepositAddress(selectCurrency?.currency ?? 'USDT', selectChain?.network ?? '');
      }
    }, onError: (code, msg) {
      setError(code, message: msg);
      return false;
    });
  }
}
