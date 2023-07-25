import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/event/alert_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/model/alert_index_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertIndexItem extends StatefulWidget {
  final int? index;
  final int? count;
  final AlertIndexEntity item;

  const AlertIndexItem({Key? key, this.index, this.count, required this.item})
      : super(key: key);

  @override
  State<AlertIndexItem> createState() => _AlertIndexItemState();
}

class _AlertIndexItemState extends State<AlertIndexItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenHelper.screenWidth,
      height: ScreenHelper.height(109),
      color: Colours.white,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 14),
      child: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.centerStart,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 6),
                      child: CircleAvatar(
                        backgroundColor: Colours.def_view_bg_1_color,
                        radius: 7,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7.5),
                          child: CachedNetworkImage(
                            width: 15.w,
                            height: 15.h,
                            imageUrl: widget.item.exchange_icon ?? '',
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Image.asset(Assets.imagesAlertDefault),
                            errorWidget: (context, url, error) =>
                                Image.asset(Assets.imagesAlertDefault),
                          ),
                        ),
                      )),
                  Text(
                    widget.item.symbolTitle ?? '',
                    style: const TextStyle(
                        color: Colours.text_color_2,
                        fontFamily: 'Din',
                        fontSize: Dimens.font_sp15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                  margin: const EdgeInsets.only(top: 25),
                  width: ScreenHelper.screenWidth - ScreenHelper.width(14),
                  height: ScreenHelper.height(23),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 21, right: 10),
                        child: Text(
                          S.current.alert_period,
                          style: const TextStyle(
                              color: Colours.text_color_4,
                              fontSize: Dimens.font_sp14,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Expanded(
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: List.generate(
                                widget.item.periods?.length ?? 0,
                                (index) => _buildPeriod(
                                    index,
                                    widget.item.periods?[index] ??
                                        Period())).toList()),
                      ),
                    ],
                  ))
            ],
          ),
          Positioned(
              bottom: 0,
              child: Opacity(
                  // 修改透明度实现隐藏，类似于invisible
                  opacity: widget.index == widget.count! - 1 ? 0.0 : 1.0,
                  child: SizedBox(
                    height: 1,
                    width: ScreenHelper.screenWidth,
                    child: Gaps.hLine,
                  )))
        ],
      ),
    );
  }

  double getTextWidth() {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: S.current.alert_period,
            style: const TextStyle(
                color: Colours.text_color_4,
                fontSize: Dimens.font_sp14,
                fontWeight: FontWeight.normal)),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width;
  }

  Widget _buildPeriod(int position, Period period) {
    return InkWell(
      onTap: () {
        setState(() {
          period.periodSwitch = period.periodSwitch == 1 ? 0 : 1;
        });
        Event.eventBus.fire(AlertIndexEvent(widget.item, period));
      },
      child: Container(
        alignment: Alignment.center,
        width: (ScreenHelper.screenWidth -
                getTextWidth() -
                ScreenHelper.width(138.5)) /
            4,
        height: ScreenHelper.height(23),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: period.periodSwitch == 1
              ? Colours.app_main
              : Colours.def_view_bg_1_color,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          period.title ?? '',
          maxLines: 1,
          style: TextStyle(
            color:
                period.periodSwitch == 1 ? Colours.white : Colours.text_color_3,
            fontSize: Dimens.font_sp13,
          ),
        ),
      ),
    );
  }
}
