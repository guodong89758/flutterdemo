import 'dart:async';

import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/event/alert_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/model/alert_history_entity.dart';
import 'package:bitfrog/ui/page/alert/model/alert_type_entity.dart';
import 'package:bitfrog/ui/page/alert/request/alert_api.dart';
import 'package:bitfrog/utils/object_util.dart';

class AlertHistoryModel extends ViewStateModel {
  List<AlertTypeEntity> typeList = [];
  List<History> historyList = [];
  StreamSubscription? typeSubscription;
  int page = 1;
  int pageSize = 20;

  bool noMore = false;

  AlertHistoryModel() : super(viewState: ViewState.first);

  @override
  void dispose() {
    super.dispose();
    typeSubscription?.cancel();
  }

  void listenEvent() {
    typeSubscription?.cancel();
    typeSubscription =
        Event.eventBus.on<AlertHistoryTypeEvent>().listen((event) {
      refresh();
    });
  }

  Future refresh() {
    page = 1;
    noMore = false;
    return getAlertHistory(getType(), page, pageSize);
  }

  Future loadMore() {
    page++;
    return getAlertHistory(getType(), page, pageSize);
  }

  Future getAlertConfigData() {
    return AlertApi.instance.getNotifyTypes(0, cancelToken: cancelToken,
        onSuccess: (dynamic data) {
      List<AlertTypeEntity> configData =
          data == null ? [] : AlertTypeEntity.fromJsonList(data) ?? [];
      typeList.clear();
      typeList.addAll(configData);
      if (typeList.isNotEmpty) {
        typeList[0].checked = true;
        refresh();

      }
      setSuccess();
    }, onError: (code, msg) {
      setError(code);
      return false;
    });
  }

  Future getAlertHistory(String type, int page, int size) {
    return AlertApi.instance.getAlertHistory(type, page, size,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      AlertHistoryEntity historyData = AlertHistoryEntity.fromJson(data);
      if (page == 1) {
        historyList.clear();
        historyList.addAll(historyData.data ?? []);
      } else {
        historyList.addAll(historyData.data ?? []);
      }
      noMore = (historyData.data ?? []).length < pageSize;
      if (ObjectUtil.isEmptyList(historyList)) {
        setEmpty();
      } else {
        setSuccess();
      }
    }, onError: (code, msg) {
      setError(code, message: msg);
      return false;
    });
  }

  String getType() {
    if (typeList.isEmpty) {
      return '';
    }
    String type = '';
    for (var element in typeList) {
      if (element.checked ?? false) {
        if (type.isEmpty) {
          type = element.type ?? '';
        } else {
          type = '$type,${element.type}';
        }
      }
    }
    return type;
  }
}
