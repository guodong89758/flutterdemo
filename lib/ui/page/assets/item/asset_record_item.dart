import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/assets/model/asset_record_entity.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssetRecordItem extends StatelessWidget {
  final int? type;
  final RecordEntity item;

  const AssetRecordItem(
      {Key? key, this.type, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Parameters parameters = Parameters()
          ..putInt("type", type ?? 1)
          ..putObj("record", item);
        Routers.navigateTo(context, Routers.assetsRecordDetail,
            parameters: parameters);
      },
      child: Column(
        children: [
          Container(
            height: 75.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(item.currency ?? '',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colours.text_color_2,
                            fontWeight: BFFontWeight.medium,
                            fontFamily: BFFontFamily.din)),
                    SizedBox(width: 6.w),
                    Text(item.chain ?? '',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Colours.text_color_4,
                            fontWeight: BFFontWeight.medium)),
                    Expanded(child: Container()),
                    Text(StringUtil.formatPrice(item.amount ?? ''),
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colours.text_color_2,
                            fontWeight: BFFontWeight.medium)),
                    SizedBox(width: 5.w),
                    Image(
                      width: 10.w,
                      height: 10.h,
                      image:
                          ImageUtil.getAssetImage(Assets.imagesBaseArrowRight),
                    )
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(item.created ?? '',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Colours.text_color_4,
                            fontWeight: BFFontWeight.normal)),
                    Padding(
                      padding: EdgeInsets.only(right: 15.w),
                      child: Text(item.stateDesc ?? '',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: getStateColor(),
                              fontWeight: BFFontWeight.normal)),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 14.w),
            child: Gaps.hLine,
          )
        ],
      ),
    );
  }

  Color getStateColor() {
    if (type == 1) {
      //充值 (1待确认 2 成功 3异常)
      switch (item.state) {
        case 1:
          return Colours.def_yellow;
        case 2:
          return Colours.text_color_4;
        case 3:
          return Colours.def_red;
      }
    } else if (type == 2) {
      //提币 (1 待审核 2 审核通过 3 审核拒绝 4 支付中 5 支付失败 6 已完成 7 已撤销)
      switch (item.state) {
        case 1:
        case 4:
          return Colours.def_yellow;
        case 2:
          return Colours.def_green;
        case 3:
        case 5:
          return Colours.def_red;
      }
    }
    return Colours.text_color_4;
  }
}
