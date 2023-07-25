import 'dart:async';

import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/event/alert_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/ui/page/alert/model/alert_config_share_entiry.dart';
import 'package:bitfrog/ui/page/alert/model/alert_event_entity.dart';
import 'package:bitfrog/ui/page/alert/model/alert_type_detail_entity.dart';
import 'package:bitfrog/ui/page/alert/model/timeline_entiry.dart';
import 'package:bitfrog/ui/page/alert/request/alert_api.dart';
import 'package:bitfrog/ui/page/alert/view/subscribe_button.dart';
import 'package:bitfrog/utils/toast_util.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

class AlertConfigDetailModel extends ViewStateModel {
  String? type;
  AlertTypeDetailEntity? detailEntity;
  List<AlertEvent> eventList = [];
  List<TimeLineEntity> timelineList = [];
  GlobalKey<State<SubcribeButton>> subscribeGlobalKey = GlobalKey();
  AlertConfigShareEntity shareData = AlertConfigShareEntity();
  int page = 1;
  int pageSize = 20;

  bool noMore = false;

  AlertConfigDetailModel() : super(viewState: ViewState.first);

  @override
  void dispose() {
    super.dispose();
  }

  void listenEvent() {}

  Future refresh() async {
    page = 1;
    noMore = false;
    await Future.wait<dynamic>(
        [getSubscribeItems(), getTimelineData(type ?? '', page, pageSize)]);
  }

  Future loadMore() {
    page++;
    return getTimelineData(type ?? '', page, pageSize);
  }

  Future getTimelineData(String type, int page, int size) {
    return AlertApi.instance.getSubscribeEvents(type, page, size,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      AlertEventEntity eventData = AlertEventEntity.fromJson(data);
      if (page == 1) {
        timelineList.clear();
        eventList.clear();
        eventList.addAll(eventData.data ?? []);
      } else {
        eventList.addAll(eventData.data ?? []);
      }
      mergeTimelineData(eventData.data ?? [], false);
      noMore = eventList.length >= (eventData.count ?? 0);
      if (ObjectUtil.isEmptyList(eventList)) {
        setEmpty();
      } else {
        setSuccess();
      }
    }, onError: (code, msg) {
      setError(code, message: msg);
      return false;
    });
  }

  void mergeTimelineData(List<AlertEvent> data, bool isShareData) {
    if (data.isEmpty) {
      return;
    }
    if (isShareData) {
      shareData.shareList = [];
    }
    String dateStr = '';
    if (page == 1) {
      dateStr = DateUtil.formatDateMs(((data[0].timestamp ?? 0) * 1000).toInt(),
          format: "yyyy-MM-dd");
      TimeLineEntity timeline = TimeLineEntity();
      List<AlertEvent> recordList = [];
      timeline.timestamp = data[0].timestamp;
      timeline.data = recordList;
      if (isShareData) {
        shareData.shareList?.add(timeline);
      } else {
        timelineList.add(timeline);
      }
    } else {
      dateStr = DateUtil.formatDateMs(
          ((timelineList.last.timestamp ?? 0) * 1000).toInt(),
          format: "yyyy-MM-dd");
    }

    for (var element in data) {
      String tempDate = DateUtil.formatDateMs(
          ((element.timestamp ?? 0) * 1000).toInt(),
          format: "yyyy-MM-dd");
      if (tempDate == dateStr) {
        if (isShareData) {
          shareData.shareList?.last.data?.add(element);
        } else {
          timelineList.last.data?.add(element);
        }
      } else {
        dateStr = tempDate;
        TimeLineEntity timeline = TimeLineEntity();
        List<AlertEvent> recordList = [];
        recordList.add(element);
        timeline.timestamp = element.timestamp;
        timeline.data = recordList;
        if (isShareData) {
          shareData.shareList?.add(timeline);
        } else {
          timelineList.add(timeline);
        }
      }
    }
  }

  void getShareData() {
    shareData.title = detailEntity?.title ?? '';
    shareData.tip = detailEntity?.setPageDesc ?? '';
    if (eventList.length > 5) {
      mergeTimelineData(eventList.sublist(0, 5), true);
    } else {
      mergeTimelineData(eventList, true);
    }
  }

  /// 提醒类型设置项下发
  Future getSubscribeItems() {
    return AlertApi.instance.getSubscribeItems(type ?? '',
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      detailEntity = AlertTypeDetailEntity.fromJson(data);
      setSuccess();
    }, onError: (code, msg) {
      setError(code, message: msg);
      return false;
    });
  }

  /// 设置(取消)提醒
  Future subcribeSwitch(String subscribeKey, int subscribeSwitch) {
    return AlertApi.instance.subcribeSwitch(
        type ?? '', subscribeKey, subscribeSwitch, cancelToken: cancelToken,
        onSuccess: (dynamic data) {
      ToastUtil.show(S.current.alert_set_success);
      Event.eventBus.fire(AlertSubscribeEvent());
      if ((detailEntity?.data ?? []).isNotEmpty &&
          detailEntity?.data?.length == 1) {
        subscribeGlobalKey.currentState?.setState(() {});
        setIdle();
      } else {
        getSubscribeItems();
      }
    }, onError: (code, msg) {
      setError(code);
      return false;
    });
  }
}
