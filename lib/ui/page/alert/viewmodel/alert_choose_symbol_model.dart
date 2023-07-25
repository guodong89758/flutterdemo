import 'package:bitfrog/net/network_api.dart';
import 'package:bitfrog/ui/page/alert/model/alert_signal_symbol_entity.dart';
import 'package:bitfrog/ui/page/alert/request/alert_api.dart';
import 'package:bitfrog/ui/page/community/viewmodel/list_common_model.dart';
import 'package:dio/dio.dart';

class AlertChooseSymbolModel extends ListCommonModel{

  String keyword = "";

  @override
  requestData({required RequestListDataCallback requestListData, NetErrorCallback? onError, CancelToken? cancelToken}) {
    AlertApi.instance.request(ApisAlerts.alertIndicatorSymbolSearch,
        params: {"key_word": keyword},
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      AlertSignalSymbolEntity symbolData =
          AlertSignalSymbolEntity.fromJson(data);
      requestListData(symbolData.data ?? []);
    }, onError: onError);
  }

  search(String keyboardStr){
    keyword = keyboardStr;
    refresh();
  }
}