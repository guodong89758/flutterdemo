import 'dart:async';

import 'package:bitfrog/ui/page/alert/request/alert_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/api/bitfrog_api.dart';
import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/event/alert_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/model/channel_entity.dart';
import 'package:bitfrog/model/alert_price_entity.dart';
import 'package:bitfrog/model/symbol_entity.dart';
import 'package:bitfrog/utils/object_util.dart';
import 'package:bitfrog/utils/string_util.dart';
import 'package:bitfrog/utils/toast_util.dart';

class AlertAddPriceModel extends ViewStateModel {
  List<PriceItem> currentList = [];
  List<ChannelEntity> channelList = [];
  TextEditingController _riseController;
  TextEditingController _fallController;
  StreamSubscription? deleteAlertSubscription;
  StreamSubscription? symbolSubscription;
  StreamSubscription? priceSubscription;
  CancelToken? priceCancelToken;
  BFSymbol? curSymbol;
  String? curPrice;
  int scale = 8;
  int app_push = 0;
  int voice_push = 0;
  bool isRepeat = false;

  AlertAddPriceModel(this._riseController, this._fallController)
      : super(viewState: ViewState.first);

  @override
  void dispose() {
    deleteAlertSubscription?.cancel();
    symbolSubscription?.cancel();
    priceSubscription?.cancel();
    priceCancelToken?.cancel();
    super.dispose();
  }

  void listenEvent() {
    deleteAlertSubscription?.cancel();
    deleteAlertSubscription =
        Event.eventBus.on<AlertPriceDeleteEvent>().listen((event) {
      deletePriceAlert(event.alert_id ?? 0);
    });

    symbolSubscription?.cancel();
    symbolSubscription = Event.eventBus.on<AlertSymbolEvent>().listen((event) {
      curPrice = '';
      scale = 8;
      isRepeat = false;
      _riseController.clear();
      _fallController.clear();
      priceCancelToken?.cancel();
      refresh(event.symbol);
    });
  }

  Future refresh(BFSymbol? symbol) async {
    curSymbol = symbol;
    await Future.wait<dynamic>([
      getPriceAlertCurrent(symbol?.symbolKey ?? ''),
      getSymbolPrice(symbol?.id ?? 0),
      getPriceChannels()
    ]);
    refreshPrice(symbol?.id ?? 0);

    setIdle();
  }

  Future getPriceAlertCurrent(String symbol) {
    return AlertApi.instance.getTriggerItems(symbol,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      List<PriceItem> currentData =
          data == null ? [] : PriceItem.fromJsonList(data) ?? [];
      currentList.clear();
      currentList.addAll(currentData);
      if (ObjectUtil.isEmptyList(currentList)) {
        setEmpty();
      } else {
        setSuccess();
      }
    }, onError: (code, msg) {
      setError(code, message: msg);
      return false;
    });
  }

  void refreshPrice(int symbol_id) {
    priceSubscription?.cancel();
    priceSubscription =
        Stream.periodic(const Duration(seconds: 3), (count) {}).listen((event) {
      getSymbolPrice(symbol_id);
    });
  }

  Future getSymbolPrice(int symbol_id) {
    priceCancelToken = CancelToken();
    return BitFrogApi.instance.getSymbolPrice(symbol_id,
        cancelToken: priceCancelToken, onSuccess: (dynamic data) {
      curPrice = data['price'];
      scale = data['scale'];
      setSuccess();
    }, onError: (code, msg) {
      return false;
    });
  }

  Future getPriceChannels() {
    return BitFrogApi.instance.getPriceChannels(
        cancelToken: cancelToken,
        onSuccess: (dynamic data) {
          List<ChannelEntity> channelData =
              data == null ? [] : ChannelEntity.fromJsonList(data) ?? [];
          channelList.clear();
          channelList.addAll(channelData);
          for (var channel in channelList) {
            if (channel.type == 12) {
              //APP提醒
              channel.checked = true;
            }
          }
          if (!ObjectUtil.isEmptyList(channelList)) {
            setSuccess();
          }
        },
        onError: (code, msg) {
          setError(code, message: msg);
          return false;
        });
  }

  Future addPriceAlert() {
    for (var channel in channelList) {
      if (channel.type == 12) {
        //APP提醒
        app_push = channel.checked ? 1 : 0;
      } else if (channel.type == 13) {
        //语音提醒
        voice_push = channel.checked ? 1 : 0;
      }
    }
    setBusy();
    return AlertApi.instance.triggerSet(
        curSymbol?.id ?? 0,
        StringUtil.trimStr(_riseController.text),
        StringUtil.trimStr(_fallController.text),
        isRepeat ? 1 : 0,
        app_push,
        voice_push,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      _riseController.text = '';
      _fallController.text = '';
      for (var channel in channelList) {
        if (channel.type == 12) {
          //APP提醒
          channel.checked = true;
        } else {
          channel.checked = false;
        }
      }
      Event.eventBus.fire(AlertPriceRefreshEvent());
      Event.eventBus.fire(AlertSubscribeEvent());
      ToastUtil.show(S.current.alert_price_create_success);
      setSuccess();
      getPriceAlertCurrent(curSymbol?.symbolKey ?? '');
    }, onError: (code, msg) {
      setError(code, message: msg);
      return code == 5002 || code == 5009; //绑定手机、加数据语音
    });
  }

  Future deletePriceAlert(int id) {
    setBusy();
    return AlertApi.instance.deleteTrigger(id, cancelToken: cancelToken,
        onSuccess: (dynamic data) {
      ToastUtil.show(S.current.def_delete_success);
      Event.eventBus.fire(AlertPriceRefreshEvent());
      refresh(curSymbol);
    }, onError: (code, msg) {
      setIdle();
      return false;
    });
  }
}
