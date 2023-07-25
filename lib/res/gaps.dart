import 'package:flutter/material.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'dimens.dart';

class Gaps {
  static const Widget empty = SizedBox.shrink();

  static const Widget hLine =
      Divider(height: 0.5, thickness: 0.5, color: Colours.def_line_1_color);
  static const Widget hLines =
  Divider(height: 0.5, color: Colours.def_line_4_color);
  static const Widget hLineSmall =
  Divider(height: 0.5, thickness: 1, color: Colours.def_line_4_color);

  static const Widget spaceView =
      Divider(height: 8, thickness: 8, color: Colours.def_view_bg_3_color);

  static const Widget hLine_interval =
      Divider(height: 10, thickness: 10, color: Colours.def_view_bg_3_color);


  /// 水平间隔
  static const Widget hGap4 = SizedBox(width: Dimens.gap_dp4);
  static const Widget hGap5 = SizedBox(width: Dimens.gap_dp5);
  static const Widget hGap8 = SizedBox(width: Dimens.gap_dp8);
  static const Widget hGap10 = SizedBox(width: Dimens.gap_dp10);
  static const Widget hGap12 = SizedBox(width: Dimens.gap_dp12);
  static const Widget hGap20 = SizedBox(width: Dimens.gap_dp20);
  static const Widget hGap15 = SizedBox(width: Dimens.gap_dp15);
   static const Widget hGap14 = SizedBox(width: Dimens.gap_dp14);
  static const Widget hGap16 = SizedBox(width: Dimens.gap_dp16);
  static const Widget hGap32 = SizedBox(width: Dimens.gap_dp32);

  /// 垂直间隔
  static const Widget vGap4 = SizedBox(height: Dimens.gap_dp4);
  static const Widget vGap5 = SizedBox(height: Dimens.gap_dp5);
  static const Widget vGap8 = SizedBox(height: Dimens.gap_dp8);
  static const Widget vGap10 = SizedBox(height: Dimens.gap_dp10);
  static const Widget vGap12 = SizedBox(height: Dimens.gap_dp12);
  static const Widget vGap15 = SizedBox(height: Dimens.gap_dp15);
  static const Widget vGap16 = SizedBox(height: Dimens.gap_dp16);
  static const Widget vGap20 = SizedBox(height: Dimens.gap_dp20);
  static const Widget vGap24 = SizedBox(height: Dimens.gap_dp24);
    static const Widget vGap30 = SizedBox(height: Dimens.gap_dp30);
  static const Widget vGap40 = SizedBox(height: Dimens.gap_dp40);
  static const Widget vGap32 = SizedBox(height: Dimens.gap_dp32);
    static const Widget vGap45 = SizedBox(height: Dimens.gap_dp45);
  static const Widget vGap50 = SizedBox(height: Dimens.gap_dp50);
   static const Widget vGap60 = SizedBox(height: Dimens.gap_dp60);

  static Widget getHGap(double w) {
    return SizedBox(width:ScreenHelper.width(w));
  }

  static Widget getVGap(double h) {
    return SizedBox(height: ScreenHelper.height(h));
  }
}
