import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/assets/item/assets_account_item.dart';
import 'package:bitfrog/ui/page/assets/item/assets_classify_title_item.dart';
import 'package:bitfrog/ui/page/assets/item/number_animation_item.dart';
import 'package:bitfrog/ui/page/assets/model/asserts_account_index_entity.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/assets_overview_model.dart';
import 'package:bitfrog/ui/page/copyTrade/item/share_trade_current_item.dart';
import 'package:bitfrog/ui/page/copyTrade/model/share_trade_data_entity.dart';
import 'package:bitfrog/ui/page/mine/item/Line_view_item.dart';
import 'package:bitfrog/ui/view/exchange_image_item.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/widget/box_decorations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/ui/view/refresh_head_view.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssetsOverViewPage extends StatefulWidget {

  const AssetsOverViewPage({Key? key,
    this.assertsAccountIndexEntity,
    this.valueChangedIndex
  }) : super(key: key);
  final AssertsAccountIndexEntity? assertsAccountIndexEntity;
  final ValueChanged<int>? valueChangedIndex;

  @override
  State<AssetsOverViewPage> createState() => _AssetsOverViewPageState();
}

class _AssetsOverViewPageState extends State<AssetsOverViewPage>  with AutomaticKeepAliveClientMixin ,TickerProviderStateMixin {
  late AssetsOverviewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = AssetsOverviewModel(this);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<AssetsOverviewModel>(
      model: viewModel,
      builder: (context, model, child) {
        return SafeArea(
          child: FBRefreshHeadView(
            viewState: model.viewState,
            itemCount: model.dataList.length,
            onRefresh: () {
              model.refresh();
            },
            enablePullUp: false,
            onLoadMore: model.loadMore,
            onClickRefresh: model.clickRefresh,
            controller: model.controller,
            scrollController: model.scrollController,
            placeholderHeight: ScreenHelper.screenHeight / 2.0,
            placeholderWidth: ScreenHelper.screenWidth,
            emptyWidget: Container(
              margin: EdgeInsets.only(top: 60.h),
              child: CupertinoButton(
                onPressed: (){
                  Routers.navigateTo(context, Routers.accessTraderAccountPage);
                },
                child: Container(
                  decoration: BoxDecorations.outLineDecoration(
                      borderColor: Colours.def_line_1_color,
                    radius: 17.5.h
                  ),
                  width: 170.w,
                  height: 35.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add,color: Colours.text_color_3,),
                      Gaps.hGap4,
                      Text("接入交易账户",style: TextStyle(
                        color: Colours.text_color_3,
                        fontSize: 14.sp,
                        fontWeight: BFFontWeight.medium
                      ),),
                    ],
                  ),
                ),
              ),
            ),
            header: Container(),
            headView: _buildAssetsView(),
            itemBuilder: (BuildContext context, int index) {
              ApiAccountEntity apiAccountEntity = model.dataList[index];
              return  Padding(
                padding: EdgeInsets.only(left: 14.w,right: 14.w),
                child: AssetsAccountItem(
                  icon: ExchangeImageItem(width: 18.w, imageUrl: apiAccountEntity.icon ?? ""),
                  title: apiAccountEntity.name ?? "",
                  count: apiAccountEntity.value ?? "",
                  unit: viewModel.assertsAccountIndexEntity?.unit ?? "",
                  assetsVisible: viewModel.assetsVisible,
                  handleClick: (){
                    widget.valueChangedIndex?.call(3+index);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }


  Widget _buildAssetsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    S.current.asset_total_subtitle,
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
              NumberAnimationItem(number: viewModel.assertsAccountIndexEntity?.balance ?? "0",
                  assetsVisible: viewModel.assetsVisible,
                  animationController: viewModel.btcController),
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
                  NumberAnimationItem(number: viewModel.assertsAccountIndexEntity?.balanceBtc ?? "0",
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
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            //接入账户
                            Routers.navigateTo(context, Routers.accessTraderAccountPage);

                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 35.h,
                            decoration: const BoxDecoration(
                              color: Colours.def_green,
                              borderRadius: BorderRadius.all(
                                Radius.circular(2),
                              ),
                            ),
                            child: Text("接入账户",
                                style: TextStyle(
                                    color: Colours.white,
                                    fontSize: 14.sp,
                                    fontWeight: BFFontWeight.medium)),
                          ))),
                  Gaps.getHGap(7),
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            //充值
                            Routers.navigateTo(context, Routers.assetsDeposit);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 35.h,
                            decoration: const BoxDecoration(
                              color: Colours.def_view_bg_1_color,
                              borderRadius: BorderRadius.all(
                                Radius.circular(2),
                              ),
                            ),
                            child: Text(S.current.action_deposit,
                                style: TextStyle(
                                    color: Colours.text_color_2,
                                    fontSize: 14.sp,
                                    fontWeight: BFFontWeight.medium)),
                          ))),
                  Gaps.getHGap(7),
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            //提现
                            Routers.navigateTo(context, Routers.assetsWithdraw);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 35.h,
                            decoration: const BoxDecoration(
                              color: Colours.def_view_bg_1_color,
                              borderRadius: BorderRadius.all(
                                Radius.circular(2),
                              ),
                            ),
                            child: Text(S.current.action_withdraw,
                                style: TextStyle(
                                    color: Colours.text_color_2,
                                    fontSize: 14.sp,
                                    fontWeight: BFFontWeight.medium)),
                          ))),
                  Gaps.getHGap(7),
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            //划转
                            Routers.navigateTo(context, Routers.assetsTransfer);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 35.h,
                            decoration: const BoxDecoration(
                              color: Colours.def_view_bg_1_color,
                              borderRadius: BorderRadius.all(
                                Radius.circular(2),
                              ),
                            ),
                            child: Text("划转",
                                style: TextStyle(
                                    color: Colours.text_color_2,
                                    fontSize: 14.sp,
                                    fontWeight: BFFontWeight.medium)),
                          )))
                ],
              ),
              Gaps.vGap15,
            ],
          ),
        ),
        const LineViewItem(),
        const AssetsClassifyTitleItem(title: "账户分布",),
        Container(
          padding: EdgeInsets.only(left: 14.w,right: 14.w),
          child: Column(
            children: [
              AssetsAccountItem(
                  icon: Image.asset(Assets.imagesAssetsVoice,width: 18.w,height: 18.w,),
                  title: "语音账户",
                  count: viewModel.assertsAccountIndexEntity?.voiceBalance ?? "0",
                  unit: "条",
                  assetsVisible: viewModel.assetsVisible,
                  handleClick: () {
                    Routers.navigateTo(context, Routers.assetsVoice);
                  },
                padding: EdgeInsets.only(top: 18.h,bottom: 18.h),
              ),
              AssetsAccountItem(
                  padding: EdgeInsets.only(top: 18.h,bottom: 18.h),
                  icon: Image.asset(Assets.imagesAssetsMoney,width: 18.w,height: 18.w,),
                  title: "资金账户",
                  assetsVisible: viewModel.assetsVisible,
                  count: viewModel.assertsAccountIndexEntity?.spotBalance ?? "0",
                  unit: viewModel.assertsAccountIndexEntity?.unit ?? "",
                  handleClick: () {
                    widget.valueChangedIndex?.call(1);
                  }
              ),
              AssetsAccountItem(
                  padding: EdgeInsets.only(top: 18.h,bottom: 18.h),
                  icon: Image.asset(Assets.imagesAssetsCopyTrade,width: 18.w,height: 18.w,),
                  title: "跟单账户",
                  assetsVisible: viewModel.assetsVisible,
                  count: viewModel.assertsAccountIndexEntity?.contractFollowBalance ?? "0",
                  unit: viewModel.assertsAccountIndexEntity?.unit ?? "",
                  handleClick: () {
                    widget.valueChangedIndex?.call(2);
                  }),
            ],
          ),
        )
      ],
    );
  }


}








