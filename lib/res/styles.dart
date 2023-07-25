import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimens.dart';

class TextStyles {
  static const TextStyle titleStyle = TextStyle(
      fontSize: Dimens.font_sp18,
      fontWeight: FontWeight.bold,
      color: Colours.white,
      height: 1.0);
}

class BorderStyles {
  static const OutlineInputBorder outlineInputR50Main = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(50.0)),
      borderSide: BorderSide(color: Colours.app_main));

  static const OutlineInputBorder outlineInputR0White = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0.0)),
      borderSide: BorderSide(color: Colours.white));

  static const UnderlineInputBorder underlineInputMain =
      UnderlineInputBorder(borderSide: BorderSide(color: Colours.app_main));
}

class BoxShadows {
  static const List<BoxShadow> normalBoxShadow = [
    BoxShadow(
      color: Colours.black_10,
      offset: Offset(0.0, 1.0),
      blurRadius: 10.0,
      spreadRadius: 0.0,
    ),
  ];
}

class BFFontWeight{
  static const normal = FontWeight.w400; ///普通体
  static const medium = FontWeight.w600; ///中黑体
  static const bold = FontWeight.bold;   /// 粗体
}

class BFFontFamily{
  static const din = "Din"; ///Din字体

}
