import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/ui/page/assets/item/follow_record_item.dart';
import 'package:bitfrog/ui/page/assets/model/follow_record_entity.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/follow_record_model.dart';
import 'package:bitfrog/ui/view/base_sort_view.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/widget/behavior/over_scroll_behavior.dart';
import 'package:bitfrog/widget/refresh/base_empty_page.dart';
import 'package:bitfrog/widget/refresh/base_loading_page.dart';
import 'package:bitfrog/widget/sheet_popup_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///跟单资金记录
class FollowRecordPage extends StatefulWidget {
  const FollowRecordPage({Key? key}) : super(key: key);

  @override
  State<FollowRecordPage> createState() => _FollowRecordPageState();
}

class _FollowRecordPageState extends State<FollowRecordPage>
    with
        BasePageMixin<FollowRecordPage>,
        AutomaticKeepAliveClientMixin<FollowRecordPage> {
  final RefreshController _refreshController = RefreshController();
  late FollowRecordModel _model;
  final GlobalKey sortKey = GlobalKey();
  late SheetPopupWindow typePopup;
  late SheetPopupWindow timePopup;
  double maxSortTextWidth = 0;

  @override
  void initState() {
    super.initState();
    maxSortTextWidth = ScreenHelper.screenWidth / 2 - 30.w;
    _model = FollowRecordModel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        initViewModel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<FollowRecordModel>(
      model: _model,
      builder: (context, model, child) {
        Widget refreshWidget = const BaseLoadingPage();
        Widget emptyWidget = BaseEmptyPage(onEmptyClick: () {
          _model.refresh();
        });
        return Scaffold(
          backgroundColor: Colours.white,
          appBar: MyAppBar(
            title: S.current.asset_follow_record,
            bottomLine: true,
          ),
          body: Column(
            children: [
              SizedBox(
                key: sortKey,
                height: 35.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (_model.typeArray.isEmpty) {
                            return;
                          }
                          showSortTypePopup(context);
                        },
                        child: Container(
                          height: 35.h,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ConstrainedBox(
                                constraints:
                                    BoxConstraints(maxWidth: maxSortTextWidth),
                                child: Text(_model.curTypeName,
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colours.text_color_4)),
                              ),
                              SizedBox(width: 4.w),
                              Image(
                                width: 12.w,
                                height: 12.h,
                                image: ImageUtil.getAssetImage(
                                    Assets.imagesAssetDown),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (_model.timeArray.isEmpty) {
                            return;
                          }
                          showSortTimePopup(context);
                        },
                        child: Container(
                          height: 35.h,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ConstrainedBox(
                                constraints:
                                    BoxConstraints(maxWidth: maxSortTextWidth),
                                child: Text(_model.curDayName,
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colours.text_color_4)),
                              ),
                              SizedBox(width: 4.w),
                              Image(
                                width: 12.w,
                                height: 12.h,
                                image: ImageUtil.getAssetImage(
                                    Assets.imagesAssetDown),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Gaps.hLine,
              Expanded(
                child: ScrollConfiguration(
                    behavior: OverScrollBehavior(),
                    child: SmartRefresher(
                        controller: _refreshController,
                        enablePullDown: true,
                        enablePullUp: !model.noMore,
                        onRefresh: model.refresh,
                        onLoading: model.noMore ? null : model.loadMore,
                        child: model.isFirst || model.isBusy
                            ? refreshWidget
                            : (model.isEmpty || model.isError)
                                ? emptyWidget
                                : CustomScrollView(
                                    slivers: [
                                      SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                            (context, index) {
                                          FollowRecord item =
                                              _model.recordList[index];
                                          return FollowRecordItem(item: item);
                                        }, childCount: model.recordList.length),
                                      ),
                                    ],
                                  ))),
              ),
            ],
          ),
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
    _model.getFollowLedgerType();
    _model.refresh();
    _model.listenEvent();

    _model.addListener(() {
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

  void showSortTypePopup(BuildContext context) {
    typePopup = showSheetPopupWindow(
      context,
      targetRenderBox:
          (sortKey.currentContext?.findRenderObject() as RenderBox),
      childFun: (pop) {
        return BaseSortView(
            key: GlobalKey(),
            sortList: _model.typeArray,
            selection: _model.typeSelection,
            onChanged: (position) {
              typePopup.dismiss(context);
              _model.typeSelection = position;
              setState(() {
                if (position == 0) {
                  _model.type = '0';
                  _model.curTypeName = S.current.base_category;
                } else {
                  _model.type =
                      (_model.typeList[position - 1].type ?? 0).toString();
                  _model.curTypeName =
                      _model.typeList[position - 1].value ?? '';
                }
              });
              _model.setBusy();
              _model.refresh();
            });
      },
    );
  }

  void showSortTimePopup(BuildContext context) {
    timePopup = showSheetPopupWindow(
      context,
      targetRenderBox:
          (sortKey.currentContext?.findRenderObject() as RenderBox),
      childFun: (pop) {
        return BaseSortView(
            key: GlobalKey(),
            sortList: _model.timeArray,
            selection: _model.timeSelection,
            onChanged: (position) {
              timePopup.dismiss(context);
              _model.timeSelection = position;
              setState(() {
                if (position == 0) {
                  _model.days = '0';
                } else if (position == 1) {
                  _model.days = '7';
                } else if (position == 2) {
                  _model.days = '30';
                } else if (position == 3) {
                  _model.days = '90';
                }
                if (position == 0) {
                  _model.curDayName = S.current.base_time;
                } else {
                  _model.curDayName = _model.timeArray[position];
                }
              });
              _model.setBusy();
              _model.refresh();
            });
      },
    );
  }
}
