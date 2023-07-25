import 'dart:async';

import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/ui/page/alert/model/alert_tab.dart';
import 'package:bitfrog/ui/page/alert/request/alert_api.dart';
import 'package:flutter/material.dart';

class AlertModel extends ViewStateModel {
  List<AlertTab> tabList = [];
  late TabController? tabController;

  AlertModel() : super(viewState: ViewState.first);

  @override
  void dispose() {
    super.dispose();
  }

  void listenEvent() {}


  Future getAlertTab(TickerProvider vsync) {
    return AlertApi.instance.getNotifyCommonTab(
        cancelToken: cancelToken,
        onSuccess: (dynamic data) {
          List<AlertTab> tabData =
              data == null ? [] : AlertTab.fromJsonList(data) ?? [];
          tabList.clear();
          tabList.addAll(tabData);
          tabController = TabController(length: tabList.length, vsync: vsync);
          if (tabList.isEmpty) {
            setEmpty();
          } else {
            setSuccess();
          }
        },
        onError: (code, msg) {
          setError(code);
          return false;
        });
  }

}
