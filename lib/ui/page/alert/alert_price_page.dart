import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/event/alert_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/model/price_history_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/ui/page/alert/alert_symbol_page.dart';
import 'package:bitfrog/ui/page/alert/item/alert_price_current_item.dart';
import 'package:bitfrog/ui/page/alert/item/alert_price_history_item.dart';
import 'package:bitfrog/ui/page/alert/viewmodel/alert_price_model.dart';
import 'package:bitfrog/ui/view/base_view.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:bitfrog/ui/view/refresh_head_view.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/widget/box_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'view/alert_floating_action_add_button.dart';

///价格提醒页面
class AlertPricePage extends StatefulWidget {
  const AlertPricePage({Key? key}) : super(key: key);

  @override
  State<AlertPricePage> createState() => _AlertPricePageState();
}

class _AlertPricePageState extends State<AlertPricePage>
    with
        AutomaticKeepAliveClientMixin<AlertPricePage>,
        SingleTickerProviderStateMixin {
  final AlertPriceModel _priceModel = AlertPriceModel();
  final bgColor = Colours.def_view_bg_1_color;

@override
void initState() {
    // TODO: implement initState
    super.initState();
    Event.eventBus.on<AlertPriceRefreshEvent>().listen((event) {
      _priceModel.refresh();

    });
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<AlertPriceModel>(
      model: _priceModel,
      builder: (context, model, child) {
        return Scaffold(
          appBar: MyAppBar(title: S.of(context).alert_price),
          backgroundColor: bgColor,
          body: SafeArea(
            minimum: EdgeInsets.only(bottom: 15.h),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecorations.cardBoxDecoration(radius: 4.r),
              margin: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 0),
              child: FBRefreshHeadView(
                viewState: model.viewState,
                itemCount: model.dataList.length,
                onRefresh: () {
                  model.refresh();
                  model.getPriceAlertCurrent();
                },
                onClickRefresh: model.clickRefresh,
                enablePullUp: false,
                onLoadMore: model.loadMore,
                controller: model.controller,
                scrollController: model.scrollController,
                placeholderHeight: ScreenHelper.screenHeight / 2.0,
                placeholderWidth: ScreenHelper.screenWidth,
                header: Container(),
                placeHoldTopHeight: 100.h,
                emptyWidget: Container(
                  height: 330.h,
                  width: double.infinity,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Image.asset(Assets.imagesAlertListEmpty, width: 180.w),
                      SizedBox(height: 5.h),
                      Text(
                        S.of(context).alert_text_8,
                        style: TextStyle(
                            color: Colours.text_color_4, fontSize: 13.sp),
                      )
                    ],
                  ),
                ),
                headView: _headView(),
                itemBuilder: (BuildContext context, int index) {
                  PriceHistoryEntity item = model.dataList[index];
                  return AlertPriceHistoryItem(
                    item: item,
                    showBottomLine: index != model.dataList.length - 1,
                  );
                },
              ),
            ),
          ),
          floatingActionButton: AlterFloatingActionAddButton(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (build) => const AlertSymbolPage(type: 0),
              );
            },
          ),
          floatingActionButtonLocation: AlterFloatingActionAddButton.location,
        );
      },
    );
  }

  Widget _headView() {
    final configs = _priceModel.alertConfigs;
    return Container(
      color: bgColor,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            child: BaseView(
              viewState: _priceModel.alertConfigState,
              height: 290.h,
              placeHoldTopHeight: 50.h,
              clickRefresh: () =>
                  _priceModel.getPriceAlertCurrent(isInit: true),
              emptyWidget: Container(
                height: 290.h,
                width: double.infinity,
                decoration: BoxDecorations.cardBoxDecoration(radius: 4.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: 140.w,
                      child: Image.asset(Assets.imagesAlertPriceEmpty),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      S.of(context).alert_empty,
                      style: TextStyle(
                          color: Colours.text_color_4, fontSize: 13.sp),
                    ),
                  ],
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(configs.length, (index) {
                  final item = configs[index];
                  return AlertPriceCurrentItem(
                    item: item,
                    showBottomMargin: index != configs.length - 1,
                    onDelete: (id) {
                      if (id != null) {
                        _priceModel.deletePriceAlert(id);
                      }
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.h),
            decoration: BoxDecorations.bottomLine(
              bgColor: Colours.def_view_bg_1_color,
            ),
            child: Container(
              padding: EdgeInsets.only(left: 15.w),
              height: 40.h,
              decoration: BoxDecorations.topRectRound(),
              alignment: Alignment.centerLeft,
              child: Text(
                S.current.alert_message,
                style: TextStyle(
                  color: Colours.text_color_2,
                  fontSize: 15.sp,
                  fontWeight: BFFontWeight.medium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
