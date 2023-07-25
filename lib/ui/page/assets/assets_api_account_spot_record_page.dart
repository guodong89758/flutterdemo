import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/constant/config.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/model/symbol_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/assets_api_account_spot_record_model.dart';
import 'package:bitfrog/ui/view/base_sort_view.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:bitfrog/ui/view/refresh_view.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/widget/sheet_popup_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///现货记录
class AssetsApiAccountSpotRecordPage extends StatefulWidget {
  const AssetsApiAccountSpotRecordPage({Key? key}) : super(key: key);

  @override
  State<AssetsApiAccountSpotRecordPage> createState() => _AssetsApiAccountSpotRecordPageState();
}

class _AssetsApiAccountSpotRecordPageState extends State<AssetsApiAccountSpotRecordPage> {

  late AssetsApiAccountSpotRecordModel _model;
  final GlobalKey sortKey = GlobalKey();
  late SheetPopupWindow typePopup;
  late SheetPopupWindow timePopup;

  @override
  void initState() {
    super.initState();
    _model = AssetsApiAccountSpotRecordModel();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.white,
      appBar: const MyAppBar(
        title: "现货记录",
        bottomLine: true,
      ),
      body: SafeArea(
        child: ProviderWidget<AssetsApiAccountSpotRecordModel>(
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
                            Routers.navigateToResult(context, Routers.tradeSymbol,
                                parameters: Parameters()
                                  ..putString('type', Config.tradeSpot), (result) {
                                  BFSymbol symbol = result as BFSymbol;
                                  setState(() {
                                    _model.curCurrencyName =
                                    symbol.symbolTitle == S.current.action_all
                                        ? "币对"
                                        : symbol.symbolTitle ?? '';
                                  });
                                  _model.refresh();
                                });
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
                    viewState: ViewState.success,
                    itemCount: 5,
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
                      return _item();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
  
  Widget _item(){
    return Container(
      padding: EdgeInsets.only(left: 14.w,right: 14.w,top: 15.h,bottom: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("LOOM/USDT",style: TextStyle(
                color: Colours.text_color_2,
                fontSize: 15.sp,
                fontWeight: BFFontWeight.medium,
                fontFamily: BFFontFamily.din
              ),),
              Text("2023-03-23 14:2:58",style: TextStyle(
                  color: Colours.text_color_4,
                  fontSize: 12.sp,
                  fontWeight: BFFontWeight.medium,
                  fontFamily: BFFontFamily.din
              ),),
            ],
          ),
          Gaps.vGap4,
          Text("卖出",style: TextStyle(
              color: Colours.def_red,
              fontSize: 14.sp,
              fontWeight: BFFontWeight.medium,
          ),),
          _itemContent("价格(USDT)", "0.04235"),
          _itemContent("成交数量(USDT)", "0.04235"),
          _itemContent("角色", "Taker"),
          _itemContent("手续费(USDT)", "0.43254323"),
          _itemContent("总量(USDT)", "0.43254323")
        ],
      ),
    );
  }

  Widget _itemContent(String title,String content){
    return Container(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: TextStyle(
            fontSize: 14.sp,
            color: Colours.text_color_4
          ),),
          Text(content,style: TextStyle(
              fontSize: 14.sp,
              color: Colours.text_color_2,
            fontFamily: BFFontFamily.din,
            fontWeight: BFFontWeight.medium
          ),)
        ],
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
