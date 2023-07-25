import 'package:bitfrog/event/alert_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/model/symbol_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/assets/model/currency_choose_entity.dart';
import 'package:bitfrog/ui/page/community/community_square_index_page.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyChoiceSymbolItem extends StatelessWidget {
  final int? type;
  final int? index;
  final int? count;
  final SymbolCurrency item;
  final HandleClick? handleClick;

  const CurrencyChoiceSymbolItem(
      {Key? key,
      this.type,
      this.index,
      this.count,
      required this.item,
      this.handleClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (handleClick != null) {
          handleClick?.call();
          return;
        }
        if (type == 0) {
          Routers.goBack(context);
          Parameters params = Parameters()..putObj('symbol', item);
          Routers.navigateTo(context, Routers.alertAddPricePage,
              parameters: params, transition: TransitionType.inFromBottom);
        } else if (type == 1) {
          Routers.goBack(context);
          // Event.eventBus.fire(AlertSymbolEvent(item));
        }
      },
      child: Container(
          width: ScreenHelper.screenWidth,
          // height: ScreenHelper.height(60),
          padding: EdgeInsets.only(left: 14.w,right: 14.w),
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 4),
                        child: CircleAvatar(
                          backgroundColor: Colours.def_view_bg_1_color,
                          radius: 7,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: CachedNetworkImage(
                                width: 14.w,
                                height: 14.h,
                                imageUrl: item.icon ?? '',
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Image.asset(Assets.imagesAlertDefault),
                                errorWidget: (context, url, error) =>
                                    Image.asset(Assets.imagesAlertDefault),
                              )),
                        ),
                      ),
                      Text(
                        item.currency ?? '',
                        style: TextStyle(
                            color: Colours.text_color_2, fontSize: 15.sp,fontWeight: BFFontWeight.medium),
                      )
                    ],
                  )),
                  Container(
                      margin: const EdgeInsets.only(right: 4),
                      child: Text(
                        '${item.withdrawAvailable?.amount ?? ''}',
                        style: TextStyle(
                            color: Colours.text_color_2, fontSize: 15.sp,fontWeight: BFFontWeight.medium,fontFamily: BFFontFamily.din),
                      )),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 22.w,),
                  Expanded(
                      child: Text(
                    'Access Protocol',
                    style:
                        TextStyle(color: Colours.text_color_4, fontSize: 12.sp,fontWeight: BFFontWeight.medium),
                  )),
                  Container(
                      margin: const EdgeInsets.only(right: 4),
                      child: Text(
                        '${item.withdrawAvailable?.worth ?? ''}',
                        style: TextStyle(
                            color: Colours.text_color_4, fontSize: 12.sp,fontWeight: BFFontWeight.medium,fontFamily: BFFontFamily.din),
                      )),
                ],
              ),
              // SizedBox(
              //   height: 20.h,
              // ),
              // Gaps.hLine,
            ],
          )
          // Stack(
          //   fit: StackFit.expand,
          //   alignment: Alignment.centerLeft,
          //   children: [
          //     Row(
          //       mainAxisSize: MainAxisSize.max,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Expanded(
          //             child: Text(
          //               item.symbolTitle ?? '',
          //               style: TextStyle(
          //                   color: Colours.text_color_2,
          //                   fontSize: 14.sp),
          //             )),
          //         Container(
          //           margin: const EdgeInsets.only(right: 4),
          //           child: CircleAvatar(
          //             backgroundColor: Colours.def_view_bg_1_color,
          //             radius: 7,
          //             child: ClipRRect(
          //                 borderRadius: BorderRadius.circular(7),
          //                 child: CachedNetworkImage(
          //                   width: 14.w,
          //                   height: 14.h,
          //                   imageUrl: item.exchangeIcon ?? '',
          //                   fit: BoxFit.cover,
          //                   placeholder: (context, url) =>
          //                       Image.asset(Assets.imagesAlertDefault),
          //                   errorWidget: (context, url, error) =>
          //                       Image.asset(Assets.imagesAlertDefault),
          //                 )),
          //           ),
          //         ),
          //         Padding(
          //             padding: EdgeInsets.only(right: 14.w),
          //             child: Text(
          //               item.exchangeTitle ?? '',
          //               style: TextStyle(
          //                   color: Colours.text_color_2,
          //                   fontSize: 14.sp,
          //                   fontWeight: FontWeight.normal),
          //             ))
          //       ],
          //     ),
          //
          //   ],
          // ),
          ),
    );
  }
}
