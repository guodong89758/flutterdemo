import 'dart:async';

import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/event/asset_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/ui/page/assets/model/asset_record_entity.dart';
import 'package:bitfrog/ui/page/assets/request/assets_api.dart';
import 'package:bitfrog/utils/object_util.dart';

class AssetRecordModel extends ViewStateModel {
  List<RecordEntity> recordList = [];
  int page = 1;
  int pageSize = 20;
  int type = 0;
  String currency = 'USDT';

  bool noMore = false;

  AssetRecordModel() : super(viewState: ViewState.first);

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
    return getAssetRecord(page, pageSize);
  }

  Future loadMore() {
    page++;
    return getAssetRecord(page, pageSize);
  }

  Future getAssetRecord(int page, int size) {
    return AssetsApi.instance.getAssetRecord(currency, type, '', '', page, size,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      AssetRecordEntity recordData = AssetRecordEntity.fromJson(data);
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
}
