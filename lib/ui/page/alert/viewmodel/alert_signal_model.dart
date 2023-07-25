import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/model/symbol_entity.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/alert/alert_choose_symbol_page.dart';
import 'package:bitfrog/ui/page/alert/model/alert_signal_entity.dart';
import 'package:bitfrog/ui/page/alert/model/alert_signal_new_entity.dart';
import 'package:bitfrog/ui/page/alert/request/alert_api.dart';
import 'package:dio/dio.dart';
import 'package:bitfrog/net/network_api.dart';
import 'package:bitfrog/ui/page/community/viewmodel/list_common_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertSignalModel extends ListCommonModel{

  AlertSignalModel() : super(){
    getSubscribed();
  }

  int itemDefaultOpenMax = 4;
  bool isOpen = false;


   List<AlertSignalEntity> itemList = [];
   ViewState signalSubscribeViewState = ViewState.idle;

  @override
  requestData({required RequestListDataCallback requestListData, NetErrorCallback? onError, CancelToken? cancelToken}) {
    // TODO: implement requestData
    AlertApi.instance.request(ApisAlerts.alertIndicatorHistory,params: {"page":page,"size":pageSize},cancelToken: cancelToken,onSuccess: (dynamic data){
      AlertSignalNewDataEntity alertSignalNewDataEntity = AlertSignalNewDataEntity.fromJson(data);
      requestListData(alertSignalNewDataEntity.data ?? []);
    },onError: onError);
  }

  /// 获取已订阅的信号预警
  getSubscribed(){
    AlertApi.instance.request(ApisAlerts.alertIndicatorSubscribeList,cancelToken: cancelToken,onSuccess: (dynamic data){
      AlertSignalDataEntity alertSignalDataEntity = AlertSignalDataEntity.fromJson(data);
      itemList = alertSignalDataEntity.data ?? [];
      if(itemList.isEmpty){
        signalSubscribeViewState = ViewState.empty;
      }else{
        signalSubscribeViewState = ViewState.success;
      }
      notifyListeners();
    },onError: (code,msg){
      signalSubscribeViewState = ViewState.error;
      notifyListeners();
      return false;
    });
  }

  clickSubscribed(){
    signalSubscribeViewState = ViewState.busy;
    notifyListeners();
    getSubscribed();
  }


  open(){
    isOpen = true;
    notifyListeners();
  }

  deleteSignal(AlertSignalEntity alertSignalEntity) {
    AlertApi.instance.request(ApisAlerts.alertIndicatorDelTrigger,
        params: {"id": alertSignalEntity.id},
        showLoading: true,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      itemList.remove(alertSignalEntity);
      notifyListeners();
      getSubscribed();
    });
  }

  addSignal(BuildContext context){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (build) {
          return AlertChooseSymbolPage(handleClickAlertChooseSymbolPage: (e){
            signalSet(context,e);
          },);
        });
  }

  signalSet(BuildContext context,BFSymbol symbol) async {
    Parameters parameters  = Parameters();
    parameters.putObj("symbol", symbol);
    var res = await Routers.navigateTo(context, Routers.alertSignalSetPage,parameters: parameters);
    getSubscribed();
    // if(res!=null && res is AlertSignalEntity){
    //   itemList.add(res);
    //   signalSubscribeViewState = ViewState.success;
    //   notifyListeners();
    //   refresh();
    // }
  }


}


