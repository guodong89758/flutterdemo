import 'dart:async';

import 'package:bitfrog/api/bitfrog_api.dart';
import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/event/alert_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/model/alert_config_entity.dart';
import 'package:bitfrog/plugin/flutter_pigeon_plugin.dart';
import 'package:bitfrog/utils/object_util.dart';

class AlertConfigModel extends ViewStateModel {
  List<AlertConfigEntity> configList = [];
  StreamSubscription? refreshSubscription;

  AlertConfigModel() : super(viewState: ViewState.first){

    /// 登录之后刷新
    Event.eventBus.on<UserLoginEvent>().listen((event) {
      configList.clear();
      refresh();
    });
  }

  @override
  void dispose() {
    refreshSubscription?.cancel();
    super.dispose();
  }

  void listenEvent() {
    refreshSubscription?.cancel();
    refreshSubscription =
        Event.eventBus.on<AlertRefreshEvent>().listen((event) {
          refresh();
        });
  }

  Future refresh() {
    
    return getAlertConfigData(FlutterPigeonPlugin.instance.isLogin() ? 1 : 0);
  }

  Future getAlertConfigData(int userData) {
    return BitFrogApi.instance.getAlertConfigList(userData,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      List<AlertConfigEntity> configData = data == null ? [] :
          AlertConfigEntity.fromJsonList(data) ?? [];
      configList.clear();
      configList.addAll(configData);
      if (ObjectUtil.isEmptyList(configList)) {
        setEmpty();
      } else {
        setSuccess();
      }
    }, onError: (code, msg) {
      setError(code, message: msg);
      return false;
    });
  }
}
