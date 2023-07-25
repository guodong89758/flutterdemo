import 'package:bitfrog/constant/config.dart';
import 'package:bitfrog/ui/page/assets/model/assets_info_entity.dart';
import 'package:bitfrog/ui/page/assets/request/assets_api.dart';
import 'package:bitfrog/utils/sp_util.dart';
import 'package:dio/dio.dart';
import 'package:bitfrog/net/network_api.dart';
import 'package:bitfrog/ui/page/community/viewmodel/list_common_model.dart';
import 'package:flutter/cupertino.dart';

class AssetsCapitalModel extends ListCommonModel {




  late AnimationController btcController;
  late AnimationController priceController;
  bool assetsVisible = false;

  TextEditingController? textEditingController = TextEditingController();


  TickerProvider vsync;

  AssetsInfoEntity? infoData;





  AssetsCapitalModel(this.vsync):super(){
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
    return AssetsApi.instance.getAssetsInfo(
        cancelToken: cancelToken,
        onSuccess: (dynamic data) {
          AssetsInfoEntity assetsInfoEntity = AssetsInfoEntity.fromJson(data);
          infoData = assetsInfoEntity;
          if ((infoData?.spotList ?? []).isNotEmpty) {
            for (var element in infoData!.spotList!) {
              element.unit = infoData?.unit;
            }
          }
          requestListData(infoData?.spotList ?? []);
        },
        onError: (code, msg) {
          setError(code, message: msg);
          return false;
        });
  }

 
  
}
