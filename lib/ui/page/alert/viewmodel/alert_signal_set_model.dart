
import 'package:bitfrog/app/default_app.dart';
import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/logic/link_manger.dart';
import 'package:bitfrog/model/channel_entity.dart';
import 'package:bitfrog/net/network_api.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/alert/alert_choose_symbol_page.dart';
import 'package:bitfrog/ui/page/alert/model/alert_signal_config_entity.dart';
import 'package:bitfrog/ui/page/alert/request/alert_api.dart';
import 'package:bitfrog/utils/toast_util.dart';
import 'package:bitfrog/widget/dialog/common_dialog.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/model/symbol_entity.dart';
class AlertSymbolSetModel extends ViewStateModel {

   BFSymbol? symbol;

  AlertSymbolSetModel(this.symbol):super(){
    getConfig();
  }

  int periodIndex = 0;
  int targetIndex = 0;




  List<Terms> period = []; ///周期
  List<Indicators> target = []; ///指标

   ///触发条件
   List<Conditions> get trigger {

     if (target.isEmpty) {
       return [];
     } else {
       if(targetIndex >= target.length){
         return [];
       }
       Indicators indicators = target[targetIndex];
       return indicators.conditions ?? [];
     }
   }

   ///参数
   List<Params> get params {
     if (trigger.isEmpty) {
       return [];
     } else {
       List<Conditions> triggerChoosed = [];
       for(Conditions conditions in trigger){
         if(conditions.checked){
           triggerChoosed.add(conditions);
         }
       }
       if(triggerChoosed.length==1){
         Conditions conditions = triggerChoosed.first;
         return conditions.params ?? [];
       }else{
         return [];
       }
     }
   }


   AlertSignalConfigEntity? alertSignalConfigEntity;


   List<ChannelEntity> channels = [
     ChannelEntity(type: 0,name: S.current.alert_app_strong,checked: true),
     ChannelEntity(type: 1,name: S.current.alert_tab_2),
   ]; ///提醒方式

   getConfig(){
     AlertApi.instance.request(ApisAlerts.alertIndicatorConfig,cancelToken: cancelToken,onSuccess: (dynamic data){
       alertSignalConfigEntity = AlertSignalConfigEntity.fromJson(data);
       period = alertSignalConfigEntity?.terms ?? [];
       target = alertSignalConfigEntity?.indicators ?? [];
       if(target.isNotEmpty && target.first.conditions !=null && target.first.conditions!.isNotEmpty){
         target.first.conditions!.first.checked = true;  /// 默认选中第一个指标的触发条件
       }
       setSuccess();
     },onError: (code,msg){
      setError(code);
       return false;
     });
   }


   addAlert(BuildContext context){

     List<Conditions> triggerChoosed = [];
     for(Conditions conditions in trigger) {
       if (conditions.checked) {
         triggerChoosed.add(conditions);
       }
     }
     if(triggerChoosed.isEmpty){
       ToastUtil.show(S.current.alert_single_5);
       return;
     }

     bool isChooseChannel = false;
     for(ChannelEntity channelEntity in channels){
       if(channelEntity.checked){
         isChooseChannel = true;
       }
     }
     if(!isChooseChannel){
       ToastUtil.show(S.current.alert_single_6);
       return;
     }

     Map<String,dynamic> params = {};
     params["symbol_key"] = symbol?.symbolKey ?? "";
     params["term"] = period[periodIndex].key ?? "";
     String conditionIds = "";
     for(Conditions conditions in triggerChoosed) {
       if (conditions.checked) {
         conditionIds += "${conditions.id ?? 0},";
       }
     }
     if(conditionIds.endsWith(",")){
       conditionIds.substring(0,conditionIds.length-1);
     }

     params["condition_ids"] = conditionIds;
     for(ChannelEntity channelEntity in channels){
       if(channelEntity.type == 0){
        params["app_push"] = channelEntity.checked ? "1" : "0";
       }else{
         params["voice_push"] = channelEntity.checked ? "1" : "0";
       }
     }

    AlertApi.instance.request(ApisAlerts.alertIndicatorSetTrigger,
        showLoading: true,
        method: Method.post,
        cancelToken: cancelToken, params: params, onSuccess: (dynamic data) {
           Routers.goBack(context);
        },onError: (code,msg){
          if (code == 5002) {
            //绑定手机
            showBindPhoneDialog();
          } else if (code == 5009) {
            //加数据语音
            showVoiceDepositDialog(S.current.alert_voice_empty);
          }

      return false;
        });
  }

   void showBindPhoneDialog() {
     BuildContext context =
         DefaultApp.navigatorKey.currentState!.overlay!.context;
     showDialog<void>(
       context: context,
       barrierDismissible: true,
       // false = user must tap button, true = tap outside dialog
       builder: (BuildContext dialogContext) {
         return CommonDialog(
           content: S.current.alert_bind_phone,
           action2: S.current.action_bind,
           onCancel: () {
             Routers.goBack(context);
           },
           onAction: () {
             Routers.goBack(context);
             LinkManger.schemeJump(
                 Uri.parse('bitfrog://app.bitfrog.com/user/bindphoneactivity'));
           },
         );
       },
     );
   }

   void showVoiceDepositDialog(String msg) {
     BuildContext context =
         DefaultApp.navigatorKey.currentState!.overlay!.context;
     showDialog<void>(
       context: context,
       barrierDismissible: true,
       // false = user must tap button, true = tap outside dialog
       builder: (BuildContext dialogContext) {
         return CommonDialog(
           content: msg,
           action2: S.current.action_deposit,
           onCancel: () {
             Routers.goBack(context);
           },
           onAction: () {
             Routers.goBack(context);
             Parameters params = Parameters()..putInt('type', 1);
             Routers.navigateTo(context, Routers.voicePage, parameters: params);
           },
         );
       },
     );
   }








  choseSymbol(BuildContext context){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (build) {
          return AlertChooseSymbolPage(handleClickAlertChooseSymbolPage: (e){
            symbol = e;
            notifyListeners();
          },);
        });
  }

  changePeriod(int index) {
    periodIndex = index;
    notifyListeners();
  }

  changeTarget(int index) {
    targetIndex = index;
    for (Conditions conditions in trigger) {
      conditions.checked = false;
    }
    trigger.first.checked = true;
    notifyListeners();
  }
  changeTrigger(int index) {
    Conditions conditions = trigger[index];
    conditions.checked = !conditions.checked;
    notifyListeners();
  }
  changeChannels(int index) {
     if(index==0){
       return;
     }
    ChannelEntity channelEntity = channels[index];
    channelEntity.checked = ! channelEntity.checked;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

