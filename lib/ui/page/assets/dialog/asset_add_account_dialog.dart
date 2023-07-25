import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssetAddAccountDialog extends StatelessWidget {
  const AssetAddAccountDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.white,
      height: 245.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 14.w),
            height: 45.h,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(S.current.action_tip,
                    style: TextStyle(
                        color: Colours.text_color_2,
                        fontSize: 18.sp,
                        fontWeight: BFFontWeight.medium)),
                InkWell(
                  onTap: () {
                    Routers.goBack(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    height: 45.h,
                    alignment: Alignment.center,
                    child: Image(
                        width: 20.w,
                        height: 20.h,
                        image: ImageUtil.getAssetImage(
                            Assets.imagesBaseDialogClose)),
                  ),
                )
              ],
            ),
          ),
          Gaps.hLine,
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.current.asset_account_empty,
                      style: TextStyle(
                          color: Colours.text_color_3, fontSize: 14.sp)),
                  SizedBox(height: 30.h),
                  InkWell(
                    onTap: () {
                      Routers.goBack(context);
                      Routers.navigateTo(
                          context, Routers.accessTraderAccountPage);
                    },
                    child: Container(
                        width: 170.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.h),
                            color: Colours.def_green,
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0xFFA5D5C2),
                                  offset: Offset(0, 1),
                                  blurRadius: 4,
                                  spreadRadius: 0)
                            ]),
                        alignment: Alignment.center,
                        child: Text(
                          S.current.asset_account_add,
                          style: TextStyle(
                              color: Colours.white,
                              fontSize: 16.sp,
                              fontWeight: BFFontWeight.medium),
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
