import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/ui/page/alert/model/subscribe_item_entity.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertConfigDetailItem extends StatefulWidget {
  final int? index;
  final int? count;
  final SubscribeItemEntity item;
  final ValueChanged<SubscribeItemEntity> onChange;

  const AlertConfigDetailItem(
      {Key? key,
      this.index,
      this.count,
      required this.item,
      required this.onChange})
      : super(key: key);

  @override
  State<AlertConfigDetailItem> createState() => _AlertConfigDetailItemState();
}

class _AlertConfigDetailItemState extends State<AlertConfigDetailItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Container(
        color: Colours.white,
        padding: EdgeInsets.only(left: 14.w),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.centerLeft,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Visibility(
                  visible: (widget.item.icon ?? '').isNotEmpty,
                  child: Container(
                    margin: EdgeInsets.only(right: 8.w),
                    child: CircleAvatar(
                      backgroundColor: Colours.def_view_bg_1_color,
                      radius: 8,
                      backgroundImage: ImageUtil.getImageProvider(
                          widget.item.icon ?? '',
                          holderImg: Assets.imagesAlertDefault),
                    ),
                  ),
                ),
                Expanded(
                    child: Text(
                  widget.item.subscribeTitle ?? '',
                  style: TextStyle(
                      color: Colours.text_color_2,
                      fontSize: 14.sp,
                      fontWeight: BFFontWeight.medium),
                )),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 14.w),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        widget.item.subscribeSwitch =
                            widget.item.subscribeSwitch == 1 ? 0 : 1;
                      });
                      widget.onChange(widget.item);
                    },
                    child: Image(
                      width: 43.w,
                      height: 27.h,
                      image: ImageUtil.getAssetImage(
                          widget.item.subscribeSwitch == 1
                              ? Assets.imagesBaseSwitchOn2
                              : Assets.imagesBaseSwitchOff2),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
                bottom: 0,
                child: Visibility(
                    // 修改透明度实现隐藏，类似于invisible
                    visible: widget.index != widget.count! - 1,
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
