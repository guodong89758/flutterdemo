import 'dart:async';

import 'package:bitfrog/api/bitfrog_api.dart';
import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/event/alert_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/model/alert_index_entity.dart';
import 'package:bitfrog/utils/object_util.dart';
import 'package:bitfrog/utils/toast_util.dart';
import 'package:bitfrog/generated/l10n.dart';

class AlertIndexModel extends ViewStateModel {
  List<AlertIndexEntity> indexList = [];
  StreamSubscription? setIndexSubscription;
  String? type;

  AlertIndexModel(this.type) : super(viewState: ViewState.first);

  @override
  void dispose() {
    super.dispose();
    setIndexSubscription?.cancel();
  }

  void listenEvent() {
    setIndexSubscription?.cancel();
    setIndexSubscription = Event.eventBus.on<AlertIndexEvent>().listen((event) {
      setIndexPeriod(type ?? '', event.index?.symbolKey ?? '',
          event.period?.key ?? 0, event.period?.periodSwitch ?? 0);
    });
  }

  Future refresh() {
    return getIndexSymbol();
  }

  Future getIndexSymbol() {

    
    return BitFrogApi.instance.getAlertIndex(type ?? '',
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      List<AlertIndexEntity> indexData = data == null ? [] :
          AlertIndexEntity.fromJsonList(data) ?? [];
      indexList.clear();
      indexList.addAll(indexData);
      if (ObjectUtil.isEmptyList(indexList)) {
        setEmpty();
      } else {
        setSuccess();
      }
    }, onError: (code, msg) {
      setError(code, message: msg);
      return false;
    });
  }

  Future setIndexPeriod(
      String type, String symbol_key, int period, int periodSwitch) {
    setBusy();
    return BitFrogApi.instance.setAlertIndex(
        type, symbol_key, period, periodSwitch,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      ToastUtil.show(S.current.alert_set_success);
      refresh();
    }, onError: (code, msg) {
      setIdle();
      return false;
    });
  }
}
