import 'dart:async';

import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/event/alert_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/alert/model/alert_type_entity.dart';
import 'package:bitfrog/ui/page/alert/request/alert_api.dart';
import 'package:flutter/cupertino.dart';

class AlertListModel extends ViewStateModel {
  int? tab;
  List<AlertTypeEntity> typeList = [];

  AlertListModel() : super(viewState: ViewState.first){
    /// 登录之后刷新
    Event.eventBus.on<UserLoginEvent>().listen((event) {
      typeList.clear();
      setBusy();
      refresh();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void listenEvent() {
    Event.eventBus.on<AlertSubscribeEvent>().listen((event) {
      refresh();
    });
  }

  Future refresh() {
    return getAlertList();
  }

  /// 提醒类型列表
  Future getAlertList() {
    return AlertApi.instance.getNotifyTypes(tab ?? 0, cancelToken: cancelToken,
        onSuccess: (dynamic data) {
      List<AlertTypeEntity> configData =
          data == null ? [] : AlertTypeEntity.fromJsonList(data) ?? [];
      typeList.clear();
      typeList.addAll(configData);
      if (typeList.isEmpty) {
        setEmpty();
      } else {
        setSuccess();
      }
    }, onError: (code, msg) {
      setError(code);
      return false;
    });
  }

  /// 设置(取消)提醒
  Future subscribeSwitch(BuildContext context,String type, String subscribeKey, int subscribeSwitch) {

    if (Routers.goLogin(context)){
      return Future.value();
    }

    return AlertApi.instance.subcribeSwitch(type, subscribeKey, subscribeSwitch,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      Event.eventBus.fire(AlertSubscribeEvent());
    }, onError: (code, msg) {
      setError(code);
      return false;
    });
  }
}
