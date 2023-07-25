import 'package:bitfrog/constant/config.dart';
import 'package:bitfrog/ui/page/assets/model/api_spot_entity.dart';
import 'package:bitfrog/ui/page/assets/request/assets_api.dart';
import 'package:bitfrog/utils/sp_util.dart';
import 'package:dio/dio.dart';
import 'package:bitfrog/net/network_api.dart';
import 'package:bitfrog/ui/page/community/viewmodel/list_common_model.dart';
import 'package:flutter/cupertino.dart';

class AssetsApiSpotModel extends ListCommonModel {
  late AnimationController btcController;
  late AnimationController priceController;
  bool assetsVisible = false;

  TextEditingController? textEditingController = TextEditingController();

  TickerProvider vsync;

  ApiSpotEntity? _apiSpotEntity;

  ApiSpotEntity? get apiSpotEntity => _apiSpotEntity;

  final String accountId;

  AssetsApiSpotModel(this.vsync, this.accountId) : super() {
    btcController =
        AnimationController(duration: const Duration(seconds: 1), vsync: vsync);
    priceController =
        AnimationController(duration: const Duration(seconds: 1), vsync: vsync);
  }

  hideAssets() {
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
    return AssetsApi.instance.getAccountSpot(
      accountId,
      cancelToken: cancelToken,
      onSuccess: (dynamic data) {
        ApiSpotEntity apiSpotEntity = ApiSpotEntity.fromJson(data);
        _apiSpotEntity = apiSpotEntity;
        requestListData(apiSpotEntity.assets ?? []);
      },
      onError: (code, msg) {
        setError(code, message: msg);
        return false;
      },
    );
  }
}
