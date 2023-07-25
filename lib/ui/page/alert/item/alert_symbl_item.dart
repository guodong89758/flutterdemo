import 'package:bitfrog/ui/page/community/community_square_index_page.dart';
import 'package:bitfrog/widget/box_decorations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/event/alert_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/model/symbol_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertSymbolItem extends StatelessWidget {
  final int? type;
  final BFSymbol item;
  final HandleClick? handleClick;

  const AlertSymbolItem({
    Key? key,
    this.type,
    required this.item,
    this.handleClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (handleClick != null) {
          handleClick?.call();
          return;
        }
        if (type == 0) {
          Routers.goBack(context);
          Parameters params = Parameters()..putObj('symbol', item);
          Routers.navigateTo(context, Routers.alertAddPricePage,
              parameters: params, transition: TransitionType.inFromBottom);
        } else if (type == 1) {
          Routers.goBack(context);
          Event.eventBus.fire(AlertSymbolEvent(item));
        }
      },
      child: Container(
        width: double.infinity,
        height: 60.h,
        margin: EdgeInsets.only(left: 14.w),
        padding: EdgeInsets.only(right: 14.w),
        decoration: BoxDecorations.bottomLine(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                item.symbolTitle ?? '',
                style: TextStyle(color: Colours.text_color_2, fontSize: 14.sp),
              ),
            ),
            CircleAvatar(
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
            SizedBox(width: 5.w),
            Text(
              item.exchangeTitle ?? '',
              style: TextStyle(
                  color: Colours.text_color_2,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
