import 'dart:async';

import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/event/asset_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/ui/page/assets/model/follow_record_entity.dart';
import 'package:bitfrog/ui/page/assets/model/sort_type_entity.dart';
import 'package:bitfrog/ui/page/assets/request/assets_api.dart';
import 'package:bitfrog/utils/object_util.dart';

class FollowRecordModel extends ViewStateModel {
  List<SortTypeEntity> typeList = [];
  List<FollowRecord> recordList = [];
  int page = 1;
  int pageSize = 20;
  String type = '0';
  String days = '7';
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

  FollowRecordModel() : super(viewState: ViewState.first);

  @override
  void dispose() {
    super.dispose();
  }

  void listenEvent() {
    Event.eventBus.on<CancelWidthDrawEvent>().listen((event) {
      refresh();
    });
  }

  Future refresh() {
    page = 1;
    noMore = false;
    return getFollowRecord(page, pageSize);
  }

  Future loadMore() {
    page++;
    return getFollowRecord(page, pageSize);
  }

  Future getFollowRecord(int page, int size) {
    return AssetsApi.instance.getFollowLedger(type, days, page, size,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      FollowRecordEntity recordData = FollowRecordEntity.fromJson(data);
      if (page == 1) {
        recordList.clear();
        recordList.addAll(recordData.data ?? []);
      } else {
        recordList.addAll(recordData.data ?? []);
      }
      noMore = recordList.length >= (recordData.count ?? 0);
      if (ObjectUtil.isEmptyList(recordList)) {
        setEmpty();
      } else {
        setSuccess();
      }
    }, onError: (code, msg) {
      setError(code, message: msg);
      return false;
    });
  }

  Future getFollowLedgerType() {
    return AssetsApi.instance.getFollowLedgerType(
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
