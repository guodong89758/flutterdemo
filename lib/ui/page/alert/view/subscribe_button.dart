import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubcribeButton extends StatefulWidget {
  const SubcribeButton(
      {Key? key, required this.isSubscribe})
      : super(key: key);
  final int isSubscribe;

  @override
  State<SubcribeButton> createState() => _SubcribeButtonState();
}

class _SubcribeButtonState extends State<SubcribeButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28.h,
      margin: EdgeInsets.only(right: 14.w),
      constraints: BoxConstraints(minWidth: 65.w),
      padding: EdgeInsets.symmetric(horizontal: 9.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.h),
          color: widget.isSubscribe == 0
              ? Colours.def_green
              : Colours.def_green_10),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
              image: ImageUtil.getAssetImage(widget.isSubscribe == 0
                  ? Assets.imagesSubscribeNo
                  : Assets.imagesSubscribeYes),
              width: 10.w,
              height: 10.h),
          SizedBox(width: 3.w),
          Text(
            widget.isSubscribe == 0
                ? S.current.subscribe
                : S.current.subscribe_text_6,
            style: TextStyle(
                color:
                    widget.isSubscribe == 0 ? Colours.white : Colours.def_green,
                fontSize: 13.sp,
                fontWeight: BFFontWeight.medium),
          ),
        ],
      ),
    );
  }
}
