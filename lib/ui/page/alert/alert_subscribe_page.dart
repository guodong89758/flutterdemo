import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/plugin/flutter_pigeon_plugin.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/ui/page/alert/alert_list_page.dart';
import 'package:bitfrog/ui/page/alert/alert_timeline_page.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/widget/box_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertSubscribePage extends StatefulWidget {
  const AlertSubscribePage({Key? key, required this.tab}) : super(key: key);
  final int? tab;

  @override
  State<AlertSubscribePage> createState() => _AlertSubscribePageState();
}

class _AlertSubscribePageState extends State<AlertSubscribePage> {
  bool isGrid = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /// 登录之后刷新
    Event.eventBus.on<UserLoginEvent>().listen((event) {
     if(!event.isLogin){
       isGrid = false;
       setState(() {

       });
     }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isGrid ? Colours.def_view_bg_1_color : Colours.white,
      child: Column(
        children: [
          Container(
            height: 35.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecorations.topLine(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  isGrid ? S.current.alert_text_1 : S.current.alert_text_2,
                  style:
                      TextStyle(color: Colours.text_color_4, fontSize: 12.sp),
                ),

                Visibility(visible: FlutterPigeonPlugin.instance.isLogin(), child: Container(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isGrid = !isGrid;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 35.h,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.current.alert_text_3,
                            style: TextStyle(
                                color: Colours.text_color_4, fontSize: 12.sp),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Image(
                            width: 12.w,
                            height: 12.h,
                            image: ImageUtil.getAssetImage(
                                isGrid ? Assets.imagesAlertListSwitch : Assets.imagesAlertGridSwitch))
                      ],
                    ),
                  ),
                ) )

              ],
            ),
          ),
          Expanded(
            child: isGrid
                ? AlertListPage(tab: widget.tab ?? 0)
                : const AlertTimeLinePage(),
          )
        ],
      ),
    );
  }
}
