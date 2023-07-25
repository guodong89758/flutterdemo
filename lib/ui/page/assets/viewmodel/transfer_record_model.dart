import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/net/network_api.dart';
import 'package:bitfrog/ui/page/assets/model/transfer_record_entity.dart';
import 'package:bitfrog/ui/page/assets/request/assets_api.dart';
import 'package:bitfrog/ui/page/community/viewmodel/list_common_model.dart';
import 'package:dio/dio.dart';

class TransferRecordModel extends ListCommonModel {
  // List<TransferRecord> recordList = [];
  String days = '7';
  String currency = '';
  String curCurrencyName = S.current.asset_currency;
  String curDayName = S.current.base_time;
  List<String> timeArray = [
    S.current.action_all,
    S.current.base_day_7,
    S.current.base_day_30,
    S.current.base_day_90
  ];

  TransferRecordModel() : super(pageSize: 20);

  @override
  requestData(
      {required RequestListDataCallback requestListData,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    // recordList.clear();
    // for (int i = 0; i < 15; i++) {
    //   TransferRecord record = TransferRecord();
    //   record.currency = 'USDT';
    //   record.typeDesc = '苏坡积账户-合约账户转入';
    //   record.amount = '280.20000000';
    //   record.created = '2022-03-23 13:00:00';
    //   recordList.add(record);
    // }
    // requestListData(recordList);
    AssetsApi.instance.getTransferHistory(currency, days, page, pageSize,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      TransferRecordEntity recordData = TransferRecordEntity.fromJson(data);
      requestListData(recordData.data ?? []);
    }, onError: (code, msg) {
      setError(code, message: msg);
      return false;
    });
  }

}
