import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/l10n.dart';
import '../../res/colors.dart';

//推送测试弹窗
class TestDialog extends Dialog {
  //head图片
  final String? image;

  //提示内容
  final String? content;

  final VoidCallback? onCancel;
  final VoidCallback? onAction;

  const TestDialog(
      {Key? key, this.image, this.content, this.onCancel, this.onAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
          alignment: Alignment.center,
          child: Container(
            width: ScreenHelper.screenWidth - ScreenHelper.height(75),
            margin: const EdgeInsets.symmetric(horizontal: 37.5),
            decoration: const ShapeDecoration(
              color: Colours.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                    width: ScreenHelper.screenWidth - 75.h,
                    height: (ScreenHelper.screenWidth - 75.h) * 23 / 60,
                    image: ImageUtil.getAssetImage(
                        image ?? Assets.imagesPushTestHead),
                    fit: BoxFit.fill),
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Text(
                      content ?? '',
                      style: TextStyle(
                          fontSize: 14.sp, color: Colours.text_color_2),
                    )),
                Gaps.hLine,
                SizedBox(
                    height: ScreenHelper.height(50),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: TextButton(
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colours.transparent),
                            alignment: Alignment.center,
                            minimumSize: MaterialStateProperty.all(
                                Size.fromHeight(ScreenHelper.height(50))),
                          ),
                          onPressed: onCancel,
                          child: Text(S.current.action_ignore,
                              style: TextStyle(
                                  color: Colours.text_color_4,
                                  fontSize: 16.sp)),
                        )),
                        SizedBox(
                          height: 50.h,
                          child: VerticalDivider(
                            width: ScreenHelper.width(0),
                            thickness: ScreenHelper.width(1),
                            color: Colours.def_line_1_color,
                          ),
                        ),
                        Expanded(
                            child: TextButton(
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colours.transparent),
                            alignment: Alignment.center,
                            minimumSize: MaterialStateProperty.all(
                                Size.fromHeight(ScreenHelper.height(50))),
                          ),
                          onPressed: onAction,
                          child: Text(S.current.push_setup_text_6,
                              style: TextStyle(
                                  color: Colours.app_main, fontSize: 16.sp)),
                        ))
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}
