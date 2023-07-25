import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/alert/model/alert_event_entity.dart';
import 'package:bitfrog/ui/page/alert/model/trading_view_history_entity.dart';
import 'package:bitfrog/utils/bf_date_util.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TradingViewCellItem extends StatefulWidget {
  final HistoryEvent? item;
  final ValueChanged<AlertEvent>? onSubscribeClick;
  const TradingViewCellItem(
      {Key? key,
        required this.item,
        this.onSubscribeClick})
      : super(key: key);

  @override
  State<TradingViewCellItem> createState() => _TradingViewCellItemItemState();
}

class _TradingViewCellItemItemState extends State<TradingViewCellItem> {
  @override
  Widget build(BuildContext context) {
   
    return  InkWell(

      onTap: () {
        Routers.navigateTo(context, Routers.alertDetailPage,
            parameters: Parameters()..putString('id', widget.item?.id ?? ''));
      },
      child: Container(
        padding: EdgeInsets.only(
          left: 14.w,
          // right: 14.w,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 14.w,
                bottom: 14.w,
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                widget.item?.content ?? '',
                style: TextStyle(
                  color: Colours.text_color_2,
                  fontSize: 14.sp,
                  fontWeight: BFFontWeight.normal,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    BFDateUtil.formatDateStr(widget.item?.timestamp?.toInt() ,format: "yyyy-MM-dd HH:mm"),
                    style: TextStyle(
                      color: Colours.text_color_4,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Visibility(
                    visible: widget.item?.app_push == 1 ? true : false,
                    child: Image(
                        width: 14.w,
                        height: 14.h,
                        image: ImageUtil.getAssetImage(
                            Assets.imagesTradingViewAppq))),
                SizedBox(width: 6.w),
                Visibility(
                    visible: widget.item?.alert_push == 1 ? true : false,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 14.w, right: 14.w, top: 5.h, bottom: 5.h),
                      decoration: BoxDecoration(
                          color: Colours.def_view_bg_5_color,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(3))),
                      alignment: Alignment.center,
                      child: Text(
                        S.current.message_notify_strong,
                        style: TextStyle(
                          color: Colours.text_color_4,
                          fontSize: 11.sp,
                        ),
                      ),
                    )),
                SizedBox(
                  width: 6.w,
                ),
                Visibility( visible: widget.item?.voice_push == 1 ? true : false, child:   Container(
                    padding: EdgeInsets.only(
                        left: 4.w, right: 4.w, top: 5.h, bottom: 5.h),
                    decoration: BoxDecoration(
                        color: widget.item?.voice_status == 2 ? Colours.def_green_8 : Colours.def_yellow_10,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(3))),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Image(
                            width: 11.w,
                            height: 11.h,
                            image: widget.item?.voice_status == 3 ? ImageUtil.getAssetImage(
                                Assets.imagesAlertPhoneGreen) : ImageUtil.getAssetImage(
                                Assets.imagesAlertPhoneYellow)),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          widget.item?.voice_status_desc ?? '',
                          style: TextStyle(
                            color: widget.item?.voice_status == 2 ? Colours.app_main: Colours.def_yellow,
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    )) )
             ,
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Gaps.hLine,
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
