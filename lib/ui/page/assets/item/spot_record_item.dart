import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/ui/page/assets/model/spot_record_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpotRecordItem extends StatelessWidget {
  final SpotRecord item;

  const SpotRecordItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 75.h,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(item.typeDesc ?? '',
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Colours.text_color_2,
                          fontWeight: BFFontWeight.medium)),
                  Text(getAmountStr(),
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Colours.text_color_2,
                          fontWeight: BFFontWeight.medium)),
                ],
              ),
              SizedBox(height: 8.h),
              Text(item.created ?? '',
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: Colours.text_color_4,
                      fontWeight: BFFontWeight.normal))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 14.w),
          child: Gaps.hLine,
        )
      ],
    );
  }

  String getAmountStr() {
    String amountStr = item.amount ?? '-';
    num? amount = num.tryParse(amountStr);
    if (amount == null) {
      return amountStr;
    }
    if (amount > 0) {
      amountStr = '+$amountStr';
    }
    return '$amountStr ${item.currency ?? ''}';
  }
}
