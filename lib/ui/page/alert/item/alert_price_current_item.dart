import 'package:bitfrog/widget/box_decorations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/model/alert_price_entity.dart';
import 'package:bitfrog/model/symbol_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/alert/item/alert_price_item.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertPriceCurrentItem extends StatelessWidget {
  final AlertPriceEntity item;
  final bool showBottomMargin;
  final ValueChanged<int?> onDelete;

  const AlertPriceCurrentItem({
    Key? key,
    required this.item,
    this.showBottomMargin = true,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemChildren = item.items ?? List.empty();

    return Container(
      decoration: BoxDecorations.cardBoxDecoration(radius: 4.r),
      margin: EdgeInsets.only(bottom: showBottomMargin ? 10.h : 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 15),
            height: ScreenHelper.height(45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 6),
                  child: CircleAvatar(
                    backgroundColor: Colours.def_view_bg_1_color,
                    radius: 7,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: CachedNetworkImage(
                          width: 14.w,
                          height: 14.h,
                          imageUrl: item.exchangeIcon ?? '',
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Image.asset(Assets.imagesAlertDefault),
                          errorWidget: (context, url, error) =>
                              Image.asset(Assets.imagesAlertDefault),
                        )),
                  ),
                ),
                Expanded(
                    child: Text(
                  '${item.exchangeTitle ?? ''} ${item.symbolTitle ?? ''}',
                  style: const TextStyle(
                      color: Colours.text_color_1,
                      fontFamily: 'Din',
                      fontSize: Dimens.font_sp14,
                      fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: ScreenHelper.height(45),
                  child: IconButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 13.5, horizontal: 15),
                    icon: Image.asset(Assets.imagesAlertPriceAddSmall),
                    onPressed: () {
                      BFSymbol symbol = BFSymbol(
                          id: item.id,
                          symbolKey: item.symbolKey,
                          symbolTitle: item.symbolTitle,
                          exchangeIcon: item.exchangeIcon,
                          exchangeTitle: item.exchangeTitle);
                      Parameters params = Parameters()
                        ..putObj('symbol', symbol);
                      Routers.navigateTo(context, Routers.alertAddPricePage,
                          parameters: params,
                          transition: TransitionType.inFromBottom);
                      // ToastUtil.show('添加价格预警');
                    },
                    iconSize: ScreenHelper.width(18),
                  ),
                )
              ],
            ),
          ),
          Gaps.hLine,
          ...List.generate(
            itemChildren.length,
            (index) => AlertPriceItem(
              showBottomLine: index + 1 != itemChildren.length,
              item: itemChildren[index],
              onDelete: onDelete,
            ),
          ).toList(),
        ],
      ),
    );
  }
}
