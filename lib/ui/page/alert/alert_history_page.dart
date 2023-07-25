import 'package:bitfrog/ui/page/alert/model/alert_type_entity.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/event/alert_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/model/alert_history_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/ui/page/alert/item/alert_history_item.dart';
import 'package:bitfrog/ui/page/alert/viewmodel/alert_history_model.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/widget/behavior/over_scroll_behavior.dart';
import 'package:bitfrog/widget/refresh/base_empty_page.dart';
import 'package:bitfrog/widget/refresh/base_loading_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///历史提醒页面
class AlertHistoryPage extends StatefulWidget {
  const AlertHistoryPage({Key? key}) : super(key: key);

  @override
  State<AlertHistoryPage> createState() => _AlertHistoryPageState();
}

class _AlertHistoryPageState extends State<AlertHistoryPage>
    with
        BasePageMixin<AlertHistoryPage>,
        AutomaticKeepAliveClientMixin<AlertHistoryPage>,
        SingleTickerProviderStateMixin {
  final RefreshController _refreshController = RefreshController();
  late AlertHistoryModel _historyModel;

  @override
  void initState() {
    super.initState();
    _historyModel = AlertHistoryModel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        initViewModel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<AlertHistoryModel>(
      model: _historyModel,
      builder: (context, model, child) {
        Widget refreshWidget = const BaseLoadingPage();
        Widget emptyWidget = BaseEmptyPage(
          text: S.current.alert_history_empty,
          image: Assets.imagesAlertHistoryEmpty,
          imageWidth: 110.w,
          imageHeight: 90.h,
          onEmptyClick: () {
            _historyModel.refresh();
          },
        );
        return Scaffold(
          body: Container(
              color: Colours.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    decoration: const BoxDecoration(
                      color: Colours.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colours.black_4,
                            offset: Offset(0, 1),
                            blurRadius: 5.0,
                            spreadRadius: 1)
                      ],
                    ),
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: _historyModel.typeList.length,
                        padding:  EdgeInsets.fromLTRB(14.w, 15.h, 14.w, 15.h),
                        gridDelegate:
                             SliverGridDelegateWithFixedCrossAxisCount(
                          //设置列数
                          crossAxisCount: 4,
                          //设置横向间距
                          crossAxisSpacing: 15.w,
                          //设置主轴间距
                          mainAxisSpacing: 15.h,
                          childAspectRatio: 151 / 52,
                        ),
                        itemBuilder: (context, position) {
                          AlertTypeEntity item =
                              _historyModel.typeList[position];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                item.checked = !(item.checked ?? false);
                              });
                              Event.eventBus.fire(AlertHistoryTypeEvent());
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: (ScreenHelper.screenWidth -
                                      ScreenHelper.width(95)) /
                                  4,
                              decoration: BoxDecoration(
                                color: (item.checked ?? false)
                                    ? Colours.app_main
                                    : Colours.def_view_bg_1_color,
                                borderRadius: BorderRadius.circular(1),
                              ),
                              child: Text(
                                item.title ?? '',
                                maxLines: 1,
                                style: TextStyle(
                                  color: (item.checked ?? false)
                                      ? Colours.white
                                      : Colours.text_color_3,
                                  fontSize: Dimens.font_sp12,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Expanded(
                    child: Container(
                        color: Colours.def_view_bg_1_color,
                        child: ScrollConfiguration(
                            behavior: OverScrollBehavior(),
                            child: SmartRefresher(
                                controller: _refreshController,
                                enablePullDown: true,
                                enablePullUp: true,
                                onRefresh: model.refresh,
                                onLoading: model.loadMore,
                                child: model.isFirst
                                    ? refreshWidget
                                    : (model.isEmpty || model.isError)
                                        ? emptyWidget
                                        : CustomScrollView(
                                            slivers: [
                                              SliverToBoxAdapter(
                                                child: SizedBox(
                                                  width:
                                                      ScreenHelper.screenWidth,
                                                  height:
                                                      ScreenHelper.height(10),
                                                ),
                                              ),
                                              SliverList(
                                                delegate:
                                                    SliverChildBuilderDelegate(
                                                        (context, index) {
                                                  History item =
                                                      model.historyList[index];
                                                  return AlertHistoryItem(
                                                      index: index,
                                                      count: model
                                                          .historyList.length,
                                                      item: item);
                                                },
                                                        childCount: model
                                                            .historyList
                                                            .length),
                                              ),
                                            ],
                                          )))),
                  )
                ],
              )),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> refresh({slient = false}) {
    if (slient) {
      return _historyModel.refresh();
    } else {
      return Future<void>.delayed(const Duration(milliseconds: 100), () {
        _refreshController.requestRefresh();
      });
    }
  }

  void initViewModel() {
    _historyModel.getAlertConfigData();
    _historyModel.listenEvent();

    _historyModel.addListener(() {
      if (_historyModel.isError) {
        if (_historyModel.page == 1) {
          _refreshController.refreshFailed();
        } else {
          _refreshController.loadFailed();
        }
      } else if (_historyModel.isSuccess || _historyModel.isEmpty) {
        if (_historyModel.page == 1) {
          _refreshController.refreshCompleted(
              resetFooterState: !_historyModel.noMore);
        } else {
          if (_historyModel.noMore) {
            _refreshController.loadNoData();
          } else {
            _refreshController.loadComplete();
          }
        }
      }
    });
  }
}
