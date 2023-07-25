import 'dart:async';

import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/ui/page/assets/model/access_trader_account_entity.dart';
import 'package:bitfrog/ui/page/firmOffer/request/firm_offer_api.dart';
import 'package:bitfrog/ui/page/firmOffer/view/live_Info_view.dart';
import 'package:bitfrog/ui/page/firmOffer/view/live_config_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitfrog/ui/page/firmOffer/model/access_api_entity.dart';

class AccessTraderAccountModel extends ViewStateModel {
  List<AccessApiEntity> apiList = [];
  AccessTraderAccountEntity? traderAccount;
  ExchangeEntity? curExchange;
  AccountTypeEntity? curAccountType;
  GlobalKey<State<LiveInfoView>> infoKey = GlobalKey();
  GlobalKey<State<LiveConfigView>> configKey = GlobalKey();
  String exchange = '';
  String apikey = '';
  String apiPass = '';
  String accountAlias = '';
  String apiSecret = '';
  String accountType = '';
  String exchangeUid = '';
  String contact = '';
  AccessTraderAccountModel() : super(viewState: ViewState.first);

  Future refresh() {
    return getLiveApiData();
  }

  Future getLiveApiData() {
    return FirmOfferApi.instance.getAccessApiConfigList(
        cancelToken: cancelToken,
        onSuccess: (dynamic data) {
          traderAccount =  AccessTraderAccountEntity.fromJson(data);

          if (traderAccount?.exchangeList?.isNotEmpty ?? true) {
            curExchange = traderAccount?.exchangeList?.first;
            exchange = curExchange?.exchange ?? '';


          }
          if (traderAccount?.accountTypeList?.isNotEmpty ?? true) {
            curAccountType = traderAccount?.accountTypeList?.first;
          }
          setSuccess();
        },
        onError: (code, msg) {
          setError(code, message: msg);
          return false;
        });
  }

  // String exchange,
  //     String apikey,
  // String apiSecret,
  //     String apiPass,
  // String accountAlias,
  //     String accountType,
  // String exchangeUid,
  //     String exchangeRegisterTime,
  // String contact,
  void setLiveApiData({Function? onSuccess}) {
    FirmOfferApi.instance.tradeAccessApi(
      exchange,
      apikey,
      apiSecret,
      apiPass,
      accountAlias,
      accountType,
      exchangeUid,
      contact,
      cancelToken: cancelToken,
      onSuccess: (dynamic data) {

        onSuccess?.call();
      },
      onError: (code, msg) {
        setError(code, message: msg);
        return true;
      },
    );
  }
}
