import 'dart:async';

import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeLineClockView extends StatefulWidget {
  const TimeLineClockView({Key? key}) : super(key: key);

  @override
  State<TimeLineClockView> createState() => _TimeLineClockViewState();
}

class _TimeLineClockViewState extends State<TimeLineClockView> {
  StreamSubscription? clockSubscription;
  String time = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        refreshTime();
        clockSubscription?.cancel();
        clockSubscription =
            Stream.periodic(const Duration(seconds: 1), (count) {})
                .listen((event) {
          refreshTime();
        });
      }
    });
  }

  void refreshTime() {
    setState(() {
      time = DateUtil.formatDate(DateTime.now(), format: "HH:mm:ss");
    });
  }

  @override
  void dispose() {
    super.dispose();
    clockSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 21.h,
      width: 77.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.5.h),
              bottomLeft: Radius.circular(10.5.h)),
          color: Colours.alert_colock_bg_color),
      alignment: Alignment.center,
      child: Text(
        time,
        style: TextStyle(
            color: Colours.def_blue,
            fontSize: 12.sp,
            fontFamily: BFFontFamily.din,
            fontWeight: BFFontWeight.medium),
      ),
    );
  }
}
