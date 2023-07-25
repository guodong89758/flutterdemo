import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/ui/page/alert/alert_detail_page.dart';
import 'package:bitfrog/ui/page/alert/viewmodel/alert_detail_comment_model.dart';
import 'package:bitfrog/ui/page/alert/viewmodel/alert_detail_model.dart';
import 'package:bitfrog/ui/page/community/community_notice_list_page.dart';
import 'package:bitfrog/ui/page/community/community_square_index_page.dart';
import 'package:bitfrog/ui/view/base_view.dart';
import 'package:bitfrog/utils/bf_date_util.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/widget/behavior/over_scroll_behavior.dart';
import 'package:bitfrog/widget/dash_line.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:simple_html_css/simple_html_css.dart';

class AlertShareItem extends StatefulWidget {

  final String? id;

  final AlertShowTypes? type;
  AlertShareItem({Key? key,this.handleClick ,this.id,this.type = AlertShowTypes.historyDetail}) : super(key: key);
  final HandleClick? handleClick;
  final GlobalKey saveImageKey = GlobalKey();
  late AlertDetailCommonModel detailModels = AlertDetailCommonModel();
  @override
  State<AlertShareItem> createState() => _AlertShareItemState();

}


class _AlertShareItemState extends State<AlertShareItem> {
  late AlertDetailCommonModel detailModels;
  @override
  void initState() {
    detailModels =  AlertDetailCommonModel(id: widget.id,type: widget.type );
    detailModels.getAlertDetail( widget.id?? '');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<AlertDetailCommonModel>(
        model: detailModels,
        builder: (context, model, child)
        {
          return BaseView(
            viewState: model.viewState,
            clickRefresh: (){
              detailModels.clickRefresh(widget.id?? '');
            },
            child: Container(
              color: Colours.def_view_bg_3_color,
              child: Column(
                children: [
                  Container(
                    color: Colours.def_view_bg_3_color,
                    // padding: EdgeInsets.only(left: 15.w,bottom: 13.h),
                    child: Column(
                      children: [
                        Stack(
                          // fit: StackFit.expand,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(top: 50),

                                decoration: const BoxDecoration(
                                  color: Colours.def_view_bg_3_color,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colours.shadow2_color,
                                        offset: Offset(1, -1),
                                        blurRadius: 10.0)
                                  ],
                                ),
                                child: ScrollConfiguration(
                                    behavior: OverScrollBehavior(),
                                    child: SingleChildScrollView(
                                      child: RepaintBoundary(
                                          // key: saveImageKey,
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 0),
                                            width: ScreenHelper.screenWidth,
                                            color:
                                            Colours.def_view_bg_3_color,
                                            child: Stack(
                                              fit: StackFit.loose,
                                              children: [
                                                Image(
                                                    width: ScreenHelper
                                                        .screenHeight,
                                                    image: ImageUtil
                                                        .getAssetImage(Assets
                                                        .imagesShareHeadBg),
                                                    fit: BoxFit.cover),
                                                Column(
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .center,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    Container(
                                                        width: ScreenHelper
                                                            .screenWidth,
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            top: 50),
                                                        child:
                                                        // Text(
                                                        //     detailModels.detail
                                                        //         ?.title ??
                                                        //         '',
                                                        //     textAlign:
                                                        //     TextAlign.right,
                                                        //     style: const TextStyle(
                                                        //         color: Colours
                                                        //             .app_main,
                                                        //         fontSize: Dimens
                                                        //             .font_sp32,
                                                        //         fontWeight: FontWeight
                                                        //             .bold))),
                                                    Image(
                                                        height:
                                                        ScreenHelper
                                                            .width(
                                                            34),
                                                        image: ImageUtil.getAssetImage(
                                                            ImageUtil.getImageRes(
                                                                context)
                                                                .share_alert_title),
                                                        fit: BoxFit
                                                            .contain)),
                                                    Container(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 20),
                                                        margin:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            20,
                                                            30,
                                                            20,
                                                            50),
                                                        decoration:
                                                        BoxDecoration(
                                                          color:
                                                          Colours.white,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              6),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                                color: Colours
                                                                    .shadow_8_color,
                                                                offset:
                                                                Offset(
                                                                    1, 1),
                                                                blurRadius:
                                                                35.0,
                                                                spreadRadius:
                                                                1.5)
                                                          ],
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                          MainAxisSize
                                                              .min,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          children: [
                                                            SizedBox(
                                                              width: ScreenHelper
                                                                  .screenWidth -
                                                                  ScreenHelper
                                                                      .width(
                                                                      40),
                                                              height:
                                                              ScreenHelper
                                                                  .height(
                                                                  55),
                                                              child: Stack(
                                                                fit: StackFit
                                                                    .loose,
                                                                alignment:
                                                                AlignmentDirectional
                                                                    .centerStart,
                                                                children: [
                                                                  Image(
                                                                      height: ScreenHelper
                                                                          .width(
                                                                          23),
                                                                      image: ImageUtil
                                                                          .getAssetImage(
                                                                          ImageUtil
                                                                              .getImageRes(
                                                                              context)
                                                                              .share_alert_icon),
                                                                      fit: BoxFit
                                                                          .contain),
                                                                  Positioned(
                                                                      right:
                                                                      0,
                                                                      child: Text(
                                                                          BFDateUtil.formatDateStr(detailModels
                                                                              .detail
                                                                              ?.timestamp?.toInt()),
                                                                          textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                          style:  TextStyle(
                                                                              color: Colours
                                                                                  .text_color_4,
                                                                              fontSize: 14.sp)))
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              height:
                                                              ScreenHelper
                                                                  .height(
                                                                  2),
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child:
                                                              const DashLine(),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top:
                                                                  15),
                                                              child: Text(
                                                                  detailModels
                                                                      .detail
                                                                      ?.title ??
                                                                      '',
                                                                  style: const TextStyle(
                                                                      color: Colours
                                                                          .text_color_1,
                                                                      fontSize:
                                                                      Dimens
                                                                          .font_sp18,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                            ),
                                                            Flexible(
                                                                fit: FlexFit
                                                                    .loose,
                                                                child: Padding(
                                                                    padding:  EdgeInsets
                                                                        .only(top: 10,
                                                                        bottom: (detailModels.detail?.images?.length ?? 0)<=0 ? 50: 10),
                                                                    child: Builder(
                                                                        builder: (
                                                                            context) {
                                                                          return HTML
                                                                              .toRichText(
                                                                            context,
                                                                            detailModels
                                                                                .detail
                                                                                ?.content ??
                                                                                '',
                                                                            defaultTextStyle: TextStyle(
                                                                                color: Colours
                                                                                    .text_color_2,
                                                                                fontSize: Dimens
                                                                                    .font_sp15,
                                                                                fontWeight: FontWeight
                                                                                    .normal,
                                                                                height: detailModels
                                                                                    .detail
                                                                                    ?.type ==
                                                                                    'px_trigger'
                                                                                    ? 2.0
                                                                                    : 1.5),
                                                                          );
                                                                        }))),


                                                            Visibility(visible: (detailModels.detail?.images?.length ?? 0)<=0 ? false:true, child:
                                                              Column(children: [
                                                                ListView(
                                                                  shrinkWrap: true,
                                                                  physics: const NeverScrollableScrollPhysics(),
                                                                  children: List.generate(detailModels.detail.images?.length ?? 0, (index) {
                                                                    String item = detailModels.detail.images![index];
                                                                    return Container(

                                                                       padding:  EdgeInsets
                                                                        .only(
                                                                        bottom:8.h), child: CachedNetworkImage(

                                                                      fit: BoxFit.cover,
                                                                      fadeInDuration: const Duration(microseconds: 1),
                                                                      fadeOutDuration: const Duration(microseconds: 1),
                                                                      // width: ScreenHelper.width(width),
                                                                      // height: ScreenHelper.width(width),
                                                                      imageUrl:item,
                                                                      placeholder: (context, url) =>
                                                                          Image.asset(Assets.imagesBaseDefAvatar),
                                                                      errorWidget: (context, url, error) =>
                                                                          Image.asset(Assets.imagesBaseDefAvatar),
                                                                    ),)
                                                                      ;
                                                                  }).toList(),
                                                                )

                                                                // detailModels.detail.images.map((e) => imageView()).toList(),
                                                                // detailModels.detail.images.map((e) => CommunityNoticeListPage(type: "",)).toList(),
                                                                // (detailModels.detail?.images ?? []).map((e) => ).toList(),
                                                              ],),),
                                                            Container(
                                                              height:
                                                              ScreenHelper
                                                                  .height(
                                                                  2),
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child:
                                                              const DashLine(),
                                                            ),
                                                            Container(
                                                              color: Colours
                                                                  .white,
                                                              width: ScreenHelper
                                                                  .screenWidth,
                                                              height:
                                                              ScreenHelper
                                                                  .height(
                                                                  75),
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Row(
                                                                mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                                children: [
                                                                  Expanded(
                                                                      child:
                                                                      Column(
                                                                        mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                        children: [
                                                                          Text(
                                                                              detailModels
                                                                                  .detail
                                                                                  ?.bottomTips1 ??
                                                                                  '',
                                                                              style: const TextStyle(
                                                                                  color: Colours
                                                                                      .text_color_1,
                                                                                  fontSize: Dimens
                                                                                      .font_sp16,
                                                                                  fontWeight: FontWeight
                                                                                      .bold)),
                                                                          Padding(
                                                                              padding:
                                                                              const EdgeInsets
                                                                                  .only(
                                                                                  top: 4),
                                                                              child: Text(
                                                                                  detailModels
                                                                                      .detail
                                                                                      ?.bottomTips2 ??
                                                                                      '',
                                                                                  style: const TextStyle(
                                                                                      color: Colours
                                                                                          .text_color_4,
                                                                                      fontSize: Dimens
                                                                                          .font_sp11,
                                                                                      fontWeight: FontWeight
                                                                                          .normal))),
                                                                        ],
                                                                      )),
                                                                  QrImageView(
                                                                    padding: EdgeInsets.zero,
                                                                    data:detailModels
                                                                        .detail
                                                                        .qrCodeUrl ??
                                                                        '',
                                                                    version: QrVersions.auto,
                                                                    size: ScreenHelper.width(45),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )),
                                    ))),


                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }


}
