import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/model/alert_phone_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertPhoneItem extends StatefulWidget {
  final int? index;
  final int? count;
  final PhoneType? item;
  final ValueChanged<PhoneItem> onChange;
  final bool useDing;

  const AlertPhoneItem(
      {Key? key,
      this.index,
      this.count,
        this.useDing = true,
      required this.item,
      required this.onChange})
      : super(key: key);

  @override
  State<AlertPhoneItem> createState() => _AlertPhoneItemState();
}

class _AlertPhoneItemState extends State<AlertPhoneItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: IntrinsicHeight(
            child: Card(
          color: Colours.white,
          shadowColor: Colours.shadow_color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          elevation: ScreenHelper.height(7),
          margin: EdgeInsets.fromLTRB(
              14.w, 10.h, 14.w, widget.index == widget.count! - 1 ? 15.h : 5.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: ScreenHelper.screenWidth - ScreenHelper.width(28),
                padding: EdgeInsets.only(left: 10.w, right: 15.w),
                height: 40.h,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 6.w),
                      child: CachedNetworkImage(
                        imageUrl: widget.item?.icon ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Image.asset(Assets.imagesAlertDefault),
                        errorWidget: (context, url, error) =>
                            Image.asset(Assets.imagesAlertDefault),
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                    Text(
                      widget.item?.title ?? '',
                      style: TextStyle(
                          color: Colours.text_color_2,
                          fontFamily: widget.useDing ? BFFontFamily.din : null,
                          fontSize: 15.sp,
                          fontWeight: BFFontWeight.medium),
                    ),
                    Expanded(
                        child: Text(
                      widget.item?.desc ?? '',
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colours.text_color_4, fontSize: 12.sp),
                    )),
                  ],
                ),
              ),
              Visibility(
                  visible: (widget.item?.items ?? []).isNotEmpty,
                  child: Gaps.hLine),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      widget.item?.items?.length ?? 0,
                      (index) => _buildAlertItem(
                          context,
                          index,
                          widget.item?.items?.length ?? 0,
                          widget.item?.items?[index],
                          widget.item)).toList()),
            ],
          ),
        )));
  }

  Widget _buildAlertItem(BuildContext context, int index, int count,
      PhoneItem? item, PhoneType? type) {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.only(
                  top: type?.type == 'px_trigger' || type?.type == 'px_indicator_signal'
                      ? 5.h
                      : 11.h,
                  bottom: type?.type == 'px_trigger' || type?.type == 'px_indicator_signal'
                      ? 0
                      : 11.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    item?.title ?? '',
                    style: TextStyle(
                        color: Colours.text_color_2,
                        fontFamily: widget.useDing ? BFFontFamily.din : null,
                        fontSize: 14.sp),
                  )),
                  Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: ScreenHelper.width(38),
                      height: ScreenHelper.height(38),
                      child: IconButton(
                        padding: const EdgeInsets.all(10),
                        icon: Image.asset(item?.phoneSwitch == 1
                            ? Assets.imagesBaseCheckYes
                            : Assets.imagesBaseCheckNo),
                        onPressed: () {
                          // setState(() {
                          item?.phoneSwitch = item.phoneSwitch == 1 ? 0 : 1;
                          // });
                          widget.onChange(item ?? PhoneItem());
                          // Event.eventBus.fire(AlertPhoneEvent(item));
                        },
                        iconSize: ScreenHelper.width(18),
                      ))
                ],
              )),
          Visibility(
              // 默认为占位替换，类似于gone
              visible: type?.type == 'px_trigger' || type?.type == 'px_indicator_signal',
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: type?.type == 'px_trigger',
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: ScreenHelper.height(1.5),
                                horizontal: ScreenHelper.height(5.5)),
                            decoration: BoxDecoration(
                              color: Colours.def_view_bg_1_color,
                              borderRadius: BorderRadius.circular(1.5),
                            ),
                            margin: EdgeInsets.only(right: 6.w),
                            child: Text(
                                item?.isRepeat == 1
                                    ? S.current.alert_repeat
                                    : S.current.alert_once,
                                style: const TextStyle(
                                    color: Colours.text_color_3,
                                    fontSize: Dimens.font_sp11)),
                          ),
                        ),
                        Expanded(
                          child: Text(item?.content ?? '',
                              style: TextStyle(
                                  color: Colours.text_color_4,
                                  fontSize: 12.sp)),
                        )
                      ]))),
          Visibility(
              visible: index != count - 1 && count != 0,
              child: SizedBox(
                height: 1,
                width: ScreenHelper.screenWidth,
                child: Gaps.hLine,
              ))
        ],
      ),
    );
  }
}
