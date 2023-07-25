import 'package:bitfrog/ui/page/mine/item/Line_view_item.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/utils/screen_helper.dart';

import '../../generated/l10n.dart';
import '../../res/colors.dart';

//通用弹窗
class CommonDialog extends Dialog {
  //标题
  final String? title;

  //提示内容
  final String? content;

  //按钮1
  final String? action1;

  //按钮2
  final String? action2;

  //圆角大小
  final double radius;

  final  bool isLongLine;
  //背景颜色
  @override
  final Color backgroundColor;

  final VoidCallback? onCancel;
  final VoidCallback? onAction;

  const CommonDialog(
      {Key? key,
      this.title,
      this.content,
      this.action1,
      this.action2,
      this.radius = 4,
      this.backgroundColor = Colours.white,
      this.onCancel,
      this.onAction,this.isLongLine = false})
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
            decoration: ShapeDecoration(
              color: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(radius),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: (title ?? '').isEmpty
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              crossAxisAlignment: (title ?? '').isEmpty
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                (title ?? '').isEmpty
                    ? Gaps.empty
                    : Padding(
                        padding: const EdgeInsets.only(left: 20, top: 15),
                        child: Text(title!,
                            style: const TextStyle(
                                fontSize: Dimens.font_sp17,
                                color: Colours.text_color_2,
                                fontWeight: FontWeight.bold)),
                      ),
                (content ?? '').isEmpty
                    ? Gaps.empty
                    : Padding(
                        padding: EdgeInsets.fromLTRB(
                            20,
                            (title ?? '').isEmpty ? 35 : 15,
                            20,
                            (title ?? '').isEmpty ? 34 : 20),
                        child: Text(content!,
                            textAlign: (title ?? '').isEmpty
                                ? TextAlign.center
                                : TextAlign.left,
                            style: TextStyle(
                                fontSize: (title ?? '').isEmpty
                                    ? Dimens.font_sp15
                                    : Dimens.font_sp14,
                                color: (title ?? '').isEmpty
                                    ? Colours.text_color_2
                                    : Colours.text_color_3)),
                      ),
                const LineViewItem(
                  heightAll: 1,
                  color: Colours.def_line_1_color,
                ),
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
                          child: Text(action1 ?? S.current.action_cancel,
                              style: const TextStyle(
                                  color: Colours.dynamic_tab_text_nor_color,
                                  fontSize: Dimens.font_sp16)),
                        )),
                        SizedBox(
                          height:  isLongLine? ScreenHelper.height(50): ScreenHelper.height(25),
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
                          child: Text(action2 ?? '',
                              style: const TextStyle(
                                  color: Colours.app_main,
                                  fontSize: Dimens.font_sp16)),
                        ))
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}
