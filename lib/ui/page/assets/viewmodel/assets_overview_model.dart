import 'package:bitfrog/constant/config.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/assets/model/asserts_account_index_entity.dart';
import 'package:bitfrog/ui/page/assets/request/assets_api.dart';
import 'package:bitfrog/ui/page/copyTrade/model/share_trade_info_entity.dart';
import 'package:bitfrog/ui/page/copyTrade/model/share_trade_data_entity.dart';
import 'package:bitfrog/ui/page/copyTrade/request/copy_trade_api.dart';
import 'package:bitfrog/utils/sp_util.dart';
import 'package:dio/dio.dart';
import 'package:bitfrog/net/network_api.dart';
import 'package:bitfrog/ui/page/community/viewmodel/list_common_model.dart';
import 'package:flutter/cupertino.dart';

class AssetsOverviewModel extends ListCommonModel {




  late AnimationController btcController;
  late AnimationController priceController;
  bool assetsVisible = false;


  TickerProvider vsync;




  AssertsAccountIndexEntity? assertsAccountIndexEntity;

  AssetsOverviewModel(this.vsync):super(){
    btcController = AnimationController(duration: const Duration(seconds: 1), vsync: vsync);
    priceController = AnimationController(duration: const Duration(seconds: 1), vsync: vsync);

  }

  hideAssets(){
    assetsVisible = !assetsVisible;
    SpUtil.putBool(Config.keyAssetsVisible, assetsVisible);
    if (assetsVisible) {
      btcController.forward(from: 0);
      priceController.forward(from: 0);
    }
    notifyListeners();
  }

  @override
  requestData(
      {required RequestListDataCallback requestListData,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {

    AssetsApi.instance.getAccountIndex(
      cancelToken: cancelToken,
      onSuccess: (dynamic data) {
        assertsAccountIndexEntity = AssertsAccountIndexEntity.fromJson(data);
        requestListData(assertsAccountIndexEntity?.list ?? []);
      },
      onError: onError,
    );
  }

  // getInfoDetail() {
  //   CopyTradeApi.instance.copyTradeDetail(
  //       ApisCopyTrade.shareTradeInfo,
  //       showLoading: false,
  //       onSuccess: (dynamic data) {
  //         shareTradeInfoEntity = ShareTradeInfoEntity.fromJson(data);
  //         notifyListeners();
  //       });
  // }

  gotoDetail(BuildContext context,
      ShareTradeEntity shareTradeEntity) {
    Parameters parameters = Parameters();
    parameters.putObj("planId", shareTradeEntity.planId);
    Routers.navigateTo(context, Routers.shareTradeDetailPage,
        parameters: parameters);
  }
}
