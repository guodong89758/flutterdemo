import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/alert/item/alert_config_detail_item.dart';
import 'package:bitfrog/ui/page/alert/model/subscribe_item_entity.dart';
import 'package:bitfrog/ui/page/alert/view/alert_timeline_group_view.dart';
import 'package:bitfrog/ui/page/alert/view/subscribe_button.dart';
import 'package:bitfrog/ui/page/alert/view/timeline_clock_view.dart';
import 'package:bitfrog/ui/page/alert/viewmodel/alert_config_detail_model.dart';
import 'package:bitfrog/ui/page/community/common_share_page.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:bitfrog/ui/view/refresh_view.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/widget/refresh/base_empty_page.dart';
import 'package:bitfrog/widget/sliver_persistent_header_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sliver_tools/sliver_tools.dart';

///提醒配置详情页
class AlertConfigDetailPage extends StatefulWidget {
  const AlertConfigDetailPage({Key? key, required this.type}) : super(key: key);
  final String? type;

  @override
  State<AlertConfigDetailPage> createState() => _AlertConfigDetailPageState();
}

class _AlertConfigDetailPageState extends State<AlertConfigDetailPage>
    with
        BasePageMixin<AlertConfigDetailPage>,
        AutomaticKeepAliveClientMixin<AlertConfigDetailPage>,
        SingleTickerProviderStateMixin {
  final RefreshController _refreshController = RefreshController();
  late AlertConfigDetailModel _model;

  @override
  void initState() {
    super.initState();
    _model = AlertConfigDetailModel();
    _model.type = widget.type ?? '';
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        initViewModel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<AlertConfigDetailModel>(
      model: _model,
      builder: (context, model, child) {
        return Scaffold(
          appBar: MyAppBar(
            title: _model.detailEntity?.title ?? '',
            bottomLine: true,
            action: InkWell(
              onTap: () {
                if (_model.detailEntity == null) {
                  return;
                }
                _model.getShareData();
                Parameters parameters = Parameters();
                parameters.putObj(
                    "commonSharePageType", CommonSharePageType.alertConfig);
                parameters.putObj("alertConfigShareEntity", _model.shareData);
                Routers.navigateTo(context, Routers.commonShare,
                    parameters: parameters);
              },
              child: Container(
                height: 44.h,
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                alignment: Alignment.center,
                child: Image(
                    width: 20.w,
                    height: 20.h,
                    image: ImageUtil.getAssetImage(Assets.imagesBaseShare)),
              ),
            ),
          ),
          body: Container(
              color: Colours.white,
              child: FBRefresherView(
                viewState: model.viewState,
                controller: _refreshController,
                itemCount: model.eventList.length +
                    (model.detailEntity?.data?.length ?? 0),
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: model.refresh,
                onLoadMore: model.loadMore,

                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: (_model.detailEntity?.setPageDesc ?? '').isEmpty
                          ? Gaps.empty
                          : Container(
                              color: Colours.white,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                14.w,
                                                15.h,
                                                (_model.detailEntity?.data ??
                                                                [])
                                                            .length ==
                                                        1
                                                    ? 10.w
                                                    : 14.w,
                                                15.h),
                                            child: Text(
                                                _model.detailEntity
                                                        ?.setPageDesc ??
                                                    '',
                                                style: TextStyle(
                                                    color: Colours.text_color_3,
                                                    fontSize: 14.sp))),
                                      ),
                                      (_model.detailEntity?.data ?? []).isEmpty
                                          ? Gaps.empty
                                          : Visibility(
                                              visible:
                                                  (_model.detailEntity?.data ??
                                                              [])
                                                          .length ==
                                                      1,
                                              child: InkWell(
                                                onTap: () {
                                                  showProgress();
                                                  (_model.detailEntity?.data ??
                                                          [])[0]
                                                      .subscribeSwitch = (_model
                                                                      .detailEntity
                                                                      ?.data ??
                                                                  [])[0]
                                                              .subscribeSwitch ==
                                                          1
                                                      ? 0
                                                      : 1;
                                                  _model.subcribeSwitch(
                                                      (_model.detailEntity
                                                                      ?.data ??
                                                                  [])[0]
                                                              .subscribeKey ??
                                                          '',
                                                      ((_model.detailEntity
                                                                          ?.data ??
                                                                      [])[0]
                                                                  .subscribeSwitch ??
                                                              0)
                                                          .toInt());
                                                },
                                                child: SubcribeButton(
                                                    key: _model
                                                        .subscribeGlobalKey,
                                                    isSubscribe: ((_model
                                                                        .detailEntity
                                                                        ?.data ??
                                                                    [])[0]
                                                                .subscribeSwitch ??
                                                            0)
                                                        .toInt()),
                                              ))
                                    ],
                                  ),
                                  Gaps.spaceView,
                                ],
                              ),
                            ),
                    ),
                    SliverVisibility(
                      visible: (_model.detailEntity?.data ?? []).length > 1,
                      sliver: SliverFixedExtentList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          SubscribeItemEntity item =
                              (_model.detailEntity?.data ?? [])[index];
                          return AlertConfigDetailItem(
                            index: index,
                            count: (_model.detailEntity?.data ?? []).length,
                            item: item,
                            onChange: (entity) {
                              showProgress();
                              _model.subcribeSwitch(entity.subscribeKey ?? '',
                                  (entity.subscribeSwitch ?? 0).toInt());
                            },
                          );
                        },
                            childCount:
                                (_model.detailEntity?.data ?? []).length),
                        itemExtent: 50.h,
                      ),
                    ),
                    SliverVisibility(
                        visible: (_model.detailEntity?.data ?? []).length > 1,
                        sliver:
                            const SliverToBoxAdapter(child: Gaps.spaceView)),
                    SliverPersistentHeader(
                      pinned: true,
                      floating: true,
                      delegate: AppSliverPersistentHeaderDelegate(
                        child: Container(
                          color: Colours.white,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 14.w),
                          child: Text(S.current.alert_message,
                              style: TextStyle(
                                  color: Colours.text_color_2,
                                  fontSize: 16.sp,
                                  fontWeight: BFFontWeight.medium)),
                        ),
                        maxHeight: 50.h,
                        minHeight: 50.h,
                      ),
                    ),
                    _model.timelineList.isEmpty
                        ? SliverToBoxAdapter(

                            child: Container(
                              padding: EdgeInsets.only(top: 14.w),

                                width: ScreenHelper.screenWidth,
                                height:  ScreenHelper.screenHeight-140,
                                child: const BaseEmptyPage()))
                        : SliverStickyHeader(
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
                                          type: 2,
                                          timeline: _model.timelineList[index],
                                          isLast: index ==
                                              _model.timelineList.length - 1,
                                        )).toList()))
                  ],
                ),
              )),
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
