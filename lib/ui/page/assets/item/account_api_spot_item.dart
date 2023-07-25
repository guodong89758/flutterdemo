import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/ui/page/assets/model/api_spot_entity.dart';
import 'package:bitfrog/ui/page/community/item/currency_image_item.dart';
import 'package:bitfrog/widget/box_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountApiSpotItem extends StatelessWidget {
  final Assets assets;

  const AccountApiSpotItem({Key? key, required this.assets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final coin = assets.coin;

    return Container(
      padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 10.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CurrencyImageItem(imageUrl: assets.icon ?? '', width: 19.w),
              SizedBox(width: 6.w),
              Text(
                assets.currency ?? '',
                style: TextStyle(
                    color: Colours.text_color_2,
                    fontSize: 15.sp,
                    fontWeight: BFFontWeight.medium,
                    fontFamily: BFFontFamily.din),
              ),
            ],
          ),
          Gaps.vGap10,
          Container(
            padding: EdgeInsets.only(bottom: 10.h),
            decoration: BoxDecorations.bottomLine(),
            child: Row(
              children: [
                _item(
                  "合计",
                  assets.balance?.amount,
                  "≈ $coin${assets.balance?.worth}",
                ),
                _item(
                  "可用",
                  assets.withdrawAvailable?.amount,
                  "≈ $coin${assets.withdrawAvailable?.worth}",
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                _item(
                  "冻结",
                  assets.frozen?.amount,
                  "≈ $coin${assets.frozen?.worth}",
                  crossAxisAlignment: CrossAxisAlignment.end,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(String? title, String? center, String? down,
      {CrossAxisAlignment? crossAxisAlignment}) {
    return Expanded(
        child: Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style: TextStyle(color: Colours.text_color_4, fontSize: 11.sp),
        ),
        Gaps.getVGap(3),
        Text(
          center ?? '',
          style: TextStyle(
              color: Colours.text_color_2,
              fontWeight: BFFontWeight.medium,
              fontFamily: BFFontFamily.din,
              fontSize: 13.sp),
        ),
        Gaps.getVGap(2),
        Text(
          down ?? '',
          style: TextStyle(
              color: Colours.text_color_4,
              fontWeight: BFFontWeight.medium,
              fontFamily: BFFontFamily.din,
              fontSize: 11.sp),
        )
      ],
    ));
  }
}
