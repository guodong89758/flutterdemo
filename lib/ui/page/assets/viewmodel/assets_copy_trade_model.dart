import 'package:bitfrog/constant/config.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/copyTrade/model/copy_trade_mine_current_entity.dart';
import 'package:bitfrog/ui/page/copyTrade/request/copy_trade_api.dart';
import 'package:bitfrog/utils/sp_util.dart';
import 'package:dio/dio.dart';
import 'package:bitfrog/net/network_api.dart';
import 'package:bitfrog/ui/page/community/viewmodel/list_common_model.dart';
import 'package:flutter/cupertino.dart';

class AssetsCopyTradeModel extends ListCommonModel {

  late AnimationController btcController;
  late AnimationController priceController;
  bool assetsVisible = false;

  TickerProvider vsync;
  CopyTradeMineCurrentEntity? copyTradeMineCurrentEntity;



  AssetsCopyTradeModel(this.vsync):super(){
    btcController = AnimationController(duration: const Duration(seconds: 1), vsync: vsync);
    priceController = AnimationController(duration: const Duration(seconds: 1), vsync: vsync);
    getCopyTradeInfo();
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
    CopyTradeApi.instance.getCopyTradeMineCurrentList(page, pageSize,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
          CopyTradeMineCurrentListEntity copyTradeMineCurrentListEntity =
          CopyTradeMineCurrentListEntity.fromJson(data);
          requestListData(copyTradeMineCurrentListEntity.data ?? []);
        },onError: onError);
  }

  getCopyTradeInfo() {
    CopyTradeApi.instance.getCopyTradeMineInfo("3", onSuccess: (dynamic data) {
      copyTradeMineCurrentEntity = CopyTradeMineCurrentEntity.fromJson(data);
      notifyListeners();
    });
  }

  gotoDetail(BuildContext context,CopyTradeMineCurrentEntity copyTradeMineCurrentEntity) async{
    if ((copyTradeMineCurrentEntity.isSettle != null &&
        copyTradeMineCurrentEntity.isSettle!) ||
        copyTradeMineCurrentEntity.isPrepare != null &&
            copyTradeMineCurrentEntity.isPrepare!){
      return;
    }
    Parameters parameters = Parameters();
    parameters.putObj("followId", copyTradeMineCurrentEntity.followId);


    var res = await  Routers.navigateTo(context, Routers.copyTradeMineDetailPage,parameters: parameters);
    if(res!=null && (res is bool) && res){
      /// 结束跟单  修改列表状态
      copyTradeMineCurrentEntity.setSettle(true);
      notifyListeners();
    }
  }
}
