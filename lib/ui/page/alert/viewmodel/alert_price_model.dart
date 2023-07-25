import 'dart:async';

import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/event/alert_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/model/alert_price_entity.dart';
import 'package:bitfrog/model/price_history_entity.dart';
import 'package:bitfrog/ui/page/alert/request/alert_api.dart';
import 'package:bitfrog/ui/page/community/viewmodel/list_common_model.dart';
import 'package:bitfrog/utils/json_transform_util.dart';
import 'package:bitfrog/utils/toast_util.dart';

class AlertPriceModel extends ListCommonModel {
  // 当前设置的提醒指标
  final List<AlertPriceEntity> _alertConfigs = [];
  ViewState alertConfigState = ViewState.idle;

  StreamSubscription? _deleteAlertSubscription;
  StreamSubscription? _refreshSubscription;

  List<AlertPriceEntity> get alertConfigs => _alertConfigs;

  AlertPriceModel() {
    getPriceAlertCurrent(isInit: true);
  }

  @override
  requestData({required requestListData, onError, cancelToken}) {
    AlertApi.instance.getTriggerHistory(
      size: 10,
      page: page,
      cancelToken: cancelToken,
      onSuccess: (dynamic data) {
        final list = JsonTransformUtil.transformList(data)
            .map((e) => PriceHistoryEntity.fromJson(e))
            .toList();
        requestListData.call(list);

        notifyListeners();
      },
      onError: (code, msg) {
        onError?.call(code, msg);
        return false;
      },
    );
  }

  @override
  void dispose() {
    _deleteAlertSubscription?.cancel();
    _refreshSubscription?.cancel();
    super.dispose();
  }


  @override
  refresh() {
    // TODO: implement refresh
    getPriceAlertCurrent(isInit: false);
    return super.refresh();


  }
  void listenEvent() {
    _deleteAlertSubscription?.cancel();
    _deleteAlertSubscription =
        Event.eventBus.on<AlertPriceDeleteEvent>().listen((event) {
      deletePriceAlert(event.alert_id ?? 0);
    });
    _refreshSubscription?.cancel();
    _refreshSubscription =
        Event.eventBus.on<AlertPriceRefreshEvent>().listen((event) {
      refresh();
    });
  }

  void getPriceAlertCurrent({bool isInit = false}) {
    if (isInit) {
      alertConfigState = ViewState.busy;
      notifyListeners();
    }

    AlertApi.instance.getTriggerItems(
      '',
      cancelToken: cancelToken,
      onSuccess: (dynamic data) {
        final list = JsonTransformUtil.transformList(data)
            .map((e) => AlertPriceEntity.fromJson(e))
            .toList();
        alertConfigState = list.isEmpty ? ViewState.empty : ViewState.success;
        _alertConfigs.clear();
        _alertConfigs.addAll(list);
        notifyListeners();
      },
      onError: (code, msg) {
        if (isInit) {
          alertConfigState = ViewState.error;
          notifyListeners();
        }
        return false;
      },
    );
  }

  Future deletePriceAlert(int id) {
    return AlertApi.instance.deleteTrigger(
      id,
      cancelToken: cancelToken,
      onSuccess: (dynamic data) {
        ToastUtil.show(S.current.def_delete_success);
        getPriceAlertCurrent(isInit: false);
      },
      onError: (code, msg) {
        return false;
      },
    );
  }
}
