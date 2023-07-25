import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/logic/app_config_manager.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/ui/page/alert/item/alert_timeline_item.dart';
import 'package:bitfrog/ui/page/alert/model/alert_config_share_entiry.dart';
import 'package:bitfrog/ui/page/alert/model/timeline_entiry.dart';
import 'package:bitfrog/ui/page/alert/view/alert_timeline_group_view.dart';
import 'package:bitfrog/ui/view/qr_code_view.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/widget/dash_line.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

///提醒项异动播报分享页
class AlertConfigSharePage extends StatelessWidget {
  const AlertConfigSharePage({Key? key, required this.shareData})
      : super(key: key);
  final AlertConfigShareEntity? shareData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenHelper.screenWidth,
      color: Colours.def_view_bg_3_color,
      child: Stack(
        fit: StackFit.loose,
        children: [
          Image(
              width: ScreenHelper.screenHeight,
              image: ImageUtil.getAssetImage(Assets.imagesShareHeadBg),
              fit: BoxFit.cover),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: ScreenHelper.screenWidth,
                  alignment: Alignment.bottomCenter,
                  child: Image(
                      height: 34.w,
                      image: ImageUtil.getAssetImage(
                          ImageUtil.getImageRes(context).share_alert_title),
                      fit: BoxFit.contain)),
              Container(
                  margin: EdgeInsets.fromLTRB(20.w, 21.h, 20.w, 20.h),
                  decoration: const BoxDecoration(
                    color: Colours.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colours.shadow_8_color,
                          offset: Offset(1, 1.5),
                          blurRadius: 21.0,
                          spreadRadius: 0)
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: ScreenHelper.screenWidth - 40.w,
                        height: 50.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                                height: 23.h,
                                image: ImageUtil.getAssetImage(
                                    ImageUtil.getImageRes(context)
                                        .share_alert_icon),
                                fit: BoxFit.contain),
                            Text(
                                DateUtil.formatDate(DateTime.now(),
                                    format: "MM-dd HH:mm"),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colours.text_color_4,
                                    fontSize: 14.sp))
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        height: ScreenHelper.height(2),
                        alignment: Alignment.centerLeft,
                        child: const DashLine(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20.w, top: 15.h, right: 20.w),
                        child: Text(shareData?.title ?? '',
                            style: TextStyle(
                                color: Colours.text_color_2,
                                fontSize: 15.sp,
                                fontWeight: BFFontWeight.medium)),
                      ),
                      Flexible(
                          fit: FlexFit.loose,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 20.w,
                                  top: 4.h,
                                  right: 20.w,
                                  bottom: 15.h),
                              child: Text(shareData?.tip ?? '',
                                  style: TextStyle(
                                      color: Colours.text_color_3,
                                      fontSize: 14.sp)))),
                      Gaps.spaceView,
                      Container(
                        color: Colours.white,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                            left: 14.w, top: 13.h, right: 14.w, bottom: 13.h),
                        child: Text(S.current.alert_message,
                            style: TextStyle(
                                color: Colours.text_color_2,
                                fontSize: 14.sp,
                                fontWeight: BFFontWeight.medium)),
                      ),
                      ...List.generate(
                            (shareData?.shareList ?? []).length,
                            (index) => AlertShareListPage(
                                  timeline:
                                      (shareData?.shareList ?? [])[index],
                                  isLast: index ==
                                      (shareData?.shareList ?? []).length - 1,
                                )).toList(),
                      SizedBox(height: 8.h),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        height: ScreenHelper.height(2),
                        alignment: Alignment.centerLeft,
                        child: const DashLine(),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        color: Colours.white,
                        width: ScreenHelper.screenWidth,
                        height: 70.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(S.current.alert_text_4,
                                        style: TextStyle(
                                            color: Colours.text_color_2,
                                            fontSize: 15.sp,
                                            fontWeight: BFFontWeight.medium)),
                                    Padding(
                                        padding: EdgeInsets.only(top: 5.h),
                                        child: Text(S.current.alert_text_5,
                                            style: TextStyle(
                                                color: Colours.text_color_4,
                                                fontSize: 11.sp))),
                                  ],
                                )),
                            QrCodeView(size: 45.w,)
                            // QrImageView(
                            //   data: AppConfigManager
                            //       .instance.appConfig?.downloadUrl ??
                            //       '',
                            //   version: QrVersions.auto,
                            //   size: ScreenHelper.width(60),
                            // )
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class AlertShareListPage extends StatelessWidget {
  const AlertShareListPage({
    Key? key,
    required this.timeline,
    required this.isLast,
  }) : super(key: key);
  final TimeLineEntity timeline;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Column(
          children: List.generate(
              (timeline.data ?? []).length,
              (index) => AlertTimelineItem(
                  type: 3,
                  index: index,
                  count: timeline.data?.length,
                  item: (timeline.data ?? [])[index],
                  isLast: isLast)).toList(),
        ),
        TimelineHeader(timestamp: timeline.timestamp ?? 0)
      ],
    );
  }
}
