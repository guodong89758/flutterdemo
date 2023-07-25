import 'dart:async';

import 'package:bitfrog/api/bitfrog_api.dart';
import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/event/alert_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/model/sharp_entity.dart';
import 'package:bitfrog/utils/object_util.dart';
import 'package:bitfrog/utils/toast_util.dart';
import 'package:bitfrog/generated/l10n.dart';

class AlertSharpPriceModel extends ViewStateModel {
  List<SharpEntity> sharpList = [];
  StreamSubscription? setSharpSubscription;

  AlertSharpPriceModel() : super(viewState: ViewState.first);

  @override
  void dispose() {
    super.dispose();
    setSharpSubscription?.cancel();
  }

  void listenEvent() {
    setSharpSubscription?.cancel();
    setSharpSubscription =
        Event.eventBus.on<AlertSharpSetEvent>().listen((event) {
      setSharpPrice(event.sharp?.symbolKey ?? '',
          event.sharp?.symbolSwitch ?? 0);
    });
  }

  Future refresh() {
    return getSharpSymbol();
  }

  Future getSharpSymbol() {
    return BitFrogApi.instance.getSharpSymbol(
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      List<SharpEntity> sharpData = data == null ? [] :
          SharpEntity.fromJsonList(data) ?? [];
      sharpList.clear();
      sharpList.addAll(sharpData);
      if (ObjectUtil.isEmptyList(sharpList)) {
        setEmpty();
      } else {
        setSuccess();
      }
    }, onError: (code, msg) {
      setError(code, message: msg);
      return false;
    });
  }

  Future setSharpPrice(String symbol_key, int symbolSwitch) {
    setBusy();
    return BitFrogApi.instance.setSharpPrice(symbol_key, symbolSwitch,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      ToastUtil.show(S.current.alert_set_success);
      refresh();
    }, onError: (code, msg) {
      setIdle();
      return false;
    });
  }
}
