import 'dart:async';

import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/event/alert_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/ui/page/alert/model/alert_event_entity.dart';
import 'package:bitfrog/ui/page/alert/model/timeline_entiry.dart';
import 'package:bitfrog/ui/page/alert/request/alert_api.dart';
import 'package:common_utils/common_utils.dart';

class AlertTimelineModel extends ViewStateModel {
  int? type;
  List<AlertEvent> eventList = [];
  List<TimeLineEntity> timelineList = [];
  int page = 1;
  int pageSize = 20;

  bool noMore = false;

  AlertTimelineModel() : super(viewState: ViewState.first){
    /// 登录之后刷新
    Event.eventBus.on<UserLoginEvent>().listen((event) {
      timelineList.clear();
      setBusy();
      refresh();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void listenEvent() {
    Event.eventBus.on<AlertSubscribeEvent>().listen((event) {
      refresh();
    });
  }

  Future refresh() {
    page = 1;
    noMore = false;
    return getTimelineData(page, pageSize);
  }

  Future loadMore() {
    page++;
    return getTimelineData(page, pageSize);
  }

  Future getTimelineData(int page, int size) {
    return AlertApi.instance.getNotifyEvents(page, size,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      AlertEventEntity eventData = AlertEventEntity.fromJson(data);
      if (page == 1) {
        timelineList.clear();
        eventList.clear();
        eventList.addAll(eventData.data ?? []);
      } else {
        eventList.addAll(eventData.data ?? []);
      }
      mergeTimelineData(eventData.data ?? []);
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

  void mergeTimelineData(List<AlertEvent> data) {
    if (data.isEmpty) {
      return;
    }
    String dateStr = '';
    if (page == 1) {
      dateStr = DateUtil.formatDateMs(((data[0].timestamp ?? 0) * 1000).toInt(),
          format: "yyyy-MM-dd");
      TimeLineEntity timeline = TimeLineEntity();
      List<AlertEvent> recordList = [];
      timeline.timestamp = data[0].timestamp;
      timeline.data = recordList;
      timelineList.add(timeline);
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
        timelineList.last.data?.add(element);
      } else {
        dateStr = tempDate;
        TimeLineEntity timeline = TimeLineEntity();
        List<AlertEvent> recordList = [];
        recordList.add(element);
        timeline.timestamp = element.timestamp;
        timeline.data = recordList;
        timelineList.add(timeline);
      }
    }
  }

  /// 设置(取消)提醒
  Future subcribeSwitch(String type, String subscribeKey, int subscribeSwitch) {
    return AlertApi.instance.subcribeSwitch(type, subscribeKey, subscribeSwitch,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
      refresh();
      Event.eventBus.fire(AlertSubscribeEvent());
    }, onError: (code, msg) {
      setError(code);
      return false;
    });
  }
}
