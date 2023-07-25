import 'package:bitfrog/ui/page/alert/alert_detail_page.dart';
import 'package:bitfrog/widget/dividers.dart';
import 'package:bitfrog/widget/spanable_text.dart';
import 'package:common_utils/common_utils.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/model/price_history_entity.dart';
import 'package:bitfrog/model/symbol_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertPriceHistoryItem extends StatelessWidget {
  final PriceHistoryEntity item;
  final bool showBottomLine;

  const AlertPriceHistoryItem({
    Key? key,
    required this.item,
    required this.showBottomLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // AlertShowTypes? types = params?.getObj("types");
        Parameters params = Parameters();
        params.putString('id', item.id.toString());

        // params.getObj('types', AlertShowTypes.noticeDetail );
        params.putObj("types", AlertShowTypes.historyDetail);
        Routers.navigateTo(context, Routers.alertDetailPage,
            parameters: params);
      },
      child: Container(
        padding: const EdgeInsets.only(left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SpannableText(
                        text: item.content ?? '',
                        defStyle: TextStyle(
                            color: Colours.text_color_2, fontSize: 14.sp),
                        pattern: {item.price ?? '': null},
                        patternStyle: TextStyle(
                          color:
                              item.isFall ? Colours.downColor : Colours.upColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(right: 5),
                        width: ScreenHelper.width(38),
                        height: ScreenHelper.height(38),
                        child: IconButton(
                          padding: const EdgeInsets.all(10),
                          icon: Image.asset(Assets.imagesBaseCopy),
                          onPressed: () {
                            BFSymbol symbol = BFSymbol(
                                id: item.symbolId,
                                symbolKey: item.symbolKey,
                                symbolTitle: item.symbolTitle,
                                exchangeIcon: item.exchangeIcon,
                                exchangeTitle: item.exchangeTitle);
                            Parameters params = Parameters()
                              ..putObj('symbol', symbol);
                            Routers.navigateTo(
                                context, Routers.alertAddPricePage,
                                parameters: params,
                                transition: TransitionType.inFromBottom);
                          },
                          iconSize: ScreenHelper.width(18),
                        ))
                  ],
                )),
            Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          DateUtil.formatDateMs(
                              ((item.timestamp ?? 0) * 1000).toInt(),
                              format: "MM-dd HH:mm:ss"),
                          style: TextStyle(
                              color: Colours.text_color_4, fontSize: 12.sp)),
                      SizedBox(
                        width: 4.w,
                      ),
                      Visibility(
                          // 默认为占位替换，类似于gone
                          visible: item.appPush == 1,
                          child: Container(
                            height: ScreenHelper.height(15),
                            width: ScreenHelper.width(15),
                            margin: const EdgeInsets.only(right: 6),
                            child: Image(
                              image: ImageUtil.getAssetImage(
                                  Assets.imagesAlertApp),
                            ),
                          )),
                      Visibility( visible: item?.voicePush == 1 ? true : false, child:   Container(
                          padding: EdgeInsets.only(
                              left: 4.w, right: 4.w, top: 5.h, bottom: 5.h),
                          decoration: BoxDecoration(
                              color: item?.voiceStatus == 2 ? Colours.def_green_8 : Colours.def_yellow_10,
                              borderRadius:
                              const BorderRadius.all(Radius.circular(3))),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Image(
                                  width: 11.w,
                                  height: 11.h,
                                  image: item?.voiceStatus == 3 ? ImageUtil.getAssetImage(
                                      Assets.imagesAlertPhoneGreen) : ImageUtil.getAssetImage(
                                      Assets.imagesAlertPhoneYellow)),
                              SizedBox(
                                width: 4.w,
                              ),
                              Text(
                                item?.voiceStatusDesc ?? '',
                                style: TextStyle(
                                  color: item?.voiceStatus == 2 ? Colours.app_main: Colours.def_yellow,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ],
                          )) )
                      // Visibility(
                      //     // 默认为占位替换，类似于gone
                      //     visible: item.voicePush == 1,
                      //     child: Container(
                      //       height: ScreenHelper.height(18),
                      //       margin: const EdgeInsets.only(right: 6),
                      //       padding: const EdgeInsets.symmetric(horizontal: 4),
                      //       // alignment: Alignment.centerLeft,
                      //       decoration: BoxDecoration(
                      //         color: item.voiceStatus == 2
                      //             ? Colours.def_yellow_10
                      //             : Colours.def_view_bg_1_color,
                      //         borderRadius: BorderRadius.circular(1.5),
                      //       ),
                      //       child: Row(
                      //         mainAxisSize: MainAxisSize.min,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: <Widget>[
                      //           Container(
                      //               margin: const EdgeInsets.only(right: 4),
                      //               child: Image(
                      //                 image: ImageUtil.getAssetImage(
                      //                     item.voiceStatus == 2
                      //                         ? Assets.imagesAlertPhoneYellow
                      //                         : Assets.imagesAlertPhoneGray),
                      //                 width: ScreenHelper.width(12),
                      //                 height: ScreenHelper.height(12),
                      //               )),
                      //           Flexible(
                      //             fit: FlexFit.loose,
                      //             child: Text(item.voiceStatusDesc ?? '',
                      //                 style: TextStyle(
                      //                     color: item.voiceStatus == 2
                      //                         ? Colours.def_yellow
                      //                         : Colours.text_color_3,
                      //                     fontSize: Dimens.font_sp12)),
                      //           ),
                      //         ],
                      //       ),
                      //     )),
                    ])),
            Visibility(
              // 修改透明度实现隐藏，类似于invisible
              visible: showBottomLine,
              child: Container(
                margin: const EdgeInsets.only(right: 15),
                child: const HDivider(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
