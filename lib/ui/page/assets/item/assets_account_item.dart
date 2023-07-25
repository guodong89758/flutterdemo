import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/ui/page/community/community_square_index_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssetsAccountItem extends StatelessWidget {
  const AssetsAccountItem(
      {Key? key,
      this.icon,
      this.title = "",
      this.unit = "",
      this.count = "",
      this.assetsVisible = true,
        this.padding,
      this.handleClick})
      : super(key: key);
  final Widget? icon;
  final String title;
  final String unit;
  final String count;
  final bool assetsVisible;
  final HandleClick? handleClick;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        handleClick?.call();
      },
      child: Container(
        color: Colours.white,
        padding: padding ?? EdgeInsets.only(top: 10.h, bottom: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon ?? Container(),
                Gaps.hGap8,
                Text(
                  title,
                  style:
                      TextStyle(color: Colours.text_color_2, fontSize: 14.sp),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  assetsVisible ? count : '******',
                  style: TextStyle(
                      color: Colours.text_color_2,
                      fontSize: 14.sp,
                      fontWeight: BFFontWeight.medium,
                      fontFamily: BFFontFamily.din),
                ),
                Gaps.hGap4,
                Text(
                  unit,
                  style: TextStyle(
                      color: Colours.text_color_2,
                      fontSize: 14.sp,
                      fontWeight: BFFontWeight.medium,
                      fontFamily: BFFontFamily.din),
                ),
                Gaps.hGap4,
                Image.asset(
                  Assets.imagesBaseArrowRight,
                  width: 8.w,
                  height: 8.w,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
