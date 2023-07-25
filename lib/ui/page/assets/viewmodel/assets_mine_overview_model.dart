import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/constant/config.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/plugin/flutter_pigeon_plugin.dart';
import 'package:bitfrog/ui/page/assets/assets_api_account_page.dart';
import 'package:bitfrog/ui/page/assets/assets_capital_page.dart';
import 'package:bitfrog/ui/page/assets/assets_copy_trade_page.dart';
import 'package:bitfrog/ui/page/assets/assets_overview_page.dart';
import 'package:bitfrog/ui/page/assets/model/asserts_account_index_entity.dart';
import 'package:bitfrog/ui/page/assets/request/assets_api.dart';
import 'package:bitfrog/ui/page/copyTrade/model/copy_trade_mine_current_entity.dart';
import 'package:bitfrog/ui/page/copyTrade/request/copy_trade_api.dart';
import 'package:bitfrog/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssetsMineOverViewModel extends ViewStateModel {



  AssertsAccountIndexEntity? assertsAccountIndexEntity;



  AssetsMineOverViewModel():super(){
    if(FlutterPigeonPlugin.instance.isLogin()){
      getInfo();
    }

    /// 登录之后刷新
    Event.eventBus.on<UserLoginEvent>().listen((event) {
      if(event.isLogin){
        getInfo();
      }
    });
  }


  getInfo() {
    AssetsApi.instance.getAccountIndex(onSuccess: (dynamic data) {
      assertsAccountIndexEntity = AssertsAccountIndexEntity.fromJson(data);
      setSuccess();
    },onError: (code,msg){
      setError(code);
      return false;
    });
  }
  clickRefresh(){
    setBusy();
    getInfo();
  }

}
