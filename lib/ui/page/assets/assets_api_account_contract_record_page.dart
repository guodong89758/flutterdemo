import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/ui/page/assets/item/spot_record_item.dart';
import 'package:bitfrog/ui/page/assets/model/spot_record_entity.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/assets_api_account_contract_record_model.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/assets_api_account_spot_record_model.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/spot_record_model.dart';
import 'package:bitfrog/ui/view/base_sort_view.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:bitfrog/ui/view/refresh_view.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/widget/behavior/over_scroll_behavior.dart';
import 'package:bitfrog/widget/refresh/base_empty_page.dart';
import 'package:bitfrog/widget/refresh/base_loading_page.dart';
import 'package:bitfrog/widget/sheet_popup_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///合约记录
class AssetsApiAccountContractRecordPage extends StatefulWidget {
  const AssetsApiAccountContractRecordPage({Key? key}) : super(key: key);

  @override
  State<AssetsApiAccountContractRecordPage> createState() => _AssetsApiAccountContractRecordPageState();
}

class _AssetsApiAccountContractRecordPageState extends State<AssetsApiAccountContractRecordPage> {

  late AssetsApiAccountContractRecordModel _model;
  final GlobalKey sortKey = GlobalKey();
  late SheetPopupWindow typePopup;
  late SheetPopupWindow timePopup;

  @override
  void initState() {
    super.initState();
    _model = AssetsApiAccountContractRecordModel();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.white,
      appBar: const MyAppBar(
        title: "合约记录",
        bottomLine: true,
      ),
      body: ProviderWidget<AssetsApiAccountContractRecordModel>(
        model: _model,
        builder: (context, model, child) {
          return Column(
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

                        },
                        child: Container(
                          height: 35.h,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(_model.curCurrencyName,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colours.text_color_4)),
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
                              Text(_model.curTypeName,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colours.text_color_4)),
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
                              Text(_model.curDayName,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colours.text_color_4)),
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
                child: FBRefresherView(
                  viewState: _model.viewState,
                  itemCount: model.dataList.length,
                  onRefresh: () {
                    model.refresh();
                  },
                  enablePullUp: false,
                  onLoadMore: model.loadMore,
                  onClickRefresh: model.clickRefresh,
                  controller: model.controller,
                  scrollController: model.scrollController,
                  header: Container(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container();
                  },
                ),


                // ScrollConfiguration(
                //     behavior: OverScrollBehavior(),
                //     child: SmartRefresher(
                //         controller: _refreshController,
                //         enablePullDown: true,
                //         enablePullUp: !model.noMore,
                //         onRefresh: model.refresh,
                //         onLoading: model.noMore ? null : model.loadMore,
                //         child: model.isFirst || model.isBusy
                //             ? refreshWidget
                //             : (model.isEmpty || model.isError)
                //                 ? emptyWidget
                //                 : CustomScrollView(
                //                     slivers: [
                //                       SliverList(
                //                         delegate: SliverChildBuilderDelegate(
                //                             (context, index) {
                //                           SpotRecord item =
                //                               _model.recordList[index];
                //                           return SpotRecordItem(item: item);
                //                         }, childCount: model.recordList.length),
                //                       ),
                //                     ],
                //                   ))),
              ),
            ],
          );
        },
      ),
    );
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
