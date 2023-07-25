import 'dart:async';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/net/network_api.dart';
import 'package:bitfrog/ui/page/assets/model/sort_type_entity.dart';
import 'package:bitfrog/ui/page/assets/model/spot_record_entity.dart';
import 'package:bitfrog/ui/page/assets/request/assets_api.dart';
import 'package:bitfrog/ui/page/community/viewmodel/list_common_model.dart';
import 'package:dio/dio.dart';

class AssetsApiAccountContractRecordModel extends ListCommonModel {
  List<SortTypeEntity> typeList = [];
  List<SpotRecord> recordList = [];
  String type = '0';
  String days = '7';
  String currency = '';
  String curCurrencyName = "币对";
  String curTypeName = S.current.base_category;
  String curDayName = S.current.base_time;
  int typeSelection = 0;
  int timeSelection = 1;
  List<String> typeArray = [];
  List<String> timeArray = [
    S.current.action_all,
    S.current.base_day_7,
    S.current.base_day_30,
    S.current.base_day_90
  ];

  bool noMore = false;

  AssetsApiAccountContractRecordModel();

  @override
  void dispose() {
    super.dispose();
  }



  @override
  requestData(
      {required RequestListDataCallback requestListData,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {


    // return AssetsApi.instance.getSpotLedger(currency, type, days, page, size,
    //     cancelToken: cancelToken, onSuccess: (dynamic data) {
    //       SpotRecordEntity recordData = SpotRecordEntity.fromJson(data);
    //       requestListData(recordData.data ?? []);
    //     }, onError: onError);
    //


    controller.refreshCompleted();
  }



  Future getSpotLedgerType() {
    return AssetsApi.instance.getSpotLedgerType(
        cancelToken: cancelToken,
        onSuccess: (dynamic data) {
          List<SortTypeEntity> typeData =
              data == null ? [] : SortTypeEntity.fromJsonList(data) ?? [];
          typeList.clear();
          typeList.addAll(typeData);
          typeArray.clear();
          typeArray.add(S.current.action_all);
          for (var element in typeList) {
            typeArray.add(element.value ?? '');
          }
        },
        onError: (code, msg) {
          return false;
        });
  }
}
