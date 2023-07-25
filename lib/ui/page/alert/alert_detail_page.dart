import 'dart:ui';

import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/alert/item/alert_share_item.dart';
import 'package:bitfrog/ui/page/community/common_share_page.dart';
import 'package:bitfrog/utils/share_util.dart';
import 'package:bitfrog/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/plugin/flutter_pigeon_plugin.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/ui/page/alert/viewmodel/alert_detail_model.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/widget/behavior/over_scroll_behavior.dart';
import 'package:bitfrog/widget/dash_line.dart';
import 'package:bitfrog/widget/refresh/base_empty_page.dart';
import 'package:bitfrog/widget/refresh/base_loading_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'dart:ui' as ui;

///历史提醒详情页面
class AlertDetailPage extends StatefulWidget {
  final String? id;
  final AlertShowTypes? type;
  const AlertDetailPage({Key? key, this.id,this.type = AlertShowTypes.historyDetail}) : super(key: key);

  @override
  State<AlertDetailPage> createState() => _AlertDetailPageState();
}
enum AlertShowTypes { historyDetail, noticeDetail, eventDetail}
class _AlertDetailPageState extends State<AlertDetailPage>
    with
        BasePageMixin<AlertDetailPage>,
        AutomaticKeepAliveClientMixin<AlertDetailPage>,
        SingleTickerProviderStateMixin {
  // late AlertDetailModel _detailModel;
  final GlobalKey saveImageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: MyAppBar(
          title: S.current.action_share,
          onBack: _onWillPop,
        ),
        body: Container(
            decoration:
            const BoxDecoration(color: Colours.def_view_bg_3_color),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child:  SingleChildScrollView (  child:RepaintBoundary(
                key: saveImageKey,
                child:    Column(children: [AlertShareItem(id: widget.id,type:widget.type)],)),)) ,
              Container(
                padding: EdgeInsets.only(bottom:20.h ),
                decoration: const BoxDecoration(
                  color: Colours.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colours.shadow2_color,
                        offset: Offset(0, -1),
                        blurRadius: 10.0)
                  ],
                ),
                child:
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          sharePhoto();

                        },
                        style: ButtonStyle(
                          overlayColor:
                          MaterialStateProperty.all(
                              Colours.transparent),
                          alignment: Alignment.center,
                          minimumSize: MaterialStateProperty
                              .all(Size(
                              ScreenHelper.screenWidth,
                              ScreenHelper.height(55))),
                        ),
                        child: Text(
                            S.current.action_quick_share,
                            style: const TextStyle(
                                color: Colours.text_color_1,
                                fontSize:
                                Dimens.font_sp16))),
                    Container(
                      width: ScreenHelper.screenWidth,
                      height: ScreenHelper.height(8),
                      color:
                          Colours.def_view_bg_3_color,
                    ),
                    TextButton(
                        onPressed: _onWillPop,
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(
                                  Colours.transparent),
                          alignment: Alignment.center,
                          minimumSize:
                              MaterialStateProperty.all(
                                  Size(
                                      ScreenHelper
                                          .screenWidth,
                                      ScreenHelper
                                          .height(55))),
                        ),
                        child: Text(
                            S.current.action_cancel,
                            style: const TextStyle(
                                color: Colours
                                    .text_color_4,
                                fontSize:
                                    Dimens.font_sp16))),
                  ],
                ),

              )
            ],)
           ));

  }

  @override
  bool get wantKeepAlive => true;



  Future<bool> _onWillPop() {
    Routers.goBack(context);
    return Future.value(false);
  }

  void sharePhoto() async {
    ToastUtil.showRequest();
    Uint8List uint8list = await _capturePng();
    ToastUtil.cancelToast();
    XFile xFile =
    XFile.fromData(uint8list, mimeType: "image/png", name: "share.jpg");
    ShareUtil().shareImage(xFile);
  }

  Future<Uint8List> _capturePng() async {
    try {
      RenderRepaintBoundary? boundary = saveImageKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      if (boundary != null) {
        double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
        var image = await boundary.toImage(pixelRatio: dpr);
        // 将image转化成byte
        ByteData? byteData =
        await image.toByteData(format: ImageByteFormat.png);
        Uint8List? pngBytes = byteData?.buffer.asUint8List();
        return pngBytes ?? Uint8List(10);
      }
      return Uint8List(10);
    } catch (e) {
      return Uint8List(10);
    }
  }
}
