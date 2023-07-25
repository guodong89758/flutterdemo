import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/alert/alert_detail_page.dart';
import 'package:bitfrog/ui/page/alert/model/alert_signal_new_entity.dart';
import 'package:bitfrog/ui/page/community/community_square_index_page.dart';
import 'package:bitfrog/ui/page/mine/item/Line_view_item.dart';
import 'package:bitfrog/utils/bf_date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertSignalNewsItem extends StatelessWidget {
  const AlertSignalNewsItem({Key? key,this.handleClick,this.alertSignalNewEntity}) : super(key: key);
  final HandleClick? handleClick;
  final AlertSignalNewEntity? alertSignalNewEntity;

  @override
  Widget build(BuildContext context) {

      return InkWell(
          onTap: (){
        // AlertShowTypes? types = params?.getObj("types");
        Parameters params = Parameters();
        params.putString('id', alertSignalNewEntity?.id.toString() ?? '' );

        // params.getObj('types', AlertShowTypes.noticeDetail );
        params.putObj(
            "types", AlertShowTypes.historyDetail);
        Routers.navigateTo(context, Routers.alertDetailPage,
            parameters:params );
      },
    child: Column(
      children: [
        Container(
          color: Colours.white,
          padding: EdgeInsets.only(left: 15.w,right: 15.w,top: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(alertSignalNewEntity?.content ?? "",style: TextStyle(
                  color: Colours.text_color_2,
                  fontSize: 14.sp,
                  fontWeight: BFFontWeight.medium
              ),),
              Gaps.vGap12,
              Row(
                children: [
                  Text(BFDateUtil.formatDateStr((alertSignalNewEntity?.timestamp ?? 0).toInt()),style: TextStyle(
                    color: Colours.text_color_4,
                    fontSize: 12.sp,
                  ),),
                  if((alertSignalNewEntity?.appPush ?? 0) == 1) Row(
                    children: [
                      Gaps.getHGap(6),
                      Image.asset(Assets.imagesAlertApp,width: 15.w,height: 15.w,),
                    ],
                  ),
                  if((alertSignalNewEntity?.voicePush ?? 0) == 1) Row(
                    children: [
                      Gaps.getHGap(6),
                      Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                            color: (alertSignalNewEntity?.voiceStatus ?? 0) == 2 ?
                            Colours.def_green.withOpacity(0.1) :
                            Colours.def_yellow.withOpacity(0.1)
                        ),
                        child: Row(
                          children: [
                            (alertSignalNewEntity?.voiceStatus ?? 0) == 2 ?
                            Image.asset(Assets.imagesAlertPhoneGreen,width: 12.w,height: 12.w,)
                                : Image.asset(Assets.imagesAlertPhoneYellow,width: 12.w,height: 12.w,)
                            ,
                            Gaps.hGap5,
                            Text(alertSignalNewEntity?.voiceStatusDesc ?? "",style: TextStyle(
                                color: Colours.def_yellow,
                                fontSize: 11.sp
                            ),)
                          ],
                        ),
                      )
                    ],
                  )

                ],
              ),
              Gaps.vGap12,
              const LineViewItem(heightAll: 1,)
            ],
          ),
        )
      ],
    )
      );
  }
}
