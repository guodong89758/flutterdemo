import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/ui/page/community/item/currency_image_item.dart';
import 'package:bitfrog/widget/box_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountApiContractItem extends StatefulWidget {
  const AccountApiContractItem({Key? key}) : super(key: key);

  @override
  State<AccountApiContractItem> createState() => _AccountApiContractItemState();
}

class _AccountApiContractItemState extends State<AccountApiContractItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14.w,right: 14.w,top: 10.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CurrencyImageItem(
                imageUrl: "",
                width: 19.w,
              ),
              SizedBox(width: 6.w),
              Text(
                "USDT",
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
            child: Row(
              children: [
                _item("钱包余额","34985493"),
                _item("未实现盈亏","34985493",crossAxisAlignment: CrossAxisAlignment.end)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10.h),
            decoration: BoxDecorations.bottomLine(),
            child: Row(
              children: [
                _item("保证金余额","34985493"),
                _item("可用划转余额","34985493",crossAxisAlignment: CrossAxisAlignment.end)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(String title,String down,{CrossAxisAlignment? crossAxisAlignment}) {
    return Expanded(
        child: Column(
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        Text(title,style: TextStyle(
          color: Colours.text_color_4,
          fontSize: 11.sp
        ),),
        Gaps.getVGap(3),
        Text(down,style: TextStyle(
            color: Colours.text_color_2,
            fontWeight: BFFontWeight.medium,
            fontFamily: BFFontFamily.din,
            fontSize: 13.sp
        ),),
      ],
    ));
  }
}
