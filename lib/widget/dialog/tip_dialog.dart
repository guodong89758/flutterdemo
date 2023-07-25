import 'package:flutter/material.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../res/colors.dart';

//通用弹窗
class TipDialog extends Dialog {
  //标题
  final String? title;

  //提示内容
  final String? content;

  //按钮1
  final String? action;

  //圆角大小
  final double radius;
 final List<List>? list ;
 final bool isShow;
  //背景颜色
  @override
  final Color backgroundColor;

  final VoidCallback? onAction;

  const TipDialog(
      {Key? key,
      this.title,
      this.content,
      this.action,
      this.radius = 4,
      this.backgroundColor = Colours.white,
      this.onAction,this.isShow = false,this.list ,})
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
                Visibility(visible: !isShow, child:(content ?? '').isEmpty
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
                ), ),
                Visibility(visible: isShow, child:
                Container(
                  height: 500.h,
                  padding: EdgeInsets.fromLTRB(
                      20,
                      (title ?? '').isEmpty ? 35 : 15,
                      20,
                      (title ?? '').isEmpty ? 34 : 20),
                  child:  SingleChildScrollView(
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(list?.length ?? 0, (index) {
                        List array = list![index];
                        return Container(
                          alignment: Alignment.centerLeft, child:
                        Column(
                          mainAxisAlignment:  MainAxisAlignment.start,
                          children: [
                            if(index !=0)SizedBox(height: 15.h,),

                            Container( alignment:Alignment.centerLeft, child:Text(
                                array[0],
                                style: const TextStyle(
                                    color: Colours
                                        .text_color_2,
                                    fontSize:
                                    Dimens.font_sp14)) ,)
                            ,
                            SizedBox(height: 4.h,),
                            Container( alignment:Alignment.centerLeft, child:Text(
                                array[1],
                                style: const TextStyle(
                                    color: Colours
                                        .text_color_4,
                                    height: 1.5,
                                    fontSize:
                                    Dimens.font_sp12)) ,)
                            ,

                          ],),)
                         ;
                      }).toList(),
                    ),
                  ),
                ) ),

                Gaps.hLine,
                SizedBox(
                    width: ScreenHelper.screenWidth - ScreenHelper.height(75),
                    height: ScreenHelper.height(50),
                    child: TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colours.transparent),
                        alignment: Alignment.center,
                        minimumSize: MaterialStateProperty.all(
                            Size.fromHeight(ScreenHelper.height(50))),
                      ),
                      onPressed: onAction,
                      child: Text(action ?? '',
                          style: const TextStyle(
                              color: Colours.app_main,
                              fontSize: Dimens.font_sp16)),
                    ))
              ],
            ),
          )),
    );
  }
}
