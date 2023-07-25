import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/logic/link_manger.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/assets/item/assets_classify_title_item.dart';
import 'package:bitfrog/ui/page/assets/item/number_animation_item.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/assets_copy_trade_model.dart';
import 'package:bitfrog/ui/page/copyTrade/item/copy_trade_mine_cueernt_item.dart';
import 'package:bitfrog/ui/page/copyTrade/model/copy_trade_mine_current_entity.dart';
import 'package:bitfrog/ui/page/mine/item/Line_view_item.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/widget/box_decorations.dart';
import 'package:bitfrog/widget/refresh/base_empty_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/ui/view/refresh_head_view.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssetsCopyTradePage extends StatefulWidget {

  const AssetsCopyTradePage({Key? key}) : super(key: key);

  @override
  State<AssetsCopyTradePage> createState() => _AssetsCopyTradePageState();
}

class _AssetsCopyTradePageState extends State<AssetsCopyTradePage>  with AutomaticKeepAliveClientMixin ,TickerProviderStateMixin {
  late AssetsCopyTradeModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = AssetsCopyTradeModel(this);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<AssetsCopyTradeModel>(
      model: viewModel,
      builder: (context, model, child) {
        return SafeArea(
          child: FBRefreshHeadView(
            viewState: viewModel.viewState,
            itemCount: model.dataList.length,
            onRefresh: () {
              model.refresh();
              viewModel.getCopyTradeInfo();
            },
            enablePullUp: false,
            onClickRefresh: model.clickRefresh,
            controller: model.controller,
            scrollController: model.scrollController,
            placeholderHeight: ScreenHelper.screenHeight / 2.0,
            placeholderWidth: ScreenHelper.screenWidth,
            emptyWidget: Container(
              child:
              Column(
                children: [
                  Gaps.getVGap(90),
                  SizedBox(
                    width: 70.w,
                    height: 110.w,
                    child: const BaseEmptyPage(),
                  ),
                  Gaps.getVGap(30),
                  InkWell(
                    onTap: (){
                      LinkManger.schemeJumpUrl("bitfrog://app.bitfrog.com/home/mainactivity?tab=follow");
                    },
                    child: Container(
                      height: 35.h,
                      width: 120.w,
                      decoration: BoxDecorations.cardBoxDecoration(color: Colours.app_main,radius: 2),
                      alignment: Alignment.center,
                      child: Text("去跟单",style: TextStyle(
                          color: Colours.white,
                          fontWeight: BFFontWeight.medium,
                          fontSize: 14.sp
                      ),),
                    ),
                  ),
                ],
              ),
            ),
            headView: _buildAssetsView(),
            itemBuilder: (BuildContext context, int index) {
              CopyTradeMineCurrentEntity copyTradeMineCurrentEntity = model.dataList[index];
              return CopyTradeMineCurrentItem(copyTradeMineCurrentEntity: copyTradeMineCurrentEntity,handleClick: (){
                viewModel.gotoDetail(context, copyTradeMineCurrentEntity);
              },);
            },
          ),
        );
      },
    );
  }


  Widget _buildAssetsView() {

    final unit = viewModel.copyTradeMineCurrentEntity?.currency == null
        ? ''
        : '(${viewModel.copyTradeMineCurrentEntity?.currency})';



    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "跟单资产(USDT)",
                        style: TextStyle(
                            color: Colours.text_color_4,
                            fontSize: 12.sp,
                            fontWeight: BFFontWeight.normal,
                            fontFamily: BFFontFamily.din),
                      ),
                      InkWell(
                        splashColor: Colours.white,
                        highlightColor: Colours.white,
                        onTap: () {
                          viewModel.hideAssets();
                        },
                        child: Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 7.5.w, vertical: 15.h),
                          child: Image(
                            width: 12.w,
                            height: 12.h,
                            image: ImageUtil.getAssetImage(viewModel.assetsVisible
                                ? Assets.imagesAssetsShow
                                : Assets.imagesAssetsHide),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text( "${S.current.base_update_time}${viewModel.copyTradeMineCurrentEntity?.updateTime ?? ""}",style: TextStyle(
                    color: Colours.text_color_4,
                    fontSize: 12.sp,
                    fontFamily: BFFontFamily.din
                  ),)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NumberAnimationItem(number: viewModel.copyTradeMineCurrentEntity?.followAsset ?? "0.0",
                      assetsVisible: viewModel.assetsVisible,
                      animationController: viewModel.btcController),
                  InkWell(
                    splashColor: Colours.white,
                    highlightColor: Colours.white,
                    onTap: () {
                      //跟单记录
                      Routers.navigateTo(context, Routers.assetsFollowRecord);
                    },
                    child: Container(
                      color: Colors.white,
                      padding:EdgeInsets.only(left: 10.w),
                      child: Image(
                        width: 20.w,
                        height: 20.h,
                        image: ImageUtil.getAssetImage(Assets.imagesCopyTradePosiitonBtn),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Visibility(
                    visible: viewModel.assetsVisible,
                      child: Padding(
                        padding:  EdgeInsets.only(right: 3.w),
                        child: Text("≈",style: TextStyle(
                        color: Colours.text_color_4,
                        fontSize: 12.sp,
                        fontWeight: BFFontWeight.medium,
                        fontFamily: BFFontFamily.din),),
                      )),
                  NumberAnimationItem(number: "0",
                      assetsVisible: viewModel.assetsVisible,
                      textStyle: TextStyle(
                          color: Colours.text_color_4,
                          fontSize: 12.sp,
                          fontWeight: BFFontWeight.medium,
                          fontFamily: BFFontFamily.din),
                      animationController: viewModel.priceController),
                  Visibility(
                      visible: viewModel.assetsVisible,
                      child: Padding(
                        padding:  EdgeInsets.only(left: 3.w),
                        child: Text("USDT",style: TextStyle(
                            color: Colours.text_color_4,
                            fontSize: 12.sp,
                            fontWeight: BFFontWeight.medium,
                            fontFamily: BFFontFamily.din),),
                      )),
                ],
              ),
            ],
          ),
        ),
        const LineViewItem(heightAll: 1,),
        Container(
          padding: EdgeInsets.only(left: 14.w,right: 14.w,top: 10.h,bottom: 10.h),
          child: Row(
            children: [
              _item("昨日收益(${unit})", viewModel.copyTradeMineCurrentEntity?.yesterdayProfit ?? "",),
              _item("持有收益(${unit})", viewModel.copyTradeMineCurrentEntity?.currentProfit ?? "",crossAxisAlignment: CrossAxisAlignment.center),
              _item("累计收益(${unit})", viewModel.copyTradeMineCurrentEntity?.totalProfit ?? "",crossAxisAlignment: CrossAxisAlignment.end),
            ],
          ),
        ),
        const LineViewItem(heightAll: 1,),
        Container(
          padding: EdgeInsets.only(left: 14.w,right: 14.w,top: 15.h,bottom: 15.h),
          alignment: Alignment.center,
          child: InkWell(
            onTap: (){
              LinkManger.schemeJumpUrl("bitfrog://app.bitfrog.com/home/mainactivity?tab=follow&type=current");
            },
            child: Container(
              height: 31.h,
              decoration: BoxDecorations.cardBoxDecoration(color: Colours.def_view_bg_1_color,radius: 2),
              alignment: Alignment.center,
              child: Text("跟单管理",style: TextStyle(
                color: Colours.text_color_2,
                fontWeight: BFFontWeight.medium,
                fontSize: 14.sp
              ),),
            ),
          ),
        ),

        const LineViewItem(),
        const AssetsClassifyTitleItem(title: "我的跟单",),
      ],
    );
  }

  Widget _item(String title,String content,{CrossAxisAlignment? crossAxisAlignment}){
    return Expanded(child: Container(
      child: Column(
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        children: [
          Text(title,style: TextStyle(
            color: Colours.text_color_4,
            fontSize: 11.sp
          ),),
          Gaps.getVGap(3),
          Text(content,style: TextStyle(
              color: Colours.text_color_2,
              fontSize: 14.sp,
            fontFamily: BFFontFamily.din,
            fontWeight: BFFontWeight.medium
          ),)
        ],
      ),
    ));
  }


}








