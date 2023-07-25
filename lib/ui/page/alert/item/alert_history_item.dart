import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/model/alert_history_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_html_css/simple_html_css.dart';

class AlertHistoryItem extends StatelessWidget {
  final int? index;
  final int? count;
  final History item;

  const AlertHistoryItem({Key? key, this.index, this.count, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Routers.navigateTo(context, Routers.alertDetailPage,
            parameters: Parameters()..putString('id', item.id ?? ''));
      },
      child: SizedBox(
        width: double.infinity,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 33.w,
                height: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Opacity(
                      // 修改透明度实现隐藏，类似于invisible
                      opacity: index == 0 ? 0.0 : 1.0,
                      child: SizedBox(
                        height: ScreenHelper.height(15),
                        child: VerticalDivider(
                          width: 2.w,
                          thickness: 2.w,
                          color: Colours.msg_line_color,
                        ),
                      ),
                    ),
                    Image(
                      width: 8.w,
                      height: 8.h,
                      image:
                          ImageUtil.getAssetImage(Assets.imagesBasePointGray),
                    ),
                    Expanded(
                        child: Opacity(
                            // 修改透明度实现隐藏，类似于invisible
                            opacity: index == count! - 1 ? 0.0 : 1.0,
                            child: SizedBox(
                              height: double.infinity,
                              child: VerticalDivider(
                                width: 2.w,
                                thickness: 2.w,
                                color: Colours.msg_line_color,
                              ),
                            )))
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: double.infinity,
                  padding: EdgeInsets.fromLTRB(0, 10.h, 14.w, 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(item.createTime ?? '',
                          style: TextStyle(
                              color: Colours.text_color_4, fontSize: 14.sp)),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(top: 10.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 15.h),
                        decoration: BoxDecoration(
                          color: Colours.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: const [
                            BoxShadow(
                                color: Colours.shadow_color,
                                offset: Offset(1, 1),
                                blurRadius: 7.0,
                                spreadRadius: 1)
                          ],
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                color: Colors.white,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    // Image(
                                    //   image: ImageUtil.getImageProvider(
                                    //       item.icon ?? '',
                                    //       holderImg: Assets.imagesAlertDefault),
                                    //   width: ScreenHelper.width(16),
                                    //   height: ScreenHelper.height(16),
                                    // ),
                                    Text(item.title ?? '',
                                        style: const TextStyle(
                                            color: Colours.text_color_2,
                                            fontSize: Dimens.font_sp14,
                                            fontWeight: BFFontWeight.medium)),
                                    SizedBox(
                                      // height: ScreenHelper.height(15),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Visibility(
                                              // 默认为占位替换，类似于gone
                                              visible: item.voicePush == 1,
                                              child: Container(
                                                // height: 20.h,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4.w),
                                                decoration: BoxDecoration(
                                                  color: item.voiceStatus == 3
                                                      ? Colours.def_yellow_10
                                                      : Colours
                                                          .def_view_bg_1_color,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1.5),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            right: 4.w),
                                                        child: Image(
                                                          image: ImageUtil.getAssetImage(
                                                              item.voiceStatus ==
                                                                      3
                                                                  ? Assets
                                                                      .imagesAlertPhoneYellow
                                                                  : Assets
                                                                      .imagesAlertPhoneGray),
                                                          width: 15.w,
                                                          height: 15.w,
                                                        )),
                                                    Flexible(
                                                      fit: FlexFit.loose,
                                                      child: Text(
                                                          item.voiceStatusDesc ??
                                                              '',
                                                          style: TextStyle(
                                                              color: item.voiceStatus ==
                                                                      3
                                                                  ? Colours
                                                                      .def_yellow
                                                                  : Colours
                                                                      .text_color_3,
                                                              fontSize: 11.sp)),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          Visibility(
                                              // 默认为占位替换，类似于gone
                                              visible: item.appPush == 1,
                                              child: Container(
                                                height: 15.w,
                                                width: 15.w,
                                                margin:
                                                    EdgeInsets.only(left: 7.w),
                                                child: Image(
                                                  image: ImageUtil
                                                      .getAssetImage(Assets
                                                          .imagesAlertAppGray),
                                                ),
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Expanded(
                                  child: HTML.toRichText(
                                context,
                                item.content ?? '',
                                defaultTextStyle: TextStyle(
                                  color: Colours.text_color_2,
                                  fontSize: Dimens.font_sp13,
                                  fontWeight: FontWeight.normal,
                                  height: item.type == 'px_trigger' ? 2.0 : 1.5,
                                ),
                              )),
                            ]),
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
