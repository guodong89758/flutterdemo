import 'dart:async';

import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/event/asset_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/ui/page/assets/model/assets_info_entity.dart';
import 'package:bitfrog/ui/page/assets/request/assets_api.dart';

class AssetsModel extends ViewStateModel {
  AssetsInfoEntity? infoData;
  List<SpotEntity>? spotList = [];
  List<ContractEntity>? contractList = [];

  AssetsModel() : super(viewState: ViewState.first);

  @override
  void dispose() {
    super.dispose();
  }

  void listenEvent() {
    Event.eventBus.on<WithdrawSuccessEvent>().listen((event) {
      refresh();
    });
    Event.eventBus.on<ValuitionRefreshEvent>().listen((event) {
      refresh();
    });
    Event.eventBus.on<UserLoginEvent>().listen((event) {
      if (event.isLogin) {
        refresh();
      }
    });
  }

  Future refresh() {
    return getAssetsInfo();
  }

  Future getAssetsInfo() {
    return AssetsApi.instance.getAssetsInfo(
        cancelToken: cancelToken,
        onSuccess: (dynamic data) {
          infoData = AssetsInfoEntity.fromJson(data);
          spotList = infoData?.spotList;
          contractList = infoData?.contractList;
          if ((infoData?.spotList ?? []).isNotEmpty) {
            for (var element in infoData!.spotList!) {
              element.unit = infoData?.unit;
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
