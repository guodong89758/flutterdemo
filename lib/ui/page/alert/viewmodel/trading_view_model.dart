import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/alert/model/trading_view_entity.dart';
import 'package:bitfrog/ui/page/alert/model/trading_view_history_entity.dart';
import 'package:bitfrog/widget/dialog/common_dialog.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitfrog/api/bitfrog_api.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/net/network_api.dart';
import 'package:bitfrog/ui/page/community/viewmodel/list_common_model.dart';
import 'package:bitfrog/ui/view/show_alert_view.dart';
import 'package:bitfrog/utils/toast_util.dart';
import 'package:flutter/material.dart';

class TradingViewModel extends ListCommonModel {

  late TradingConfigEntity configEntity = TradingConfigEntity();
  late TradingHistoryEventEntity historyEventEntity = TradingHistoryEventEntity();
  List<HistoryEvent> historyEventEntityList = [];
  @override
  requestData({required RequestListDataCallback requestListData,
    NetErrorCallback? onError,
    CancelToken? cancelToken}) {
    ///获取历史
    BitFrogApi.instance.getTradingConfigHistory(page, pageSize,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
          historyEventEntity = TradingHistoryEventEntity.fromJson(data);


          if (page <= 1) {
            historyEventEntityList.clear();

            historyEventEntityList.addAll(historyEventEntity.data?? []);
          } else {
            historyEventEntityList.addAll(historyEventEntity.data?? []);
          }
          noMore = historyEventEntityList.length >= (historyEventEntityList.length ?? 0);
          setRefreshState();
          // requestListData(historyEventEntityList?? []);
          if (ObjectUtil.isEmptyList(historyEventEntityList)) {
            setEmpty();
          } else {
            setSuccess();
          }
        },onError: (code, msg) {
          setError(code, message: msg);
          return false;
        } );

  }

  configSet(){
    BitFrogApi.instance.getTardingViewConfig(
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      configEntity = TradingConfigEntity.fromJson(data);
      notifyListeners();
      // setEmpty();
    }, onError: (code, msg) {
      setError(code, message: msg);
      return false;
    });
  }
  @override
  refresh(){
    super.refresh();
    configSet();
  }

  /// 推送设置
  tradingSetTradingSetTrigger(bool isApp, bool isPhone,
      bool isNightNotDisturb,{BuildContext? context}) {
    return BitFrogApi.instance.setTradingSetTrigger(
        isApp ? 1 : 0, isPhone ? 1 : 0, isNightNotDisturb ? 1 : 0,

        cancelToken: cancelToken, onSuccess: (dynamic data) {
      // refresh();
      ToastUtil.show(S.current.alert_set_success);
      // configSet();
      refresh();
    }, onError: (code, msg) {
      // setError(code);
      if(context!=null){
        if (code == 5002) {
          //绑定手机
          showBindPhoneDialog(context,S.current.alert_bind_phone);
        } else if (code == 5009) {
          //加数据语音
          showVoiceDepositDialog(context,S.current.alert_voice_empty);
        }
      }
      return false;
    });
  }

  showVoiceDepositDialog(BuildContext context,String msg){

      showDialog<void>(
        context: context,

        barrierDismissible: true,
        // false = user must tap button, true = tap outside dialog
        builder: (BuildContext dialogContext) {
          return CommonDialog(
            content: msg,
            isLongLine:true,
            action2: S.current.action_deposit,
            onCancel: () {
              Routers.goBack(context);
            },
            onAction: () {
              Routers.goBack(context);
              Routers.navigateTo(context, Routers.voicePage);
            },
          );
        },
      );

  }
  void showBindPhoneDialog(BuildContext context,String msg) {
    AlertView.showAlertDig(context,
        message: msg,
        cancel: S.current.action_cancel,
        confirm: S.current.action_bind, confirmClick: () {
          // Routers.navigateTo(context, Routers.mineBindPhonePage);
          Parameters parameter = Parameters();
          parameter.putBool('isEmail', false);

          parameter.putString('title', S.current.user_security_phone_subtitle);
          Routers.navigateTo(context, Routers.mineBindPhoneEmailPage,
              parameters: parameter);
        });
  }

}
