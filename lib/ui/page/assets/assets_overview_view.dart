import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/constant/config.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/assets/item/assets_account_item.dart';
import 'package:bitfrog/ui/page/assets/item/number_animation_item.dart';
import 'package:bitfrog/ui/page/assets/model/asserts_account_index_entity.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/assets_mine_overview_model.dart';
import 'package:bitfrog/ui/page/mine/item/Line_view_item.dart';
import 'package:bitfrog/ui/page/mine/viewModel/user_manger_model.dart';
import 'package:bitfrog/ui/view/base_view.dart';
import 'package:bitfrog/ui/view/exchange_image_item.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssetsOverviewView extends StatefulWidget {
  const AssetsOverviewView({Key? key, required this.userMangerProvider})
      : super(key: key);
  final UserMangerProvider userMangerProvider;

  @override
  State<AssetsOverviewView> createState() => _AssetsOverviewViewState();
}

class _AssetsOverviewViewState extends State<AssetsOverviewView>
    with TickerProviderStateMixin {
  late bool assetsVisible = false;
  late AnimationController priceController;

  late AssetsMineOverViewModel viewModel;

  void _navAssetsClassify({String tabName = ""}) {
    if (Routers.goLogin(context)) return;
    Parameters parameters = Parameters()..putString('defaultTabName', tabName);
    Routers.navigateTo(context, Routers.assetsClassify, parameters: parameters);
  }

  @override
  void initState() {
    super.initState();
    viewModel = AssetsMineOverViewModel();
    priceController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<AssetsMineOverViewModel>(
      model: viewModel,
      builder: (context, model, child) {
        return Column(
          children: [
            _buildAssetsView(),
            Visibility(
                visible: !widget.userMangerProvider.isLogin,
                child: _buildDefaultAccountView()),
            Visibility(
              visible: widget.userMangerProvider.isLogin,
              child: BaseView(
                viewState: viewModel.viewState,
                clickRefresh: viewModel.clickRefresh,
                height: 200.h,
                placeHoldTopHeight: 10.h,
                child: Column(
                  children: [_buildDefaultAccountView(), _buildApiCount()],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAssetsView() {
    return Container(
      padding: EdgeInsets.only(left: 14.w, right: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => _navAssetsClassify(),
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
                          S.of(context).assets_general_view,
                          style: TextStyle(
                              color: Colours.text_color_2,
                              fontSize: 14.sp,
                              fontWeight: BFFontWeight.medium,
                              fontFamily: BFFontFamily.din),
                        ),
                        InkWell(
                          splashColor: Colours.white,
                          highlightColor: Colours.white,
                          onTap: () {
                            if (Routers.goLogin(context)) return;
                            SpUtil.putBool(
                                Config.keyAssetsVisible, !assetsVisible);
                            setState(() {
                              assetsVisible = !assetsVisible;
                            });
                            if (assetsVisible) {
                              priceController.forward(from: 0);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 7.5.w, vertical: 12.h),
                            child: Image(
                              width: 12.w,
                              height: 12.h,
                              image: ImageUtil.getAssetImage(
                                  (widget.userMangerProvider.isLogin &&
                                          assetsVisible)
                                      ? Assets.imagesAssetsShow
                                      : Assets.imagesAssetsHide),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      Assets.imagesBaseArrowRight,
                      width: 15.w,
                      height: 15.w,
                    )
                  ],
                ),
                Text(
                  "总资产${viewModel.assertsAccountIndexEntity?.unit ?? ""}",
                  style: TextStyle(
                    color: Colours.text_color_4,
                    fontSize: 12.sp,
                  ),
                ),
                Gaps.vGap12,
                NumberAnimationItem(
                    number: viewModel.assertsAccountIndexEntity?.balance ?? "0",
                    assetsVisible:
                        (widget.userMangerProvider.isLogin && assetsVisible),
                    animationController: priceController),
                Gaps.vGap15,
              ],
            ),
          ),
          const LineViewItem(heightAll: 1),
        ],
      ),
    );
  }

  Widget _buildDefaultAccountView() {
    return Container(
      padding: EdgeInsets.only(left: 14.w, right: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AssetsAccountItem(
            icon: Image.asset(
              Assets.imagesAssetsVoice,
              width: 18.w,
              height: 18.w,
            ),
            title: S.of(context).assets_voice_account,
            count: viewModel.assertsAccountIndexEntity?.voiceBalance ?? "0",
            unit: S.of(context).voice_article,
            assetsVisible: (widget.userMangerProvider.isLogin && assetsVisible),
            handleClick: () {
              if (Routers.goLogin(context)) return;
              Routers.navigateTo(context, Routers.assetsVoice);
            },
          ),
          AssetsAccountItem(
            icon: Image.asset(
              Assets.imagesAssetsMoney,
              width: 18.w,
              height: 18.w,
            ),
            title: S.of(context).assets_fund_account,
            count: viewModel.assertsAccountIndexEntity?.spotBalance ?? "0",
            unit: viewModel.assertsAccountIndexEntity?.unit ?? "",
            assetsVisible: (widget.userMangerProvider.isLogin && assetsVisible),
            handleClick: () =>
                _navAssetsClassify(tabName: S.of(context).assets_tab_fund),
          ),
          AssetsAccountItem(
            icon: Image.asset(
              Assets.imagesAssetsCopyTrade,
              width: 18.w,
              height: 18.w,
            ),
            title: S.of(context).assets_follow_trade_account,
            count: viewModel.assertsAccountIndexEntity?.contractFollowBalance ??
                "0",
            assetsVisible: (widget.userMangerProvider.isLogin && assetsVisible),
            unit: viewModel.assertsAccountIndexEntity?.unit ?? "",
            handleClick: () => _navAssetsClassify(
                tabName: S.of(context).assets_tab_follow_trade),
          ),
        ],
      ),
    );
  }

  Widget _buildApiCount() {
    final apiList = viewModel.assertsAccountIndexEntity?.list;

    if (widget.userMangerProvider.isLogin &&
        apiList != null &&
        apiList.isNotEmpty) {
      List<Widget> items = [];
      for (ApiAccountEntity entity
          in viewModel.assertsAccountIndexEntity!.list!) {
        AssetsAccountItem assetsAccountItem = AssetsAccountItem(
          icon: ExchangeImageItem(width: 18.w, imageUrl: entity.icon ?? ""),
          title: entity.name ?? "",
          count: entity.value ?? "",
          unit: viewModel.assertsAccountIndexEntity?.unit ?? "",
          assetsVisible: assetsVisible,
          handleClick: () => _navAssetsClassify(tabName: entity.name ?? ""),
        );
        items.add(assetsAccountItem);
      }
      return Container(
        padding: EdgeInsets.only(left: 14.w, right: 14.w),
        child: Column(children: items),
      );
    }
    return Container();
  }
}
