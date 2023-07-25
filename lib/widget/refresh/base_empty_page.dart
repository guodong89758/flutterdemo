import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/l10n.dart';

class BaseEmptyPage extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final String? image;
  final VoidCallback? onEmptyClick;
  final double? imageWidth;
  final double? imageHeight;
  final double? width;
  final double? height;
  final bool darkTheme;
  final double? imageTextSpace;

  const BaseEmptyPage({
    Key? key,
    this.text,
    this.textColor,
    this.image,
    this.onEmptyClick,
    this.imageWidth,
    this.imageHeight,
    this.imageTextSpace,
    this.width,
    this.height,
    this.darkTheme = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Expanded(
            flex: 2,
            child: SizedBox(),
          ),
          InkWell(
            onTap: onEmptyClick,
            child: SizedBox(
              width: imageWidth ?? 70.0,
              height: imageHeight ?? 70.0,
              child: Image.asset(
                fit: BoxFit.cover,
                image ??
                    (darkTheme
                        ? Assets.imagesBaseEmptyDark
                        : Assets.imagesBaseEmpty),
              ),
            ),
          ),
          SizedBox(height: imageTextSpace ?? 15.h),
          Text(
            text ?? S.of(context).def_empty,
            style: TextStyle(
              color: textColor ??
                  (darkTheme ? Colours.text_color_3 : Colours.text_color_4),
              fontSize: 13.sp,
            ),
          ),
          const Expanded(
            flex: 3,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
