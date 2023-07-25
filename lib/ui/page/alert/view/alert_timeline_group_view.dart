import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/ui/page/alert/item/alert_timeline_item.dart';
import 'package:bitfrog/ui/page/alert/model/alert_event_entity.dart';
import 'package:bitfrog/ui/page/alert/model/timeline_entiry.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class AlertTimelineGroupView extends StatefulWidget {
  const AlertTimelineGroupView(
      {Key? key,
      required this.type,
      required this.timeline,
      required this.isLast,
      this.onSubscribeClick})
      : super(key: key);
  final int type; //1、订阅 2、详情
  final TimeLineEntity timeline;
  final bool isLast;
  final ValueChanged<AlertEvent>? onSubscribeClick;

  @override
  State<AlertTimelineGroupView> createState() => _AlertTimelineGroupViewState();
}

class _AlertTimelineGroupViewState extends State<AlertTimelineGroupView> {
  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      overlapsContent: true,
      header: TimelineHeader(timestamp: widget.timeline.timestamp ?? 0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          AlertEvent? item = widget.timeline.data?[index];
          return AlertTimelineItem(
            type: widget.type,
            index: index,
            count: widget.timeline.data?.length,
            item: item,
            isLast: widget.isLast,
            onSubscribeClick: widget.onSubscribeClick,
          );
        }, childCount: widget.timeline.data?.length),
      ),
    );
  }
}

class TimelineHeader extends StatelessWidget {
  const TimelineHeader({Key? key, required this.timestamp}) : super(key: key);
  final num timestamp;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Container(
          width: 28.w,
          height: 34.h,
          margin: EdgeInsets.only(left: 14.w, top: 5.h),
          decoration: BoxDecoration(
            color: Colours.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
              BoxShadow(
                  color: Colours.shadow_16_color,
                  offset: Offset(1, 1),
                  blurRadius: 7.0,
                  spreadRadius: 1)
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 28.w,
                height: 15.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colours.alert_month_bg_color,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.h),
                        topRight: Radius.circular(4.h))),
                child: Text(
                    '${DateUtil.formatDateMs((timestamp * 1000).toInt(), format: 'MM')}${S.current.base_month}',
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colours.white,
                        fontSize: 9.sp,
                        fontFamily: BFFontFamily.din,
                        fontWeight: BFFontWeight.medium)),
              ),
              Container(
                width: 28.w,
                height: 19.h,
                alignment: Alignment.center,
                child: Text(
                    DateUtil.formatDateMs((timestamp * 1000).toInt(),
                        format: 'dd'),
                    style: TextStyle(
                        color: Colours.text_color_2,
                        fontSize: 14.sp,
                        fontFamily: BFFontFamily.din,
                        fontWeight: BFFontWeight.medium)),
              )
            ],
          )),
    );
  }
}
