import 'dart:async';

import 'package:bitfrog/api/bitfrog_api.dart';
import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/model/alert_detail_entity.dart';
import 'package:bitfrog/utils/log_utils.dart';

import '../alert_detail_page.dart';

class AlertDetailModel extends ViewStateModel {
  AlertDetailEntity? detail;
  String? id;
  AlertShowTypes? type;
  AlertDetailModel({this.id,this.type =AlertShowTypes.historyDetail }) : super(viewState: ViewState.first);

  @override
  void dispose() {
    super.dispose();
  }

  void listenEvent() {}

  Future refresh() {
    return getAlertDetail(id ?? '');
  }

  Future getAlertDetail(String id) {

    return BitFrogApi.instance.getAlertDetail(id, cancelToken: cancelToken,
        onSuccess: (dynamic data) {
      detail = AlertDetailEntity.fromJson(data);
      if (detail == null) {
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
