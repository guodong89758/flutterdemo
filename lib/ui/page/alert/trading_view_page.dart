import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/logic/app_config_manager.dart';
import 'package:bitfrog/model/app_confg_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/alert/item/quotation_choose_item.dart';
import 'package:bitfrog/ui/page/alert/item/trading_cell_item.dart';
import 'package:bitfrog/ui/page/alert/model/trading_view_history_entity.dart';
import 'package:bitfrog/ui/view/refresh_head_view.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'viewmodel/trading_view_model.dart';

class TradingViewPage extends StatefulWidget {
  const TradingViewPage({Key? key}) : super(key: key);

  @override
  State<TradingViewPage> createState() => _TradingViewPageState();
}

class _TradingViewPageState extends State<TradingViewPage> {
  late final TradingViewModel _tradingModel = TradingViewModel();

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<TradingViewModel>(
      model: _tradingModel,
      builder: (context, model, child) {
        return FBRefreshHeadView(
          viewState: model.viewState,
          itemCount: model.historyEventEntityList?.length ?? 0,
          onRefresh: model.refresh,
          onLoadMore: model.loadMore,
          onClickRefresh: model.clickRefresh,
          controller: model.controller,
          scrollController: model.scrollController,
          placeholderHeight: ScreenHelper.screenHeight / 2.0,
          placeholderWidth: ScreenHelper.screenWidth,
          headView: bodyView(context),
          emptyWidget: Container(child: boomView()),
          itemBuilder: (BuildContext context, int index) {
            HistoryEvent contractModel = model.historyEventEntityList[index];
            return TradingViewCellItem(item: contractModel);
          },
        );
      },
    );
  }

  Widget bodyView(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
              left: 14.w,
              right: 14.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15.h),
                      alignment: Alignment.centerRight,
                      child: Text(
                        S.current.trading_view_text1,
                        style: TextStyle(
                          color: Colours.text_color_2,
                          fontSize: 14.sp,
                          fontWeight: BFFontWeight.medium,
                        ),
                      ),
                    ),
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              Parameters parameters = Parameters();

                              AppConfigEntity? appConfigEntity =  AppConfigManager.instance.appConfig;
                              parameters.putString(
                                  "url",appConfigEntity?.usertvcourseurl ?? '');
                              parameters.putInt(
                                  "token",1);

                              parameters.putString(
                                  "title", S.current.trading_view_text);

                              Routers.navigateTo(
                                  context, Routers.mineWebViewCommonPage,
                                  parameters: parameters);
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 15.h),
                              alignment: Alignment.centerRight,
                              child: Text(
                                S.current.trading_view_text,
                                style: TextStyle(
                                  color: Colours.app_main,
                                  fontSize: 14.sp,
                                  // fontWeight: BFFontWeight.medium,
                                ),
                              ),
                            )))
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  // margin: EdgeInsets.symmetric(horizontal: 14.w),
                  padding: EdgeInsets.only(left: 10.w),
                  alignment: Alignment.centerLeft,
                  constraints: BoxConstraints(minHeight: 40.h),
                  decoration: const BoxDecoration(
                    color: Colours.def_view_bg_1_color,
                    borderRadius: BorderRadius.all(
                      Radius.circular(2),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Text(
                            _tradingModel.configEntity.web_hook_url ?? '',
                            softWrap: true,
                            style: TextStyle(
                                color: Colours.text_color_2,
                                fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // if ((_model.infoData?.address ?? '').isEmpty) {
                          //   return;
                          // }
                          Clipboard.setData(ClipboardData(
                              text: _tradingModel.configEntity.web_hook_url ??
                                  ''));
                          ToastUtil.show(S.current.copy_success);
                        },
                        child: Container(
                          height: 40.h,
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          alignment: Alignment.center,
                          child: Image(
                              width: 18.w,
                              height: 18.h,
                              image: ImageUtil.getAssetImage(
                                  Assets.imagesBaseCopy)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.current.alert_type,
                    style: TextStyle(
                      color: Colours.text_color_2,
                      fontSize: 14.sp,
                      fontWeight: BFFontWeight.medium,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TypeQuotationWidget(
                  selected:  true,
                  selected1: (_tradingModel.configEntity.alertPush ?? 0) <= 0
                      ? false
                      : true,
                  selected2: (_tradingModel.configEntity.voicePush ?? 0) <= 0
                      ? false
                      : true,
                  myCallBack: (type, selected, selected1, selected2) {
                    if(type==0){
                      return;
                    }
                    _tradingModel.tradingSetTradingSetTrigger(
                        selected, selected1, selected2,context: context);
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 9.h,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.current.trading_view_text3,
                    style: TextStyle(
                      color: Colours.def_yellow,
                      fontSize: 12.sp,
                      fontWeight: BFFontWeight.normal,
                    ),
                  ),
                ),

              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Gaps.spaceView,
          Container(padding: EdgeInsets.only(
            left: 14.w,

          ), child:Visibility(
              visible:
              (_tradingModel.historyEventEntity.data?.length ?? 0) <=
                  0
                  ? false
                  : true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.current.trading_view_text8,
                      style: TextStyle(
                        color: Colours.text_color_2,
                        fontSize: 14.sp,
                        fontWeight: BFFontWeight.medium,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Gaps.hLine,

                ],
              )) ,)


        ],
      ),
    );
  }

  Widget boomView() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 14.h),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              S.current.trading_view_text4,
              style: TextStyle(
                color: Colours.text_color_2,
                fontSize: 14.sp,
                fontWeight: BFFontWeight.medium,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              S.current.trading_view_text5,
              style: TextStyle(
                color: Colours.text_color_4,
                fontSize: 12.sp,
                fontWeight: BFFontWeight.normal,
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              S.current.trading_view_text6,
              style: TextStyle(
                color: Colours.text_color_2,
                fontSize: 14.sp,
                fontWeight: BFFontWeight.medium,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              S.current.trading_view_text7,
              style: TextStyle(
                color: Colours.text_color_4,
                fontSize: 12.sp,
                fontWeight: BFFontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
