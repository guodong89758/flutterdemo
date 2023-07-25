import 'package:bitfrog/constant/config.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/assets/item/number_animation_item.dart';
import 'package:bitfrog/ui/page/assets/item/spot_account_item.dart';
import 'package:bitfrog/ui/page/assets/model/assets_info_entity.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/assets_capital_model.dart';
import 'package:bitfrog/ui/page/mine/item/Line_view_item.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/ui/view/refresh_head_view.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssetsCapitalPage extends StatefulWidget {

  const AssetsCapitalPage({Key? key}) : super(key: key);

  @override
  State<AssetsCapitalPage> createState() => _AssetsCapitalPageState();
}

class _AssetsCapitalPageState extends State<AssetsCapitalPage>  with AutomaticKeepAliveClientMixin ,TickerProviderStateMixin {
  late AssetsCapitalModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = AssetsCapitalModel(this);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<AssetsCapitalModel>(
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
            header: Container(),
            headView: _buildAssetsView(),
            itemBuilder: (BuildContext context, int index) {

              SpotEntity item =
                  model.dataList[index];
              bool assetsVisible = SpUtil.getBool(Config.keyAssetsVisible) ?? true;
              return CapitalAccountItem(item: item, assetsVisible:assetsVisible);

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
                  InkWell(
                    splashColor: Colours.white,
                    highlightColor: Colours.white,
                    onTap: () {
                      //资金记录
                      Routers.navigateTo(context, Routers.assetsSpotRecord);
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
              NumberAnimationItem(number: viewModel.infoData?.balance?.btcAmount ?? '0',
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
                  NumberAnimationItem(number: viewModel.infoData?.balance?.unitAmount ?? '0',
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
                        child: Text(viewModel.infoData?.unit ?? '',style: TextStyle(
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
                            //充值
                            Routers.navigateTo(context, Routers.assetsDeposit);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 35.h,
                            decoration: const BoxDecoration(
                              color: Colours.app_main,
                              borderRadius: BorderRadius.all(
                                Radius.circular(2),
                              ),
                            ),
                            child: Text(S.current.action_deposit,
                                style: TextStyle(
                                    color: Colours.white,
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
                ],
              ),
            ],
          ),
        ),
        const LineViewItem(),
      ],
    );
  }


}








