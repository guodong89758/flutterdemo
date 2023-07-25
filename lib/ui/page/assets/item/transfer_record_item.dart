import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/ui/page/assets/model/transfer_record_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransferRecordItem extends StatelessWidget {
  final TransferRecord item;

  const TransferRecordItem({Key? key, required this.item}) : super(key: key);

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
                  Text(item.currency ?? '',
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Colours.text_color_2,
                          fontWeight: BFFontWeight.medium)),
                  Text("${getAmout()} ${item.currency ?? ""}",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Colours.text_color_2,
                          fontWeight: BFFontWeight.medium)),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(item.desc ?? '',
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Colours.text_color_4,
                          fontWeight: BFFontWeight.normal)),
                  Text(item.created ?? '',
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Colours.text_color_4,
                          fontWeight: BFFontWeight.normal)),
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
    );
  }

  String getAmout() {
    String amount = item.amount ?? '';
    if (amount.isNotEmpty && amount.startsWith('-')) {
      return amount;
    }
    return '+$amount';
  }
}
