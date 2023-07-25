import 'dart:async';

import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/ui/page/assets/model/asset_currency_entity.dart';
import 'package:bitfrog/ui/page/assets/model/withdraw_info_entity.dart';
import 'package:bitfrog/ui/page/assets/request/assets_api.dart';

class AssetWithdrawModel extends ViewStateModel {
  WithdrawInfoEntity? infoData;
  List<AssetCurrencyEntity>? currencyList = [];
  List<Chains>? chainList = [];
  AssetCurrencyEntity? selectCurrency;
  Chains? selectChain;

  AssetWithdrawModel() : super(viewState: ViewState.first);

  @override
  void dispose() {
    super.dispose();
  }

  void listenEvent() {}

  /// 获取提现地址信息
  Future getWithdrawCurrencyChains() {
    return AssetsApi.instance.getWithdrawCurrencyChains(
        cancelToken: cancelToken,
        onSuccess: (dynamic data) {
          infoData = WithdrawInfoEntity.fromJson(data);
          currencyList = infoData?.list;
          if ((infoData?.list ?? []).isNotEmpty) {
            selectCurrency = infoData?.list?[0];
            chainList = selectCurrency?.chains;
            if ((chainList ?? []).isNotEmpty) {
              selectChain = chainList?[0];
            }
          }
          setSuccess();
        },
        onError: (code, msg) {
          setError(code, message: msg);
          return false;
        });
  }
}
