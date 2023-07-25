import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/ui/page/alert/view/alert_timeline_group_view.dart';
import 'package:bitfrog/ui/page/alert/view/timeline_clock_view.dart';
import 'package:bitfrog/ui/page/alert/viewmodel/alert_timeline_model.dart';
import 'package:bitfrog/ui/view/refresh_view.dart';
import 'package:bitfrog/widget/refresh/base_empty_page.dart';
import 'package:bitfrog/widget/refresh/base_loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sliver_tools/sliver_tools.dart';

class AlertTimeLinePage extends StatefulWidget {
  const AlertTimeLinePage({Key? key}) : super(key: key);

  @override
  State<AlertTimeLinePage> createState() => _AlertTimeLinePageState();
}

class _AlertTimeLinePageState extends State<AlertTimeLinePage>
    with
        BasePageMixin<AlertTimeLinePage>,
        AutomaticKeepAliveClientMixin<AlertTimeLinePage> {
  final RefreshController _refreshController = RefreshController();
  late AlertTimelineModel _model;

  @override
  void initState() {
    super.initState();
    _model = AlertTimelineModel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        initViewModel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<AlertTimelineModel>(
      model: _model,
      builder: (context, model, child) {
        Widget loadingWidget = const BaseLoadingPage();
        Widget emptyWidget = BaseEmptyPage(
            text: S.current.alert_text_6,
            image: Assets.imagesAlertSubscribeEmpty,
            imageWidth: 230.w,
            imageHeight: 120.h,
            onEmptyClick: () {
              _model.refresh();
            });

        return FBRefresherView(
          viewState: model.viewState,
          loadingWidget: loadingWidget,
          emptyWidget: emptyWidget,
          controller: _refreshController,
          itemCount: model.eventList.length,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: model.refresh,
          onLoadMore: model.loadMore,
          child: CustomScrollView(slivers: [
            SliverStickyHeader(
                overlapsContent: true,
                header: Container(
                  padding: EdgeInsets.only(top: 10.h),
                  alignment: Alignment.topRight,
                  child: const TimeLineClockView(),
                ),
                sliver: MultiSliver(
                    children: List.generate(
                        _model.timelineList.length,
                        (index) => AlertTimelineGroupView(
                              type: 1,
                              timeline: _model.timelineList[index],
                              isLast: index == _model.timelineList.length - 1,
                              onSubscribeClick: (alertEvent) {
                                showProgress();
                                _model.subcribeSwitch(
                                    alertEvent.subscribeType ?? '',
                                    alertEvent.subscribeKey ?? '',
                                    1);
                              },
                            )).toList()))
          ]),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> refresh({slient = false}) {
    if (slient) {
      return _model.refresh();
    } else {
      return Future<void>.delayed(const Duration(milliseconds: 100), () {
        _refreshController.requestRefresh();
      });
    }
  }

  void initViewModel() {
    _model.refresh();
    _model.listenEvent();

    _model.addListener(() {
      closeProgress();
      if (_model.isError) {
        if (_model.page == 1) {
          _refreshController.refreshFailed();
        } else {
          _refreshController.loadFailed();
        }
      } else if (_model.isSuccess || _model.isEmpty) {
        if (_model.page == 1) {
          _refreshController.refreshCompleted(resetFooterState: !_model.noMore);
        } else {
          if (_model.noMore) {
            _refreshController.loadNoData();
          } else {
            _refreshController.loadComplete();
          }
        }
      }
    });
  }
}
