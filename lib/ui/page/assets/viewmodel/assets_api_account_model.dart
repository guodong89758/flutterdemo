import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/constant/config.dart';
import 'package:bitfrog/ui/page/assets/model/api_account_entity.dart';
import 'package:bitfrog/ui/page/assets/request/assets_api.dart';
import 'package:bitfrog/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';

class AssetsApiAccountModel extends ViewStateModel {

  late AnimationController btcController;
  late AnimationController priceController;
  bool assetsVisible = false;

  TickerProvider vsync;
  ApiAccountEntity? apiAccountEntity;

  final String accountId;

  AssetsApiAccountModel(this.vsync,this.accountId):super(){
    btcController = AnimationController(duration: const Duration(seconds: 1), vsync: vsync);
    priceController = AnimationController(duration: const Duration(seconds: 1), vsync: vsync);
    getInfo();
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

  getInfo() {
    AssetsApi.instance.getAccountApi(accountId, onSuccess: (dynamic data) {
      apiAccountEntity = ApiAccountEntity.fromJson(data);
      setSuccess();
    }, onError: (code, msg) {
      setError(code);
      return false;
    });
  }

  clickRefresh(){
    setBusy();
    getInfo();
  }


}
