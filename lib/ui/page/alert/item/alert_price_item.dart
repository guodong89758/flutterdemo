import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/utils/string_util.dart';
import 'package:bitfrog/widget/dividers.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/model/alert_price_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertPriceItem extends StatelessWidget {
  final PriceItem item;
  final bool showBottomLine;
  final ValueChanged<int?> onDelete;

  const AlertPriceItem({
    super.key,
    required this.item,
    required this.showBottomLine,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 15, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          item.isRise
                              ? S.current.alert_price_rise
                              : S.current.alert_price_fall,
                          style: TextStyle(
                              color: Colours.text_color_2,
                              fontSize: 14.sp,
                              height: 1.0)),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          StringUtil.formatPrice(item.price ?? ''),
                          style: TextStyle(
                            color: item.isRise
                                ? Colours.def_green
                                : Colours.def_red,
                            fontSize: 14.sp,
                            fontWeight: BFFontWeight.medium,
                            fontFamily: BFFontFamily.din,
                            height: 1.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(right: 5),
                    width: ScreenHelper.width(35),
                    height: ScreenHelper.height(35),
                    child: IconButton(
                      padding: const EdgeInsets.all(10),
                      icon: Image.asset(Assets.imagesAlertPriceRemove),
                      onPressed: () => onDelete.call(item.id),
                      iconSize: ScreenHelper.width(15),
                    ))
              ],
            )),
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                  // 默认为占位替换，类似于gone
                  visible: item.app_push == 1,
                  child: Container(
                    height: ScreenHelper.height(15),
                    width: ScreenHelper.width(15),
                    margin: const EdgeInsets.only(right: 6),
                    child: Image.asset(Assets.imagesAlertApp),
                  )),
              Visibility(
                  // 默认为占位替换，类似于gone
                  visible: item.voice_push == 1,
                  child: Container(
                    height: ScreenHelper.height(15),
                    width: ScreenHelper.width(15),
                    margin: const EdgeInsets.only(right: 6),
                    child: Image.asset(Assets.imagesAlertPhoneGray),
                  )),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenHelper.height(1.5),
                    horizontal: ScreenHelper.height(5.5)),
                decoration: BoxDecoration(
                  color: Colours.def_view_bg_1_color,
                  borderRadius: BorderRadius.circular(1.5),
                ),
                child: Text(
                    item.isRepeat == 1
                        ? S.current.alert_repeat
                        : S.current.alert_once,
                    style: const TextStyle(
                        color: Colours.text_color_3,
                        fontSize: Dimens.font_sp11)),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(right: 15),
                  child: Text(
                      '${item.expireDate ?? ''} ${S.current.alert_expire}',
                      style: const TextStyle(
                          color: Colours.text_color_4,
                          fontSize: Dimens.font_sp12)),
                ),
              )
            ],
          ),
        ),
        Visibility(
          visible: showBottomLine,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: HDivider(),
          ),
        ),
      ],
    );
  }
}
