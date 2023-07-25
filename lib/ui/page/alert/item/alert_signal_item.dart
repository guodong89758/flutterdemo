import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/ui/page/alert/model/alert_signal_entity.dart';
import 'package:bitfrog/ui/page/community/community_square_index_page.dart';
import 'package:bitfrog/widget/box_decorations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertSignalItem extends StatelessWidget {
  const AlertSignalItem({
    Key? key,
    this.alertSignalEntity,
    this.handleClickDelete,
    required this.showBottomSpace,
  }) : super(key: key);

  final HandleClick? handleClickDelete;
  final AlertSignalEntity? alertSignalEntity;
  final bool showBottomSpace;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: showBottomSpace ? 10.h : 0),
      decoration: BoxDecorations.cardBoxDecoration(radius: 4.r),
      padding: EdgeInsets.only(left: 15.w, bottom: 13.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                alertSignalEntity?.title ?? "",
                style: TextStyle(
                    color: Colours.text_color_2,
                    fontSize: 14.sp,
                    fontWeight: BFFontWeight.medium),
              ),
              GestureDetector(
                onTap: () {
                  handleClickDelete?.call();
                },
                child: Container(
                  padding:
                      EdgeInsets.only(right: 15.w, top: 12.h, bottom: 10.h),
                  child: Image.asset(
                    Assets.imagesAlertSignalDelete,
                    width: 15.w,
                    height: 15.w,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Visibility(
                visible: (alertSignalEntity?.appPush ?? 0) == 1,
                child: Row(
                  children: [
                    Image.asset(
                      Assets.imagesAlertApp,
                      width: 15.w,
                      height: 15.w,
                    ),
                    Gaps.getHGap(6),
                  ],
                ),
              ),
              Visibility(
                visible: (alertSignalEntity?.voicePush ?? 0) == 1,
                child: Row(
                  children: [
                    Image.asset(
                      Assets.imagesAlertPhoneGray,
                      width: 15.w,
                      height: 15.w,
                    ),
                    Gaps.hGap10,
                  ],
                ),
              ),
              Text(
                alertSignalEntity?.content ?? "",
                style: TextStyle(
                  color: Colours.text_color_4,
                  fontSize: 12.sp,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
