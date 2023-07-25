import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/ui/page/firmOffer/accessFirmOffer/view/firm_offer_access_subscribe_view.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef mycallBack = Function(num type,   bool selected ,
bool selected1 ,
bool selected2 );

class TypeQuotationWidget extends StatefulWidget {
  final mycallBack myCallBack;
  late bool selected ;
  late bool selected1 ;
  late bool selected2 ;
   TypeQuotationWidget({
    super.key,
    required this.myCallBack,
    this.selected = true,
  this.selected1  = false,
    this.selected2 = false,
  });

  @override
  _TypeQuotationWidgetState createState() => _TypeQuotationWidgetState();
}

class _TypeQuotationWidgetState extends State<TypeQuotationWidget> {

  num public = 1;
  num all = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: 3,
              // padding: const EdgeInsets.symmetric(horizontal: 14),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //设置列数
                crossAxisCount: 3,
                //设置横向间距
                crossAxisSpacing: 13.h,
                //设置主轴间距
                mainAxisSpacing: 13.w,
                childAspectRatio: 109 / 35,
              ),
              itemBuilder: (context, position) {
                if (position == 0) {
                  return chooseView(
                      widget.selected, S.current.firm_offer_alarm_channel_1, 0);
                } else if (position == 1) {
                  return chooseView(widget.selected1, S.current.alert_app_strong, 1);
                } else {
                  return chooseView(widget.selected2, S.current.trading_view_text2, 2);
                }
              }),
        ),
      ],
    );
  }

  Widget chooseView(bool selecteds, String title, int value) {
    return InkWell(
        onTap: () {
          onPressed(value);
        },
        child: Container(
          decoration: BoxDecoration(
            color: selecteds ? Colours.def_green_11 : Colours.white,
            borderRadius: const BorderRadius.all(Radius.circular(2)),
            border: Border.all(
                width: 1,
                color: selecteds ? Colours.app_main : Colours.def_line_1_color),
          ),
          // width: 168.w,
          // height: 60.h,
          // margin: EdgeInsets.only(top: 40.h),
          alignment: Alignment.center,
          child: Stack(
            children: [
              Positioned(
                right: 0.w,
                top: 0.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: selecteds,
                      child: Image.asset(
                        Assets.imagesFirmAccessPublick,
                        width: 15.r,
                        height: 15.r,
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                            selecteds ? Colours.app_main : Colours.text_color_2,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void onPressed(int count) {
    setState(() {

      if (count == 0) {
        if(widget.selected ==true){

        }
        // widget.selected = !widget.selected;


      } else if (count == 1) {
        widget. selected1 =! widget.selected1;
      }else {

        widget.selected2 =! widget.selected2;
      }

      widget.myCallBack(count, widget.selected,widget.selected1,widget.selected2);
    });
  }
}
