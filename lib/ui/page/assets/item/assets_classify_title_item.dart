import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/widget/box_decorations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssetsClassifyTitleItem extends StatelessWidget {
  const AssetsClassifyTitleItem({Key? key,this.title}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenHelper.screenWidth,
      padding: EdgeInsets.only(left: 14.w,right: 14.w),
      decoration: BoxDecorations.bottomLine(),
      alignment: Alignment.centerLeft,
      child:
      Container(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Gaps.getVGap(10),
            Text(title ?? "",style: TextStyle(
              color: Colours.text_color_2,
              fontWeight: BFFontWeight.medium,
              fontSize: 15.sp
            ),),
            Gaps.getVGap(8),
            Container(
              color: Colours.app_main,
              width: 20.w,
              height: 2.h,
            )
          ],
        ),
      ),
    );
  }
}
