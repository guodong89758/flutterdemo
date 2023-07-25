import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/alert/model/alert_type_entity.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertListItem extends StatefulWidget {
  const AlertListItem(
      {Key? key,
      required this.position,
      required this.item,
      required this.onSubscribeClick})
      : super(key: key);
  final int position;
  final AlertTypeEntity item;
  final ValueChanged<AlertTypeEntity>? onSubscribeClick;

  @override
  State<AlertListItem> createState() => _AlertListItemState();
}

class _AlertListItemState extends State<AlertListItem> {
  late double itemWidth;
  late double itemHeight;

  @override
  void initState() {
    super.initState();
    itemWidth = (ScreenHelper.screenWidth - 38.w) / 2;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: itemClick,
      child: Container(
        width: itemWidth,
        decoration: BoxDecoration(
          color: Colours.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
                color: Colours.shadow_8_color,
                offset: Offset(1, 1),
                blurRadius: 7.0,
                spreadRadius: 1)
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.centerLeft,
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.item.title ?? '',
                        maxLines: 1,
                        style: TextStyle(
                            color: Colours.text_color_2, fontSize: 14.sp)),
                    SizedBox(height: 6.h),
                    Expanded(
                      child: Text(widget.item.desc ?? '',
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colours.text_color_4, fontSize: 11.sp)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Gaps.empty,
                        InkWell(
                          onTap: () {
                            if (widget.item.isSubscribeDirectly == 0) {
                              //不可直接订阅
                              itemClick();
                              return;
                            }
                            if (widget.onSubscribeClick == null) {
                              return;
                            }
                            widget.onSubscribeClick!(widget.item);
                          },
                          child: Container(
                              height: 20.h,
                              constraints: BoxConstraints(minWidth: 45.w),
                              padding: EdgeInsets.symmetric(horizontal: 6.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.5.h),
                                  color: (widget.item.setCnt ?? 0) <= 0
                                      ? Colours.def_green
                                      : Colours.def_green_10),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Visibility(
                                    visible: (widget.item.setCnt ?? 0) <= 0,
                                    child: Image(
                                        image: ImageUtil.getAssetImage(
                                            Assets.imagesSubscribeNo),
                                        width: 8.w,
                                        height: 8.h),
                                  ),
                                  Visibility(
                                      visible: (widget.item.setCnt ?? 0) <= 0,
                                      child: SizedBox(width: 3.w)),
                                  Text(
                                    (widget.item.setCnt ?? 0) <= 0
                                        ? S.current.subscribe
                                        : S.current.subscribe_text_6,
                                    style: TextStyle(
                                        color: (widget.item.setCnt ?? 0) <= 0
                                            ? Colours.white
                                            : Colours.def_green,
                                        fontSize: 11.sp,
                                        fontWeight: BFFontWeight.medium),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    )
                  ]),
            ),
            Positioned(
                top: 0,
                right: 0,
                child: Visibility(
                    visible: widget.item.isRecommend == 1,
                    child: Image(
                      image: ImageUtil.getAssetImage(Assets.imagesAlertHot),
                      width: 31.w,
                      height: 31.h,
                    )))
          ],
        ),
      ),
    );
  }

  void itemClick() {

    if (Routers.goLogin(context)) return;

    if (widget.item.type == 'px_trigger') {
      Routers.navigateTo(context, Routers.alertPricePage);
    } else if (widget.item.type == 'px_indicator_signal') {
      Routers.navigateTo(context, Routers.alertSignalPage);
    } else {
      Parameters parameters = Parameters();
      parameters.putString("type", widget.item.type ?? '');
      Routers.navigateTo(context, Routers.alertConfigDetailPage,
          parameters: parameters);
    }
  }
}
