import 'package:flutter/material.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final Color? titleColor;
  final Color? backIconColor;
  final Widget? action;
  final Color? backgroundColor;
  final bool? bottomLine;
  final VoidCallback? onBack;
  final EdgeInsetsGeometry? titleWidgetMargin;

  const MyAppBar({
    Key? key,
    this.title,
    this.titleWidget,
    this.titleColor,
    this.backIconColor,
    this.action,
    this.backgroundColor,
    this.bottomLine = false,
    this.titleWidgetMargin,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget titleWidget = Semantics(
      namesRoute: true,
      header: true,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        margin: titleWidgetMargin ?? const EdgeInsets.symmetric(horizontal: 44.0),
        child: this.titleWidget ??
            Text(
              title ?? '',
              style: TextStyle(
                fontSize: 18.sp,
                color: titleColor ?? Colours.text_color_1,
              ),
            ),
      ),
    );

    final Widget backWidget = IconButton(
      iconSize: ScreenHelper.width(20),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 11.w),
      onPressed: onBack ??
          () {
            // if (Navigator.canPop(context)) {
            Routers.goBack(context);
            // } else {
            //   SystemNavigator.pop();
            // }
          },
      icon: Image.asset(Assets.imagesBaseBack, color: backIconColor),
    );

    // 为了扩大点击范围 方便点击， action 间距外部自己处理
    final actionWidget = Positioned(
      right: 0,
      child: action ?? const SizedBox(),
    );

    return Material(
      color: backgroundColor ?? Colours.white,
      child: SafeArea(
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            titleWidget,
            backWidget,
            actionWidget,
            Positioned(
                bottom: 0,
                child: Visibility(
                    visible: bottomLine ?? false,
                    child: SizedBox(
                        width: ScreenHelper.screenWidth, child: const Divider(height: 1, thickness: 1, color: Colours.def_line_title_color))))
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(ScreenHelper.height(Dimens.def_title_height));
}
