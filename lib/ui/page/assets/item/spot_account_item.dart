import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/ui/page/assets/model/assets_info_entity.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CapitalAccountItem extends StatefulWidget {
  const CapitalAccountItem({Key? key, required this.item, required this.assetsVisible}) : super(key: key);
  final SpotEntity item;
  final bool assetsVisible;

  @override
  State<CapitalAccountItem> createState() => _CapitalAccountItemState();
}

class _CapitalAccountItemState extends State<CapitalAccountItem> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 14.w),
            CircleAvatar(
              backgroundColor: Colours.def_view_bg_1_color,
              radius: 10,
              backgroundImage: ImageUtil.getImageProvider(widget.item.icon,
                  holderImg: Assets.imagesAlertDefault),
            ),
            SizedBox(width: 6.w),
            Text(
              widget.item.currency ?? '',
              style: TextStyle(
                  color: Colours.text_color_2,
                  fontSize: 15.sp,
                  fontWeight: BFFontWeight.medium,
                  fontFamily: BFFontFamily.din),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.assetsVisible ? StringUtil.formatPrice(widget.item.withdrawAvailable ?? '') : '******',
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colours.text_color_2,
                      fontSize: 15.sp,
                      fontWeight: BFFontWeight.medium,
                      fontFamily: BFFontFamily.din,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 3.h),
                      child: Text(S.current.asset_capital_available,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colours.text_color_4,
                            fontSize: 11.sp,
                          )))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.assetsVisible ? StringUtil.formatPrice(widget.item.frozen ?? '') : '******',
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colours.text_color_2,
                      fontSize: 15.sp,
                      fontWeight: BFFontWeight.medium,
                      fontFamily: BFFontFamily.din,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 3.h),
                      child: Text(S.current.asset_capital_frozen,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colours.text_color_4,
                            fontSize: 11.sp,
                          )))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.assetsVisible ? StringUtil.formatPrice(widget.item.unitAmount ?? '') : '******',
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colours.text_color_2,
                      fontSize: 15.sp,
                      fontWeight: BFFontWeight.medium,
                      fontFamily: BFFontFamily.din,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 3.h),
                      child: Text(
                          '${S.current.asset_capital_convert}(${widget.item.unit})',
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colours.text_color_4,
                            fontSize: 11.sp,
                          )))
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 15.h),
        Padding(
          padding: EdgeInsets.only(left: 14.w),
          child: Gaps.hLine,
        )
      ],
    );
  }
}
