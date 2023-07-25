import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/ui/page/assets/model/access_trader_account_entity.dart';
import 'package:bitfrog/ui/page/firmOffer/accessFirmOffer/view/firm_offer_access_subscribe_view.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef mycallBack = Function(int type);

// ignore: must_be_immutable
class AccessTraderWidget extends StatefulWidget {
  final mycallBack myCallBack;
  final List <AccountTypeEntity>? list;
  final List <ExchangeEntity>? listEntity ;
  final bool hideRebate;
  const AccessTraderWidget({
    this.hideRebate = true,
     this.list ,
     this.listEntity,
    super.key,
    required this.myCallBack,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AccessTraderWidgetState createState() => _AccessTraderWidgetState();
}

class _AccessTraderWidgetState extends State<AccessTraderWidget> {
  num public = 1;
  num all = 1;
  num selectIndex = 0;


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
              itemCount: widget.hideRebate ? widget.list?.length:widget.listEntity?.length ,
              // padding: const EdgeInsets.symmetric(horizontal: 14),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //设置列数
                crossAxisCount: 2,
                //设置横向间距
                crossAxisSpacing: 13.h,
                //设置主轴间距
                mainAxisSpacing: 13.w,
                childAspectRatio: 157 / 38,
              ),
              itemBuilder: (context, position) {
                bool type = false;
                if (position == selectIndex) {
                  type = true;
                }

                String titles = '';
                String des = '';
                String imageUrl = '';
                if(widget.hideRebate){

                  AccountTypeEntity itemEntity = widget.list?[position] ?? AccountTypeEntity();
                  titles = itemEntity.title ?? '';

                }else{
                  ExchangeEntity itemEntity = widget.listEntity?[position] ?? ExchangeEntity();
                  titles = itemEntity?.exchange ?? '';
                  des = itemEntity?.tip ?? '';
                  imageUrl = itemEntity?.exchangeIcon ?? '';
                }
                return chooseViews(type,titles , position,widget.hideRebate,des,imageUrl);

              }),
        ),
      ],
    );
  }

  Widget chooseViews(bool selecteds, String title, int value,bool hideRightTop,String des,String imageUrlStr) {
    return Container(
      height: 35.h,
      child: InkWell(
        onTap: () {
          onPressed(value);
        },
        child: Container(
            decoration: BoxDecoration(

              color: selecteds ? Colours.def_green_11 : Colours.white,
              borderRadius: const BorderRadius.all(Radius.circular(2)),
              border: Border.all(
                  width: 1,
                  color:
                  selecteds ? Colours.app_main : Colours.def_line_1_color),
            ),
            // width: 168.w,
            // height: 30.h,
            // margin: EdgeInsets.only(top: 40.h),
            alignment: Alignment.center,
            child: Stack(
              children: [
                Visibility(visible: !hideRightTop, child:Positioned(
                  right: 0.w,
                  top: 0.w,
                  child: Container(
                      height: 13.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: ImageUtil.getAssetImage(
                                Assets.imagesTraderRebate),
                            fit: BoxFit.cover),
                      ),
                      child:
                      Container(
                        padding: EdgeInsets.only(left: 15.w,right: 5),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              des,
                              style: TextStyle(
                                  color: Colours.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500),
                            ),

                          ],
                        ) ,)


                  ),


                ), ),

        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(visible: !hideRightTop, child: Row(children: [
                // Image.asset(
                //   Assets.imagesBaseDefAvatar,
                //   width: ScreenHelper.width(14),
                //   height: ScreenHelper.width(14),
                // ),
                CachedNetworkImage(
                  width: ScreenHelper.width(14),
                  height: ScreenHelper.width(14),
                  imageUrl: imageUrlStr,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Image.asset(Assets.imagesBaseDefAvatar),
                  errorWidget: (context, url, error) =>
                      Image.asset(Assets.imagesBaseDefAvatar),
                ),
                SizedBox(
                  width: 4.w,
                ),
              ],) ),

              Text(
                title,
                style: TextStyle(
                    color: Colours.text_color_2,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0.w,
          bottom: 0.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: selecteds,
                child: GestureDetector(
                  child: Image.asset(
                    Assets.imagesAlertChooseSymbolS,
                    width: ScreenHelper.width(14),
                    height: ScreenHelper.width(14),
                  ),
                ),
              )
            ],
          ),
        ),
        ],
      ),
    )),
    );
  }

  void onPressed(int count) {
    setState(() {
      selectIndex = count;
      widget.myCallBack(count);
    });
  }
}
