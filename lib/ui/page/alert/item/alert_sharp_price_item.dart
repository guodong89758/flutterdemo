import 'package:flutter/material.dart';
import 'package:bitfrog/event/alert_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/model/sharp_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/screen_helper.dart';

class AlertSharpPriceItem extends StatefulWidget {
  final int? index;
  final int? count;
  final SharpEntity item;

  const AlertSharpPriceItem(
      {Key? key, this.index, this.count, required this.item})
      : super(key: key);

  @override
  State<AlertSharpPriceItem> createState() => _AlertSharpPriceItemState();
}

class _AlertSharpPriceItemState extends State<AlertSharpPriceItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: ScreenHelper.height(60),
      child: Container(
        color: Colours.white,
        padding: const EdgeInsets.only(left: 15),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.centerLeft,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Text(
                      widget.item.symbolTitle ?? '',
                      style: const TextStyle(
                          color: Colours.text_color_2,
                          fontSize: Dimens.font_sp14,
                          fontFamily: 'Din',
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(right: 14),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        widget.item.symbolSwitch = widget.item.symbolSwitch == 1 ? 0 : 1;
                      });
                      Event.eventBus.fire(AlertSharpSetEvent(widget.item));
                    },
                    child: Image(
                      width: ScreenHelper.width(43),
                      height: ScreenHelper.height(27),
                      image: ImageUtil.getAssetImage(widget.item.symbolSwitch == 1
                          ? Assets.imagesBaseSwitchOn2
                          : Assets.imagesBaseSwitchOff2),
                    ),
                  ),
                )
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
      ),
    );
  }
}
