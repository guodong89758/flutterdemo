import 'package:bitfrog/net/network_api.dart';
import 'package:bitfrog/ui/page/assets/model/currency_choose_entity.dart';
import 'package:bitfrog/ui/page/user/model/tiwtter_entity.dart';
import 'package:bitfrog/ui/page/user/model/tiwtter_search_entity.dart';
import 'package:bitfrog/api/bitfrog_api.dart';
import 'package:bitfrog/ui/page/community/viewmodel/list_common_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class CurrencyListModel extends ListCommonModel {
  String id;
  String type;
  CurrencyListModel(this.id,this.type) : super();
  late  AccountTiwtterEntity tiwtterEntity = AccountTiwtterEntity(list: []);

  List<SymbolCurrency> searchLists = [];
  List<SymbolCurrency> oldLists = [];
  bool isOpen = false;

  /// 搜索输入框 事件
  TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  List<TiwtterEntity> footerList = []; // banner

  // 是否处于搜索中
  bool get _searching => textEditingController.text.isNotEmpty;

  @override
  requestData(
      {required RequestListDataCallback requestListData,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {

    BitFrogApi.instance.transferCurrenciesList( id,type,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      oldLists.clear();
      oldLists =
      data == null ? [] : SymbolCurrencyEntity.fromJsonList(data) ?? [];

      requestListData(oldLists?? []);
      oldLists.addAll(oldLists ?? []);
      setSuccess();

    },onError: (code, msg) {
      setError(code, message: msg);
      return false;
    } );
  }

  @override
  refresh() {
    // TODO: implement refresh
    // getDataLists();
    textEditingController.text = '';
    return super.refresh();
  }
  // /// 搜索
  void search() async {
    final searchKey = textEditingController.text;
    searchLists.clear();
    for(SymbolCurrency item in oldLists){
      if((item?.currency ?? '').contains(searchKey)) {
        searchLists.add(item);
      }
    }
    dataList.clear();
    dataList.addAll(searchLists);
    setSuccess();
  }



}
// import 'package:bitfrog/net/network_api.dart';
// import 'package:bitfrog/ui/page/alert/model/alert_signal_symbol_entity.dart';
// import 'package:bitfrog/ui/page/alert/request/alert_api.dart';
// import 'package:bitfrog/ui/page/community/viewmodel/list_common_model.dart';
// import 'package:dio/dio.dart';
//
// class AlertChooseSymbolModel extends ListCommonModel{
//
//   String keyword = "";
//
//   @override
//   requestData({required RequestListDataCallback requestListData, NetErrorCallback? onError, CancelToken? cancelToken}) {
//     AlertApi.instance.request(ApisAlerts.alertIndicatorSymbolSearch,
//         params: {"key_word": keyword},
//         cancelToken: cancelToken, onSuccess: (dynamic data) {
//           AlertSignalSymbolEntity symbolData =
//           AlertSignalSymbolEntity.fromJson(data);
//           requestListData(symbolData.data ?? []);
//         }, onError: onError);
//   }
//
//   search(String keyboardStr){
//     keyword = keyboardStr;
//     refresh();
//   }
// }