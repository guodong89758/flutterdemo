import 'package:flutter/material.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../res/colors.dart';

//loading加载框
class LoadingDialog extends Dialog {
  //loading动画
  final Widget? loadingView;

  //圆角大小
  final double radius;

  //进度颜色
  final Color progressColor;

  //背景颜色
  @override
  final Color backgroundColor;

  const LoadingDialog(
      {Key? key,
      this.loadingView,
      this.radius = 20,
      this.progressColor = Colours.app_main,
      this.backgroundColor = Colours.def_loading_bg_color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Container(
          alignment: Alignment.center,
          child: Container(
            width: ScreenHelper.width(40),
            height: ScreenHelper.height(40),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(radius),
              boxShadow: const [
                BoxShadow(
                    color: Colours.black_5,
                    offset: Offset(1, 1),
                    blurRadius: 7.0,
                    spreadRadius: 1)
              ],
            ),
            child: loadingView ??
                SpinKitRing(color: progressColor, lineWidth: 2, size: 20.0),
          ),
        ));
  }
}
