import 'dart:async';

import 'package:bitfrog/api/bitfrog_api.dart';
import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/event/alert_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/model/alert_phone_entity.dart';
import 'package:bitfrog/plugin/flutter_pigeon_plugin.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/alert/request/alert_api.dart';
import 'package:bitfrog/utils/toast_util.dart';
import 'package:bitfrog/widget/dialog/test_dialog.dart';
import 'package:flutter/material.dart';

class AlertPhoneModel extends ViewStateModel {
  AlertPhoneEntity? phoneData;

  // StreamSubscription? updateAlertSubscription;
  StreamSubscription? refreshSubscription;
  PhoneItem? setItem;

  AlertPhoneModel() : super(viewState: ViewState.first);

  @override
  void dispose() {
    // updateAlertSubscription?.cancel();
    refreshSubscription?.cancel();
    super.dispose();
  }

  void listenEvent() {
    // updateAlertSubscription?.cancel();
    // updateAlertSubscription =
    //     Event.eventBus.on<AlertPhoneEvent>().listen((event) {
    //   setItem = event.item;
    //   updateVoiceAlert(event.item?.id ?? 0, event.item?.phoneSwitch ?? 0);
    // });
    refreshSubscription?.cancel();
    refreshSubscription =
        Event.eventBus.on<AlertRefreshEvent>().listen((event) {
      refresh();
    });
  }

  Future refresh() {
    if (!FlutterPigeonPlugin.instance.isLogin()) {
      setEmpty();
      return Future(() => null);
    }
    return getPhoneAlert();
  }

  clickRefresh(){
    setBusy();
    refresh();
  }

  Future getPhoneAlert() {
    return AlertApi.instance.getPhoneAlert('', cancelToken: cancelToken,
        onSuccess: (dynamic data) {
      phoneData = AlertPhoneEntity.fromJson(data);
      if (phoneData == null) {
        setEmpty();
      } else {
        setSuccess();
      }
    }, onError: (code, msg) {
      setError(code, message: msg);
      return false;
    });
  }

  Future updateVoiceAlert(int id, int phoneSwitch) {
    return AlertApi.instance.updateVoiceAlert(id, phoneSwitch,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      ToastUtil.show(S.current.alert_set_success);
      refresh();
    }, onError: (code, msg) {
      setError(code, message: msg);
      return code == 5002 || code == 5009; //绑定手机、加数据语音
    });
  }

  phoneTestInfo(BuildContext context) {
    BitFrogApi.instance.getVoiceTestShowNumber(
        cancelToken: cancelToken,
        onSuccess: (dynamic data) {
          String? number = data["voice_show_number"];
          showVoiceTestDialog(context, S.current.push_setup_text_22.replaceFirst('%s', number ?? ''));
        });
  }

  void showVoiceTestDialog(BuildContext context, String message){
    showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext dialogContext) {
            return TestDialog(
              image: Assets.imagesPushVoiceTestHead,
              content: message,
              onCancel: () {
                Routers.goBack(context);
              },
              onAction: () {
                Routers.goBack(context);
                phoneTestConfirm();
              },
            );
          },
        );
  }

  phoneTestConfirm() {
    BitFrogApi.instance.getVoiceTest(
        cancelToken: cancelToken,
        onSuccess: (dynamic data) {
           ToastUtil.show(S.current.push_setup_text_23);
        });
  }
}
