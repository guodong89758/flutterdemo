import 'dart:async';

import 'package:bitfrog/app/default_app.dart';
import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/ui/page/assets/request/assets_api.dart';
import 'package:flutter/material.dart';

class AssetRecordDetailModel extends ViewStateModel {
  AssetRecordDetailModel() : super(viewState: ViewState.first);

  @override
  void dispose() {
    super.dispose();
  }

  void listenEvent() {}

  /// 资产-提币-撤销提币
  Future cancelWithdraw(String id) {
    return AssetsApi.instance.cancelWithdraw(id, cancelToken: cancelToken,
        onSuccess: (dynamic data) {
      setSuccess();
      Navigator.pop(DefaultApp.navigatorKey.currentState!.overlay!.context);
    }, onError: (code, msg) {
      setError(code, message: msg);
      return false;
    });
  }
}
